import { ArrowRightOutlined, CalendarOutlined, CheckCircleOutlined, SearchOutlined, ToolOutlined } from '@ant-design/icons';
import { Button, Layout, Typography } from 'antd';
import { Link, useNavigate } from 'react-router-dom';
import AppHeader from '../../components/AppHeader';
import { useAuth } from '../../contexts/AuthContext';
import { getDefaultRouteByRole } from '../../utils/defaultRoute';

export default function LandingPage() {
  // Get the user information from the AuthContext
  const { user } = useAuth();
  // Get the navigate function from react-router
  const navigate = useNavigate();

  // Function to handle login button click
  const handleLoginBtnClick = () => {
    // Navigate to the appropriate route based on user information
    navigate(user ? getDefaultRouteByRole(user.role) : '/login');
  };


  const landingChecks = [
    'Browse rooms by capacity, location, and equipment',
    'Create booking requests with date and time selection',
    'Track upcoming bookings and booking history in one place',
    'Support admin review and room management workflows',
  ];

  const landingFeatures = [
    {
      icon: <SearchOutlined />,
      title: 'Search with context',
      description: 'Students can compare rooms by building, location, seats, and equipment before opening details.',
    },
    {
      icon: <CalendarOutlined />,
      title: 'Reserve with clarity',
      description: 'The booking flow keeps date and time selection simple, then pushes the request into review.',
    },
    {
      icon: <ToolOutlined />,
      title: 'Manage as a system',
      description: 'Admins can keep buildings, rooms, and equipment aligned so the booking data stays useful.',
    },
  ];


  return (
    // Use Ant Design's Layout component to create a fuller landing page
    <Layout style={{ minHeight: '100vh', background: 'transparent' }}>
      {/* Render the header component */}
      <AppHeader />

      {/* Render the content area */}
      <Layout.Content className="landing-page">
        <div className="landing-shell">

          {/* Render the landing hero */}
          <div className="landing-hero">

            {/* Render the left hero content */}
            <div className="landing-hero__copy">
              <Typography.Text className="landing-hero__eyebrow">
                Study room booking for campus
              </Typography.Text>

              <Typography.Title className="landing-hero__title">
                Book study rooms faster and avoid time conflicts.
              </Typography.Title>

              <Typography.Paragraph className="landing-hero__lead">
                StudyNest Reserve helps students find the right room, submit booking requests, and keep track of reservations without messy manual coordination.
              </Typography.Paragraph>

              <div className="landing-hero__actions">
                <Link to="/register"><Button type="primary" size="large">Get started</Button></Link>

                {/* Render a button that navigates to the login page */}
                <Button size="large" onClick={handleLoginBtnClick}>
                  {user ? 'Go to dashboard' : 'Login'}
                </Button>
              </div>

              <div className="landing-hero__stats">
                <div className="landing-stat">
                  <Typography.Text className="landing-stat__label">Discover</Typography.Text>
                  <Typography.Text className="landing-stat__value">Rooms</Typography.Text>
                  <Typography.Text className="landing-stat__copy">
                    Search by building, location, seats, and equipment.
                  </Typography.Text>
                </div>

                <div className="landing-stat">
                  <Typography.Text className="landing-stat__label">Reserve</Typography.Text>
                  <Typography.Text className="landing-stat__value">Requests</Typography.Text>
                  <Typography.Text className="landing-stat__copy">
                    Pick a date and time range, then submit for review.
                  </Typography.Text>
                </div>

                <div className="landing-stat">
                  <Typography.Text className="landing-stat__label">Manage</Typography.Text>
                  <Typography.Text className="landing-stat__value">Workflow</Typography.Text>
                  <Typography.Text className="landing-stat__copy">
                    Track booking history and keep room data organized.
                  </Typography.Text>
                </div>
              </div>
            </div>

            {/* Render the right showcase panel */}
            <div className="landing-showcase">
              <div className="landing-showcase__panel">
                <Typography.Text className="landing-showcase__eyebrow">
                  What you can do
                </Typography.Text>

                <Typography.Title level={3} className="landing-showcase__title">
                  One workflow from search to review
                </Typography.Title>

                <div className="landing-checklist">
                  {landingChecks.map((item) => (
                    <div className="landing-check" key={item}>
                      <CheckCircleOutlined className="landing-check__icon" />
                      <Typography.Text>{item}</Typography.Text>
                    </div>
                  ))}
                </div>

                <div className="landing-showcase__footer">
                  <Typography.Text className="landing-showcase__shortcut">
                    {user ? 'Open the student workspace and start exploring rooms.' : 'Log in to explore rooms and start booking.'}
                  </Typography.Text>

                  <Link to={user ? '/student/rooms' : '/login'}>
                    <Button type="link" icon={<ArrowRightOutlined />}>
                      {user ? 'Explore rooms' : 'Login to explore'}
                    </Button>
                  </Link>
                </div>
              </div>
            </div>

          </div>

          {/* Render the feature cards */}
          <div className="landing-feature-grid">
            {landingFeatures.map((item) => (
              <div className="landing-feature" key={item.title}>
                <div className="landing-feature__icon">
                  {item.icon}
                </div>

                <Typography.Title level={4} className="landing-feature__title">
                  {item.title}
                </Typography.Title>

                <Typography.Paragraph className="landing-feature__copy">
                  {item.description}
                </Typography.Paragraph>
              </div>
            ))}
          </div>

        </div>
      </Layout.Content>
    </Layout>
  );

}

