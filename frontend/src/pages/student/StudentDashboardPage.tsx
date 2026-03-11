import { CalendarOutlined, SearchOutlined, StarOutlined } from '@ant-design/icons';
import { Card, Col, Row, Statistic, Typography } from 'antd';
import { useEffect, useState } from 'react';
import { getMyBookings } from '../../api/bookings';
import { getRooms } from '../../api/rooms';
import type { Booking, Room } from '../../types';

export default function StudentDashboardPage() {
  const [rooms, setRooms] = useState<Room[]>([]);
  const [bookings, setBookings] = useState<Booking[]>([]);

  // render the dashboard first time
  useEffect(() => {
    void (async () => {
      // get rooms and bookings
      const [roomData, bookingData] = await Promise.all([getRooms(), getMyBookings()]);
      // set rooms and bookings
      setRooms(roomData);
      setBookings(bookingData);
    })();
  }, []);

  // filter bookings by status (pending, approved)
  const upcoming = bookings.filter((b) => ['pending', 'approved'].includes(b.status));
  // filter bookings by status (cancelled, rejected)
  const history = bookings.filter((b) => ['cancelled', 'rejected'].includes(b.status));

  return (
    <>
      <Typography.Title level={2}>Student Dashboard</Typography.Title>
      <Typography.Paragraph>
        Quickly view room availability, your current bookings, and booking history.
      </Typography.Paragraph>
      <Row gutter={[16, 16]}>
        <Col xs={24} md={8}>
          <Card><Statistic title="Available rooms" value={rooms.length} prefix={<SearchOutlined />} /></Card>
        </Col>
        <Col xs={24} md={8}>
          <Card><Statistic title="Upcoming bookings" value={upcoming.length} prefix={<CalendarOutlined />} /></Card>
        </Col>
        <Col xs={24} md={8}>
          <Card><Statistic title="Past / inactive bookings" value={history.length} prefix={<StarOutlined />} /></Card>
        </Col>
      </Row>
    </>
  );
}
