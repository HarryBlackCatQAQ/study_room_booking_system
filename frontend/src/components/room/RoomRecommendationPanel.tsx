import { ArrowRightOutlined, BulbOutlined } from '@ant-design/icons';
import {
  Alert,
  Button,
  Empty,
  Form,
  InputNumber,
  Select,
  Typography,
  message,
} from 'antd';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getRecommendedRooms } from '../../api/smart';
import type {
  Building,
  RecommendedRoom,
  RecommendationRequestPayload,
} from '../../types';

// Props interface for the room recommendation panel
interface Props {
  buildings: Building[];
}

// Form values interface for the room match form
interface RecommendationFormValues {
  min_capacity: number;
  preferred_building_id?: number;
}

// helper function to get a readable error message from the api response
function getSmartErrorMessage(error: unknown, fallback: string) {
  const response = (error as {
    response?: {
      data?: {
        detail?: string;
        details?: string;
        non_field_errors?: string[];
      };
    };
  })?.response?.data;

  return response?.detail || response?.details || response?.non_field_errors?.[0] || fallback;
}

export default function RoomRecommendationPanel({ buildings }: Props) {
  // set up the form instance and navigate function
  const [form] = Form.useForm();
  const navigate = useNavigate();

  // set up the search results and loading states
  const [results, setResults] = useState<RecommendedRoom[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [searched, setSearched] = useState(false);

  // submit the room match form and load matching rooms
  const handleFinish = async (values: RecommendationFormValues) => {
    const payload: RecommendationRequestPayload = {
      min_capacity: values.min_capacity,
      preferred_building_id: values.preferred_building_id,
    };

    setSubmitting(true);

    try {
      const data = await getRecommendedRooms(payload);
      setResults(data);
      setSearched(true);
    } catch (error) {
      message.error(getSmartErrorMessage(error, 'Failed to load matching rooms.'));
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <section className="rooms-smart">
      {/* Display the recommendation panel header */}
      <div className="rooms-smart__header">
        <div>
          <Typography.Text className="rooms-smart__eyebrow">
            Smart room planning
          </Typography.Text>

          <Typography.Title level={4} className="rooms-smart__title">
            Room suggestions
          </Typography.Title>

          <Typography.Paragraph className="rooms-smart__copy">
            Find active rooms that match your seat needs and optional building choice.
          </Typography.Paragraph>
        </div>

        <div className="rooms-smart__badge">
          <BulbOutlined />
          <span>Quick suggestions</span>
        </div>
      </div>

      {/* Render the room match form */}
      <Form
        form={form}
        layout="vertical"
        className="rooms-smart__form"
        onFinish={handleFinish}
        initialValues={{
          min_capacity: 4,
        }}
      >
        {/* Form item for setting the minimum capacity */}
        <Form.Item
          label="Minimum capacity"
          name="min_capacity"
          rules={[{ required: true, message: 'Please enter the minimum capacity' }]}
        >
          <InputNumber style={{ width: '100%' }} min={1} />
        </Form.Item>

        {/* Form item for choosing the preferred building */}
        <Form.Item label="Preferred building" name="preferred_building_id">
          <Select
            allowClear
            placeholder="Optional"
            options={buildings.map((item) => ({
              label: item.name,
              value: item.id,
            }))}
          />
        </Form.Item>

        {/* Form item for submitting the room match */}
        <Form.Item className="rooms-smart__action">
          <Button
            type="primary"
            htmlType="submit"
            loading={submitting}
            className="rooms-smart__submit"
          >
            Find rooms
          </Button>
        </Form.Item>
      </Form>

      {!searched ? (
        <>
          {/* Display a short guide before the first search */}
          <Alert
            showIcon
            type="info"
            className="rooms-smart__notice"
            message="Choose the number of seats you need and optionally limit the search to one building."
          />
        </>
      ) : results.length ? (
        <>
          {/* Display the matched room results after a successful search */}
          <div className="rooms-smart__results">
            {results.map((item) => (
              <article key={item.room_id} className="rooms-smart-result">
                <div className="rooms-smart-result__top">
                  <div>
                    <Typography.Text className="rooms-smart-result__building">
                      {item.building_name}
                    </Typography.Text>

                    <Typography.Title level={5} className="rooms-smart-result__title">
                      {item.room_name}
                    </Typography.Title>
                  </div>
                </div>

                {/* Show the reason returned by the room match result */}
                <Typography.Paragraph className="rooms-smart-result__reason">
                  {item.reason}
                </Typography.Paragraph>

                {/* Link the user to the selected room detail page */}
                <Button
                  icon={<ArrowRightOutlined />}
                  onClick={() => navigate(`/student/rooms/${item.room_id}`)}
                >
                  View room
                </Button>
              </article>
            ))}
          </div>
        </>
      ) : (
        <>
          {/* Show an empty state when no rooms match the search */}
          <div className="rooms-smart__empty">
            <Empty description="No rooms matched this search." />
          </div>
        </>
      )}
    </section>
  );
}
