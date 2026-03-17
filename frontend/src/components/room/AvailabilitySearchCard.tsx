import { ArrowRightOutlined, ClockCircleOutlined } from '@ant-design/icons';
import {
  Alert,
  Button,
  DatePicker,
  Empty,
  Form,
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

// Form values interface for the availability form
interface AvailabilityFormValues {
  booking_date: Dayjs;
  search_start_time: Dayjs;
  search_end_time: Dayjs;
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

  // submit the availability form and load matching rooms
  const handleFinish = async (values: AvailabilityFormValues) => {
    if (!values.search_end_time.isAfter(values.search_start_time)) {
      message.error('End time must be later than start time.');
      return;
    }

    const payload: AvailabilityRequestPayload = {
      booking_date: values.booking_date.format('YYYY-MM-DD'),
      search_start_time: values.search_start_time.format('HH:mm:ss'),
      search_end_time: values.search_end_time.format('HH:mm:ss'),
      building_id: room.building?.id,
    };

    setSubmitting(true);

    try {
      const data = await getAvailableSlots(payload);
      setResults(data);
      setSearched(true);
    } catch (error) {
      message.error(getSmartErrorMessage(error, 'Failed to check room availability.'));
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
            Availability check
          </Typography.Title>

          <Typography.Paragraph className="room-detail-smart__copy">
            Check which rooms in this building are free for your selected time range.
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
        message="Search one exact time range in this building and see the rooms without booking conflicts."
      />

      {/* Render the availability form */}
      <Form
        form={form}
        layout="vertical"
        className="room-detail-smart__form"
        onFinish={handleFinish}
        initialValues={{
          booking_date: dayjs().add(1, 'day'),
          search_start_time: dayjs().hour(9).minute(0).second(0),
          search_end_time: dayjs().hour(10).minute(0).second(0),
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

        {/* Form item for selecting the start time */}
        <Form.Item
          label="Start time"
          name="search_start_time"
          rules={[{ required: true, message: 'Please select a start time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

        {/* Form item for selecting the end time */}
        <Form.Item
          label="End time"
          name="search_end_time"
          rules={[{ required: true, message: 'Please select an end time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

        {/* Form item for submitting the availability form */}
        <Form.Item className="room-detail-smart__action">
          <Button
            type="primary"
            htmlType="submit"
            loading={submitting}
            className="room-detail-smart__submit"
          >
            Check availability
          </Button>
        </Form.Item>
      </Form>

      {!searched ? (
        <>
          {/* Display a short guide before the first search */}
          <Alert
            showIcon
            type="info"
            message="Submit the form to check room availability for the selected time."
          />
        </>
      ) : results.length ? (
        <>
          {/* Display the matching rooms after a successful search */}
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
                    <span className="guide-item__badge">Current room</span>
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
          {/* Show an empty state when no matching rooms are found */}
          <div className="room-detail-smart__empty">
            <Empty description="No free rooms were found for this exact time range." />
          </div>
        </>
      )}
    </div>
  );
}
