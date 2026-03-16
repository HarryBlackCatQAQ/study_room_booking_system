import { ArrowRightOutlined, BulbOutlined } from '@ant-design/icons';
import {
  Alert,
  Button,
  DatePicker,
  Empty,
  Form,
  InputNumber,
  Select,
  TimePicker,
  Typography,
  message,
} from 'antd';
import type { Dayjs } from 'dayjs';
import dayjs from 'dayjs';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getEquipments } from '../../api/rooms';
import { getRecommendedRooms } from '../../api/smart';
import type {
  Building,
  Equipment,
  RecommendedRoom,
  RecommendationRequestPayload,
} from '../../types';

// Props interface for the room recommendation panel
interface Props {
  buildings: Building[];
}

// Form values interface for the recommendation search form
interface RecommendationFormValues {
  booking_date: Dayjs;
  start_time: Dayjs;
  end_time: Dayjs;
  min_capacity: number;
  required_equipment?: string[];
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

  // set up the equipment options, search results, and loading states
  const [equipments, setEquipments] = useState<Equipment[]>([]);
  const [results, setResults] = useState<RecommendedRoom[]>([]);
  const [loadingOptions, setLoadingOptions] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [searched, setSearched] = useState(false);

  // load the equipment options when the panel renders
  useEffect(() => {
    void (async () => {
      try {
        const equipmentData = await getEquipments();
        setEquipments(equipmentData);
      } catch {
        message.error('Failed to load equipment options.');
      } finally {
        setLoadingOptions(false);
      }
    })();
  }, []);

  // submit the recommendation search form and load ranked rooms
  const handleFinish = async (values: RecommendationFormValues) => {
    if (!values.end_time.isAfter(values.start_time)) {
      message.error('End time must be later than start time.');
      return;
    }

    const payload: RecommendationRequestPayload = {
      booking_date: values.booking_date.format('YYYY-MM-DD'),
      start_time: values.start_time.format('HH:mm:ss'),
      end_time: values.end_time.format('HH:mm:ss'),
      min_capacity: values.min_capacity,
      required_equipment: values.required_equipment || [],
      preferred_building_id: values.preferred_building_id,
    };

    setSubmitting(true);

    try {
      const data = await getRecommendedRooms(payload);
      setResults(data);
      setSearched(true);
    } catch (error) {
      message.error(getSmartErrorMessage(error, 'Failed to load recommendations.'));
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
            Smart room recommendation
          </Typography.Title>

          <Typography.Paragraph className="rooms-smart__copy">
            Rank rooms by preferred building, capacity, equipment, and room ratings.
          </Typography.Paragraph>
        </div>

        <div className="rooms-smart__badge">
          <BulbOutlined />
          <span>Ranked suggestions</span>
        </div>
      </div>

      {/* Render the recommendation form */}
      <Form
        form={form}
        layout="vertical"
        className="rooms-smart__form"
        onFinish={handleFinish}
        initialValues={{
          booking_date: dayjs().add(1, 'day'),
          start_time: dayjs().hour(9).minute(0).second(0),
          end_time: dayjs().hour(11).minute(0).second(0),
          min_capacity: 4,
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

        {/* Form item for selecting the start time */}
        <Form.Item
          label="Start time"
          name="start_time"
          rules={[{ required: true, message: 'Please select a start time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

        {/* Form item for selecting the end time */}
        <Form.Item
          label="End time"
          name="end_time"
          rules={[{ required: true, message: 'Please select an end time' }]}
        >
          <TimePicker style={{ width: '100%' }} format="HH:mm" minuteStep={30} />
        </Form.Item>

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

        {/* Form item for choosing the required equipment */}
        <Form.Item label="Required equipment" name="required_equipment">
          <Select
            mode="multiple"
            allowClear
            loading={loadingOptions}
            placeholder="Optional"
            options={equipments.map((item) => ({
              label: item.name,
              value: item.name,
            }))}
          />
        </Form.Item>

        {/* Form item for submitting the recommendation search */}
        <Form.Item className="rooms-smart__action">
          <Button
            type="primary"
            htmlType="submit"
            loading={submitting}
            className="rooms-smart__submit"
          >
            Get recommendations
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
            message="Fill in a preferred study session to get ranked room suggestions."
          />
        </>
      ) : results.length ? (
        <>
          {/* Display the ranked room results after a successful search */}
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

                  <div className="rooms-smart-result__score">
                    <span>Score</span>
                    <strong>{item.score.toFixed(1)}</strong>
                  </div>
                </div>

                {/* Show the reason returned by the recommendation result */}
                <Typography.Paragraph className="rooms-smart-result__reason">
                  {item.reason.split(',').join(' • ')}
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
            <Empty description="No recommended rooms matched this search." />
          </div>
        </>
      )}
    </section>
  );
}
