import { AppstoreOutlined, BankOutlined, CheckCircleOutlined, ClockCircleOutlined, HomeOutlined, ToolOutlined } from '@ant-design/icons';
import { Button, Card, Col, Row, Statistic, Typography } from 'antd';
import { useEffect, useState } from 'react';
import { getAllBookings } from '../../api/bookings';
import { getRooms } from '../../api/rooms';
import type { Booking, Room } from '../../types';
import { Link } from 'react-router-dom';


export default function AdminDashboardPage() {
  // set rooms and bookings state
  const [rooms, setRooms] = useState<Room[]>([]);
  const [bookings, setBookings] = useState<Booking[]>([]);

  // render the dashboard first time
  useEffect(() => {
    void (async () => {
      // get rooms and bookings
      const [roomData, bookingData] = await Promise.all([getRooms(), getAllBookings()]);

      // set rooms and bookings
      setRooms(roomData);
      setBookings(bookingData);
    })();
  }, []);


  const pendingCount = bookings.filter((booking) => booking.status === 'pending').length;
  const approvedCount = bookings.filter((booking) => booking.status === 'approved').length;
  const activeRoomsCount = rooms.filter((room) => room.is_active).length;

  const adminFocusMessage = getadminFocuseMessage(pendingCount);

  return (
    <>
      <div className="dashboard-page">

        {/* Title */}
        <div className="dashboard-hero">
          <Typography.Title level={2} className="dashboard-hero__title">
            Admin Dashboard
          </Typography.Title>

          <Typography.Paragraph className="dashboard-hero__copy">
            Review room inventory, check pending approvals, and monitor campus booking activity from one place.
          </Typography.Paragraph>

        </div>

        {/* Statistics for the admin */}
        <Row gutter={[20, 20]}>

          {/* Cards for Total rooms */}
          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Total rooms" value={rooms.length} prefix={<HomeOutlined />} />
              <Typography.Text className="stat-card__hint">
                All rooms currently stored in the system.
              </Typography.Text>
            </Card>
          </Col>

          {/* Cards for Active rooms */}
          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Active rooms" value={activeRoomsCount} prefix={<AppstoreOutlined />} />
              <Typography.Text className="stat-card__hint">
                Rooms currently available for booking.
              </Typography.Text>
            </Card>
          </Col>

          {/* Cards for Pending bookings */}
          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Pending bookings" value={pendingCount} prefix={<ClockCircleOutlined />} />
              <Typography.Text className="stat-card__hint">
                Requests that still need admin review.
              </Typography.Text>
            </Card>
          </Col>

          {/* Cards for Approved bookings */}
          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Approved bookings" value={approvedCount} prefix={<CheckCircleOutlined />} />
              <Typography.Text className="stat-card__hint">
                Reservations already approved in the system.
              </Typography.Text>
            </Card>
          </Col>

        </Row>

        <div className="dashboard-grid">
          <Card className="dashboard-section-card">
            <Typography.Title level={4} className="dashboard-section-title">
              Review checklist
            </Typography.Title>

            <Typography.Paragraph>
              The top cards already cover the numbers. This section is for admin workflow priorities.
            </Typography.Paragraph>

            <div className="guide-list">
              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Process pending requests first</Typography.Text>
                  <span className="guide-item__badge">Booking Requests</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  Approve or reject requests based on room availability so students receive a timely result.
                </Typography.Text>
              </div>

              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Keep room status accurate</Typography.Text>
                  <span className="guide-item__badge">Room Management</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  Active status, capacity, and location details should stay aligned with the real room situation.
                </Typography.Text>
              </div>

              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Maintain supporting data</Typography.Text>
                  <span className="guide-item__badge">Buildings / Equipment</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  Clear building and equipment data helps students filter rooms correctly and reduces booking mistakes.
                </Typography.Text>
              </div>
            </div>

            <div className="focus-box">
              <Typography.Text className="focus-box__label">
                Current focus
              </Typography.Text>

              <Typography.Text className="focus-box__text">
                {adminFocusMessage}
              </Typography.Text>
            </div>
          </Card>


          <Card className="dashboard-section-card">
            <Typography.Title level={4} className="dashboard-section-title">
              Management shortcuts
            </Typography.Title>

            <Typography.Paragraph>
              Jump directly to the admin pages you manage most often.
            </Typography.Paragraph>

            <div className="dashboard-actions">
              <Link to="/admin/rooms">
                <Button type="primary" icon={<HomeOutlined />}>
                  Room Management
                </Button>
              </Link>

              <Link to="/admin/buildings">
                <Button icon={<BankOutlined />}>
                  Building Management
                </Button>
              </Link>

              <Link to="/admin/equipments">
                <Button icon={<ToolOutlined />}>
                  Equipment Mgmt
                </Button>
              </Link>

              <Link to="/admin/requests">
                <Button icon={<ClockCircleOutlined />}>
                  Booking Requests
                </Button>
              </Link>
            </div>

            <Typography.Text className="dashboard-note">
              If pending bookings increase, open Booking Requests first.
            </Typography.Text>
          </Card>
        </div>

      </div>
    </>
  );

}


function getadminFocuseMessage(pendingCount: number){
  const adminFocusMessage = pendingCount > 0
    ? 'There are still booking requests waiting for review. Open Booking Requests and process the oldest items first.'
    : 'There is no pending review right now. This is a good time to verify rooms, buildings, and equipment data.';

    return adminFocusMessage
}
