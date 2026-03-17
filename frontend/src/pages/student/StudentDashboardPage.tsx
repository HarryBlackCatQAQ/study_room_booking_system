import { ClockCircleOutlined, CalendarOutlined, SearchOutlined, StarOutlined, ArrowRightOutlined } from '@ant-design/icons';
import { Button, Card, Col, Row, Statistic, Typography } from 'antd';
import { useEffect, useState } from 'react';
import { getMyBookings } from '../../api/bookings';
import { getRooms } from '../../api/rooms';
import type { Booking, Room } from '../../types';
import dayjs from 'dayjs';
import { Link } from 'react-router-dom';

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

  // check whether an approved booking has already ended
  const isEndedBooking = (booking: Booking) => {
    const bookingEnd = dayjs(`${booking.booking_date}T${booking.end_time}`);
    return bookingEnd.isBefore(dayjs());
  };

  // pending + approved but not ended yet
  const upcoming = bookings.filter((booking) => {
    if (booking.status === 'pending') {
      return true;
    }

    if (booking.status === 'approved') {
      return !isEndedBooking(booking);
    }

    return false;
  });

  // approved and ended + cancelled + rejected
  const history = bookings.filter((booking) => {
    if (['cancelled', 'rejected'].includes(booking.status)) {
      return true;
    }

    if (booking.status === 'approved') {
      return isEndedBooking(booking);
    }

    return false;
  });

  const pendingCount = bookings.filter((booking) => booking.status === 'pending').length;

  const approvedUpcomingCount = bookings.filter((booking) => {
    if (booking.status !== 'approved') {
      return false;
    }

    return !isEndedBooking(booking);
  }).length;

  const studentFocusMessage = getStudentFocusMessage(pendingCount, upcoming, history);

  return (
    <>
      <div className="dashboard-page">

        <div className="dashboard-hero">
          <Typography.Title level={2} className="dashboard-hero__title">
            Student Dashboard
          </Typography.Title>

          <Typography.Paragraph className="dashboard-hero__copy">
            Quickly check room availability, review your upcoming bookings, and keep track of your past reservations.
          </Typography.Paragraph>
        </div>

        <Row gutter={[20, 20]}>
          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Available rooms" value={rooms.length} prefix={<SearchOutlined />} />
            </Card>
          </Col>

          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Pending requests" value={pendingCount} prefix={<ClockCircleOutlined />} />
            </Card>
          </Col>

          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="Upcoming sessions" value={approvedUpcomingCount} prefix={<CalendarOutlined />} />
            </Card>
          </Col>

          <Col xs={24} sm={12} xl={6}>
            <Card className="stat-card">
              <Statistic title="History records" value={history.length} prefix={<StarOutlined />} />
            </Card>
          </Col>
        </Row>

        <div className="dashboard-grid">
          <Card className="dashboard-section-card">
            <Typography.Title level={3} className="dashboard-section-title">
              Booking workflow guide
            </Typography.Title>

            <div className="guide-list">
              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Pending request</Typography.Text>
                  <span className="guide-item__badge">Check My Bookings</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  A pending request is still waiting for admin review, so your main task is to follow status changes.
                </Typography.Text>
              </div>

              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Approved booking</Typography.Text>
                  <span className="guide-item__badge">Arrive on time</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  Once approved, make sure you use the room during the reserved time slot and keep your booking details in mind.
                </Typography.Text>
              </div>

              <div className="guide-item">
                <div className="guide-item__header">
                  <Typography.Text className="guide-item__title">Finished or inactive record</Typography.Text>
                  <span className="guide-item__badge">Open History</span>
                </div>

                <Typography.Text className="guide-item__desc">
                  Completed, rejected, and cancelled bookings move into history so your active dashboard stays easier to read.
                </Typography.Text>
              </div>
            </div>

            <div className="focus-box">
              <Typography.Text className="focus-box__label">
                Current focus
              </Typography.Text>

              <Typography.Text className="focus-box__text">
                {studentFocusMessage}
              </Typography.Text>
            </div>
          </Card>


          <Card className="dashboard-section-card">
            <Typography.Title level={4} className="dashboard-section-title">
              Quick actions
            </Typography.Title>

            <Typography.Paragraph>
              Jump directly to the pages you use most often.
            </Typography.Paragraph>

            <div className="dashboard-actions">
              <Link to="/student/rooms">
                <Button type="primary" icon={<ArrowRightOutlined />}>
                  Browse Rooms
                </Button>
              </Link>

              <Link to="/student/bookings">
                <Button icon={<CalendarOutlined />}>
                  My Bookings
                </Button>
              </Link>

              <Link to="/student/history">
                <Button icon={<StarOutlined />}>
                  Booking History
                </Button>
              </Link>

              <Link to="/student/profile">
                <Button>
                  My Profile
                </Button>
              </Link>
            </div>

            <Typography.Text className="dashboard-note">
              If you are waiting for approval, open My Bookings to check the latest status.
            </Typography.Text>
          </Card>
        </div>

      </div>
    </>
  );

}

// get student focus message, judge the situation of student pendingCount, approvedUpcomingCount, history
function getStudentFocusMessage(pendingCount: number, upcoming: Booking[], history: Booking[]) {
  const studentFocusMessage = pendingCount > 0
    ? 'You still have requests waiting for review. Open My Bookings to follow the latest status.'
    : upcoming.length > 0
      ? 'You already have active bookings in progress. Review the time slot before going to the room.'
      : history.length > 0
        ? 'You do not have an active booking right now. You can review older records in Booking History.'
        : 'You have not created a booking yet. Start from Browse Rooms and make your first reservation.';

  return studentFocusMessage;
}
