import { ArrowRightOutlined, ClockCircleOutlined } from '@ant-design/icons';
import {
  Alert,
  Button,
  DatePicker,
  Empty,
  Form,
  InputNumber,
  Select,
  Tag,
  TimePicker,
  Typography,
  message,
} from 'antd';
import type { Dayjs } from 'dayjs';
import dayjs from 'dayjs';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getAvailableSlots } from '../../api/smart';
import type {
  AvailabilityRequestPayload,
  AvailableSlot,
  Room,
} from '../../types';
import { formatTime } from '../../utils/format';

// Props interface for the availability search card
interface Props {
  room: Room;
}

// Form values interface for the availability search form
interface AvailabilityFormValues {
  booking_date: Dayjs;
  search_start_time: Dayjs;
  search_end_time: Dayjs;
  duration_minutes: number;
  min_capacity: number;
  required_equipment?: string[];
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

export default function AvailabilitySearchCard({ room }: Props) {
  // set up the form instance and navigate function
  const [form] = Form.useForm();
  const navigate = useNavigate();

  // set up the search results and loading states
  const [results, setResults] = useState<AvailableSlot[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [searched, setSearched] = useState(false);

  // submit the availability search form and load matching slots
  const handleFinish = async (values: AvailabilityFormValues) => {
    if (!values.search_end_time.isAfter(values.search_start_time)) {
      message.error('Search end time must be later than search start time.');
      return;
    }

    const payload: AvailabilityRequestPayload = {
      booking_date: values.booking_date.format('YYYY-MM-DD'),
      search_start_time: values.search_start_time.format('HH:mm:ss'),
      search_end_time: values.search_end_time.format('HH:mm:ss'),
      duration_minutes: values.duration_minutes,
      min_capacity: values.min_capacity,
      building_id: room.building?.id,
      required_equipment: values.required_equipment || [],
    };

    setSubmitting(true);

    try {
      const data = await getAvailableSlots(payload);
      setResults(data);
      setSearched(true);
    } catch (error) {
      message.error(getSmartErrorMessage(error, 'Failed to search available slots.'));
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="room-detail-smart">
      {/* Display the availability search header */}
      <div className="room-detail-smart__header">
        <div>
          <Typography.Text className="room-detail-smart__eyebrow">
            Time slot search
          </Typography.Text>

          <Typography.Title level={4} className="room-detail-card__title">
            Smart availability search
          </Typography.Title>

          <Typography.Paragraph className="room-detail-smart__copy">
            Search matching time slots in the same building as this room.
          </Typography.Paragraph>
        </div>

        <div className="room-detail-smart__scope">
          <ClockCircleOutlined />
          <span>{room.building?.name || 'Current building'}</span>
        </div>
      </div>

      {/* Display a short tip for the search scope */}
      <Alert
        showIcon
        type="info"
        message="This search is scoped to the current building. You can narrow it further with equipment and minimum capacity."
      />

      {/* Render the availability search form */}
      <Form
        form={form}
        layout="vertical"
        className="room-detail-smart__form"
        onFinish={handleFinish}
        initialValues={{
          booking_date: dayjs().add(1, 'day'),
          search_start_time: dayjs().hour(8).minute(0).second(0),
          search_end_time: dayjs().hour(18).minute(0).second(0),
          duration_minutes: 60,
          min_capacity: room.capacity,
          required_equipment: [],
        }}
      >
        {/* Form item for selecting the booking date */}
        <Form.Item
          label="Date"
          name="booking_date"
          rules={[{ required: true, message: 'Please select a date' }]}
        >
          <DatePicker
            style={{ width: '100%' }}
            disabledDate={(current) => current && current < dayjs().startOf('day')}
          />
        </Form.Item>

        {/* Form item for selecting the search start time */}
        <Form.Item
          label="Search start time"
          name="search_start_time"
          rules={[{ required: true, message: 'Please select a search start time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

        {/* Form item for selecting the search end time */}
        <Form.Item
          label="Search end time"
          name="search_end_time"
          rules={[{ required: true, message: 'Please select a search end time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

        {/* Form item for selecting the duration */}
        <Form.Item
          label="Duration"
          name="duration_minutes"
          rules={[{ required: true, message: 'Please select a duration' }]}
        >
          <Select
            options={[30, 60, 90, 120, 150, 180].map((value) => ({
              label: `${value} minutes`,
              value,
            }))}
          />
        </Form.Item>

        {/* Form item for setting the minimum capacity */}
        <Form.Item
          label="Minimum capacity"
          name="min_capacity"
          rules={[{ required: true, message: 'Please enter the minimum capacity' }]}
        >
          <InputNumber style={{ width: '100%' }} min={1} />
        </Form.Item>

        {/* Form item for matching the current room equipment */}
        <Form.Item label="Match equipment" name="required_equipment">
          <Select
            mode="multiple"
            allowClear
            placeholder={room.equipment.length ? 'Optional' : 'No equipment listed for this room'}
            disabled={!room.equipment.length}
            options={room.equipment.map((item) => ({
              label: item.name,
              value: item.name,
            }))}
          />
        </Form.Item>

        {/* Form item for submitting the availability search */}
        <Form.Item className="room-detail-smart__action">
          <Button
            type="primary"
            htmlType="submit"
            loading={submitting}
            className="room-detail-smart__submit"
          >
            Search available slots
          </Button>
        </Form.Item>
      </Form>

      {!searched ? (
        <>
          {/* Display a short guide before the first search */}
          <Alert
            showIcon
            type="info"
            message="Submit the form to scan matching time slots."
          />
        </>
      ) : results.length ? (
        <>
          {/* Display the matching slots after a successful search */}
          <div className="room-detail-smart__results">
            {results.map((item, index) => (
              <article
                key={`${item.room_id}-${item.start_time}-${item.end_time}-${index}`}
                className="room-detail-slot"
              >
                <div className="room-detail-slot__meta">
                  <Typography.Title level={5} className="room-detail-slot__title">
                    {item.room_name}
                  </Typography.Title>

                  <Typography.Text type="secondary">
                    {item.building_name}
                  </Typography.Text>

                  <Typography.Text className="room-detail-slot__time">
                    {formatTime(item.start_time)} - {formatTime(item.end_time)}
                  </Typography.Text>
                </div>

                {/* Display the current room flag and the navigation action */}
                <div className="room-detail-slot__actions">
                  {item.room_id === room.id ? (
                    <Tag color="blue">Current room</Tag>
                  ) : null}

                  <Button
                    icon={<ArrowRightOutlined />}
                    onClick={() => navigate(`/student/rooms/${item.room_id}`)}
                  >
                    View room
                  </Button>
                </div>
              </article>
            ))}
          </div>
        </>
      ) : (
        <>
          {/* Show an empty state when no matching slots are found */}
          <div className="room-detail-smart__empty">
            <Empty description="No matching time slots were found." />
          </div>
        </>
      )}
    </div>
  );
}
