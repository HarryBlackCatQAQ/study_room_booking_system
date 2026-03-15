import { Button, Card, Form, Input, Typography, message } from 'antd';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { CalendarOutlined, SearchOutlined, TeamOutlined } from '@ant-design/icons';


export default function RegisterPage() {
  // Get the register function from the AuthContext
  const { register } = useAuth();
  // Get the navigate function from react-router
  const navigate = useNavigate();


  const registerHighlights = [
    {
      icon: <TeamOutlined />,
      title: 'Student booking access',
      description: 'Create a student account to browse rooms, submit requests, and follow booking status from one dashboard.',
    },
    {
      icon: <SearchOutlined />,
      title: 'Find the right room faster',
      description: 'Compare rooms by building, location, capacity, and equipment before opening the booking form.',
    },
    {
      icon: <CalendarOutlined />,
      title: 'Track each reservation clearly',
      description: 'Keep upcoming bookings, request updates, and booking history in one student workflow.',
    },
  ];


  // Function to handle form submission
  const handleSubmit = async (values: { username: string; email: string; password: string; role: 'student' }) => {
    try {
      await register({ ...values, role: 'student' });
      message.success('Registration successful');
      navigate('/student');
    } catch (error: any) {
      const detail = error?.response?.data?.username?.[0] || 'Registration failed';
      message.error(detail);
    }
  };

    return (
    // Container for the registration form
    <div className="auth-page">

      <div className="auth-shell">

        <div className="auth-intro">
          <Typography.Text className="auth-intro__eyebrow">
            Create your account
          </Typography.Text>

          <Typography.Title className="auth-intro__title">
            Create your student account and start booking rooms.
          </Typography.Title>

          <Typography.Paragraph className="auth-intro__copy">
            Register once to search study spaces, send booking requests, and keep your room history organized in one place.
          </Typography.Paragraph>

          <div className="auth-feature-list">
            {registerHighlights.map((item) => (
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
              Already created an account?
            </Typography.Text>

            <Link to="/login"><Button>Go to login</Button></Link>
          </div>
        </div>

        {/* Use Ant Design's Card component to create a card with a white background */}
        <Card className="auth-card">
          <Typography.Text className="auth-form__eyebrow">
            Create account
          </Typography.Text>

          <Typography.Title level={2} className="auth-form__title">
            Register
          </Typography.Title>

          <Typography.Paragraph className="auth-form__copy">
            Create your account to start booking rooms.
          </Typography.Paragraph>

          {/* Use Ant Design's Form component to create a registration form */}
          <Form layout="vertical" onFinish={handleSubmit} initialValues={{ role: 'student' }}>

            {/* Form fields for username */}
            <Form.Item label="Username" name="username" rules={[{ required: true, message: 'Please enter a username' }]}>
              <Input autoComplete="username" />
            </Form.Item>

            {/* Form fields for email */}
            <Form.Item label="Email" name="email" rules={[{ required: true, message: 'Please enter your email' }, { type: 'email', message: 'Please enter a valid email' }]}>
              <Input autoComplete="email" />
            </Form.Item>

            {/* Form fields for password */}
            <Form.Item label="Password" name="password" rules={[{ required: true, message: 'Please enter a password' }, { min: 8, message: 'Password must be at least 8 characters' }]}>
              <Input.Password autoComplete="new-password" />
            </Form.Item>

            {/* Form field for role */}
            <Form.Item name="role" hidden>
              <Input type="hidden" />
            </Form.Item>

            {/* Submit button */}
            <Form.Item style={{ marginTop: 20 }}>
              <Button type="primary" htmlType="submit" block className="auth-submit-btn">
                Register
              </Button>
            </Form.Item>
          
          </Form>

          <Typography.Text className="auth-form__switch">
            Already have an account? <Link to="/login">Login</Link>
          </Typography.Text>
        </Card>

      </div>

    </div>
  );

}
