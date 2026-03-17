import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons';
import { Button, Card, Form, Input, Modal, Space, Table, Typography, message } from 'antd';
import { useEffect, useState } from 'react';
import { createBuilding, deleteBuilding, getBuildings, updateBuilding } from '../../api/rooms';
import type { Building } from '../../types';

// helper function to read a backend error message when it exists
function getErrorMessage(error: unknown, fallback: string) {
  if (typeof error === 'object' && error !== null && 'response' in error) {
    const response = (error as { response?: { data?: { detail?: string } } }).response;
    if (response?.data?.detail) {
      return response.data.detail;
    }
  }

  return fallback;
}

// page for admins to create, edit, and delete building records
export default function BuildingManagementPage() {
  // keep the table data, modal state, and current editing record
  const [buildings, setBuildings] = useState<Building[]>([]);
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<Building | null>(null);
  const [form] = Form.useForm();

  // load the latest building list from the backend
  const loadData = async () => {
    setLoading(true);
    try {
      const data = await getBuildings();
      setBuildings(data);
    } catch {
      message.error('Failed to load buildings');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void loadData();
  }, []);

  // build small summary numbers for the page hero
  const campusAreaCount = new Set(buildings.map((item) => item.campus_area).filter(Boolean)).size;
  const openingHoursCount = buildings.filter((item) => item.opening_hours).length;


  // open the modal in create mode
  const openCreate = () => {
    setEditing(null);
    form.resetFields();
    setOpen(true);
  };

  // open the modal in edit mode and fill the form with the selected building
  const openEdit = (building: Building) => {
    setEditing(building);
    form.setFieldsValue({
      name: building.name,
      campus_area: building.campus_area,
      opening_hours: building.opening_hours,
    });
    setOpen(true);
  };

  // delete one building and refresh the table
  const handleDelete = async (id: number) => {
    try {
      await deleteBuilding(id);
      message.success('Building deleted');
      await loadData();
    } catch (error) {
      message.error(getErrorMessage(error, 'Failed to delete building'));
    }
  };

  // submit the modal form for create or update
  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();

      if (editing) {
        await updateBuilding(editing.id, values);
        message.success('Building updated');
      } else {
        await createBuilding(values);
        message.success('Building created');
      }

      setOpen(false);
      await loadData();
    } catch (error) {
      const hasErrorFields = typeof error === 'object' && error !== null && 'errorFields' in error;

      if (hasErrorFields) {
        return;
      }

      message.error(getErrorMessage(error, editing ? 'Failed to update building' : 'Failed to create building'));
    }
  };

  return (
    <div className="records-page">

      <div className="records-hero">
        <div className="records-hero__copy">
          <Typography.Text className="records-hero__eyebrow">
            Admin locations
          </Typography.Text>

          <Typography.Title level={2} className="records-hero__title">
            Building Management
          </Typography.Title>

          <div className="records-pills">
            <span className="records-pill">{buildings.length} buildings</span>
            <span className="records-pill">{campusAreaCount} campus areas</span>
            <span className="records-pill">{openingHoursCount} with opening hours</span>
          </div>
        </div>

        <div className="records-hero__aside">
          <div className="records-hero__panel">
            <Typography.Text className="records-hero__panel-label">
              Campus locations
            </Typography.Text>

            <Typography.Title level={3} className="records-hero__panel-value">
              {buildings.length}
            </Typography.Title>

            <Typography.Paragraph className="records-hero__panel-copy">
              {openingHoursCount} building{openingHoursCount === 1 ? '' : 's'} already have opening hours configured.
            </Typography.Paragraph>
          </div>
        </div>
      </div>

      <div className="records-toolbar">
        <div className="records-toolbar__content">
          <Typography.Text className="records-toolbar__title">
            Manage campus buildings
          </Typography.Text>
        </div>

        <div className="records-toolbar__actions">
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Add Building
          </Button>
        </div>
      </div>


      <Card className="records-table-card">
        <Table
          rowKey="id"
          loading={loading}
          dataSource={buildings}
          columns={[
            { title: 'Name', dataIndex: 'name' },
            { title: 'Campus Area', dataIndex: 'campus_area' },
            { title: 'Opening Hours', dataIndex: 'opening_hours' },
            {
              title: 'Actions',
              render: (_, record: Building) => (
                <Space>
                  <Button icon={<EditOutlined />} onClick={() => openEdit(record)}>Edit</Button>
                  <Button danger icon={<DeleteOutlined />} onClick={() => handleDelete(record.id)}>Delete</Button>
                </Space>
              ),
            },
          ]}
        />
      </Card>

      <Modal
        open={open}
        title={editing ? 'Edit building' : 'Create building'}
        onCancel={() => setOpen(false)}
        onOk={handleSubmit}
        destroyOnHidden
      >
        <Form layout="vertical" form={form}>
          {/* Form item for the building name */}
          <Form.Item label="Building name" name="name" rules={[{ required: true }]}><Input /></Form.Item>
          {/* Form item for the campus area */}
          <Form.Item label="Campus area" name="campus_area"><Input /></Form.Item>
          {/* Form item for the opening hours text */}
          <Form.Item label="Opening hours" name="opening_hours"><Input placeholder="For example: 08:00-22:00" /></Form.Item>
        </Form>
      </Modal>

    </div>
  );

}
