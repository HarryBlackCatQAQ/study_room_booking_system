import { Button, Card, Form, Input, Typography, message } from 'antd';
import { Link, Navigate, useLocation, useNavigate } from 'react-router-dom';
import LoadingScreen from '../../components/LoadingScreen';
import { useAuth } from '../../contexts/AuthContext';
import { getStoredUser } from '../../utils/auth';
import { getDefaultRouteByRole } from '../../utils/defaultRoute';
import { CalendarOutlined, CheckCircleOutlined, SearchOutlined } from '@ant-design/icons';


export default function LoginPage() {
  // Get the login, isAuthenticated, loading, and user functions from the AuthContext
  const { login, isAuthenticated, loading, user } = useAuth();
  // Get the navigate and location functions from react-router
  const navigate = useNavigate();
  // Get the current location
  const location = useLocation();


  const loginHighlights = [
    {
      icon: <SearchOutlined />,
      title: 'Search rooms clearly',
      description: 'Browse by building, location, seats, and equipment before opening room details.',
    },
    {
      icon: <CalendarOutlined />,
      title: 'Track booking requests',
      description: 'Keep an eye on upcoming reservations, pending review items, and booking history.',
    },
    {
      icon: <CheckCircleOutlined />,
      title: 'Use one shared workflow',
      description: 'Students and admins both work inside the same booking system and status flow.',
    },
  ];


  if (loading) {
    return <LoadingScreen text="Checking session..." />;
  }

  if (isAuthenticated && user) {
    return <Navigate to={getDefaultRouteByRole(user.role)} replace />;
  }

  // Function to handle form submission
  const handleSubmit = async (values: { username: string; password: string }) => {
    try {
      // Call the login function from the AuthContext
      await login(values);

      const currentUser = getStoredUser();
      const fallback = currentUser ? getDefaultRouteByRole(currentUser.role) : '/student';
      const target = (location.state as any)?.from?.pathname || fallback;
      message.success('Login successful');
      navigate(target);
    } catch (error: any) {
      // Extract the error message from the API response, or use a default message if not available
      const detail = error?.response?.data?.detail || 'Login failed';
      message.error(detail);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-shell">

        <div className="auth-intro">
          <Typography.Text className="auth-intro__eyebrow">
            Student and admin access
          </Typography.Text>

          <Typography.Title className="auth-intro__title">
            Sign in and continue your booking workflow.
          </Typography.Title>

          <Typography.Paragraph className="auth-intro__copy">
            Use your account to browse rooms, submit booking requests, follow approval status, and manage room data in one place.
          </Typography.Paragraph>

          <div className="auth-feature-list">
            {loginHighlights.map((item) => (
              <div className="auth-feature" key={item.title}>
                <div className="auth-feature__icon">
                  {item.icon}
                </div>

                <div className="auth-feature__body">
                  <Typography.Text className="auth-feature__title">
                    {item.title}
                  </Typography.Text>

                  <Typography.Text className="auth-feature__desc">
                    {item.description}
                  </Typography.Text>
                </div>
              </div>
            ))}
          </div>

          <div className="auth-intro__footer">
            <Typography.Text className="auth-intro__hint">
              New to the platform?
            </Typography.Text>

            <Link to="/register"><Button>Register now</Button></Link>
          </div>
        </div>

        <Card className="auth-card">
          <Typography.Text className="auth-form__eyebrow">
            Welcome back
          </Typography.Text>

          <Typography.Title level={2} className="auth-form__title">
            Login
          </Typography.Title>

          <Typography.Paragraph className="auth-form__copy">
            Use your account to manage study room bookings.
          </Typography.Paragraph>

          <Form layout="vertical" onFinish={handleSubmit}>
            <Form.Item label="Username" name="username" rules={[{ required: true, message: 'Please enter your username' }]}>
              <Input autoComplete="username" />
            </Form.Item>

            <Form.Item label="Password" name="password" rules={[{ required: true, message: 'Please enter your password' }]}>
              <Input.Password autoComplete="current-password" />
            </Form.Item>

            <Form.Item>
              <Button type="primary" htmlType="submit" block className="auth-submit-btn">
                Login
              </Button>
            </Form.Item>
          </Form>

          <Typography.Text className="auth-form__switch">
            Do not have an account? <Link to="/register">Register now</Link>
          </Typography.Text>
        </Card>

      </div>
    </div>
  );

}
