import { LogoutOutlined, UserOutlined } from '@ant-design/icons';
import { Avatar, Button, Dropdown, Layout, Space, Typography, type MenuProps } from 'antd';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { getProfileRouteByRole } from '../utils/defaultRoute';

export default function AppHeader() {
  // Application name
  const appName = 'StudyNest Reserve';


  // Get the user information and logout function from the AuthContext
  const { user, logout } = useAuth();

  // Get the navigate function from react-router
  const navigate = useNavigate();

  const roleLabel = user?.role === 'admin' ? 'Administrator' : 'Student';


  // Handle the logout action by calling the logout function and navigating to the login page
  const handleLogout = () => {
    logout();
    navigate('/login');
  };


  // Handle dropdown menu click
  const handleMenuClick: MenuProps['onClick'] = ({ key }) => {
    if (!user) {
      return;
    }

    if (key === 'profile') {
      navigate(getProfileRouteByRole(user.role));
      return;
    }

    if (key === 'logout') {
      handleLogout();
    }
  };

  const menuItems: MenuProps['items'] = [
    {
      key: 'profile',
      icon: <UserOutlined />,
      label: 'Profile',
    },
    {
      key: 'logout',
      icon: <LogoutOutlined />,
      label: 'Logout',
    },
  ];

  //
  return (
    // Use Ant Design's Layout.Header component to create a cleaner app shell header
    <Layout.Header className="topbar">

      <div className="topbar__inner">

        {/* Use Link to create a link to the home page */}
        <Link to="/" className="brand-link" style={{ color: 'inherit' }}>

          {/* Use a brand block to layout the logo and title */}
          <div className="brand">

            {/* Logo of the application */}
            <div className="brand__mark">
              <img
                src="/studynest-mark.png"
                alt={`${appName} logo`}
                style={{
                  width: '100%',
                  height: '100%',
                  objectFit: 'contain'
                }}
              />
            </div>

            {/* Title of the application */}
            <div className="brand__copy">
              <Typography.Text className="brand__eyebrow">
                Campus room booking
              </Typography.Text>

              <Typography.Title level={4} className="brand__title">
                {appName}
              </Typography.Title>
            </div>


          </div>

        </Link>

        {/* If the user is logged in, show their username and role,
        along with a logout button. Otherwise, show login and register buttons. */}
        <Space className="topbar__actions">
          {user ? (
            <Dropdown menu={{ items: menuItems, onClick: handleMenuClick }} trigger={['click']}>
              <Button type="text" className="user-chip">
                <Space size="small">
                  <Avatar icon={<UserOutlined />} />

                  <div className="user-chip__meta">
                    <Typography.Text className="user-chip__name">{user.username}</Typography.Text>
                    <Typography.Text type="secondary" className="user-chip__role">
                      {roleLabel}
                    </Typography.Text>
                  </div>
                </Space>
              </Button>
            </Dropdown>
          ) : (
            <>
              <Link to="/login"><Button>Login</Button></Link>
              <Link to="/register"><Button type="primary" className="topbar__cta">Create account</Button></Link>
            </>
          )}
        </Space>

      </div>

    </Layout.Header>
  );

}
