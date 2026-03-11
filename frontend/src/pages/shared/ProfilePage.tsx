import { Card, Descriptions, Typography } from 'antd';
import { useAuth } from '../../contexts/AuthContext';

export default function ProfilePage() {

  // Get the user information from the AuthContext
  const { user } = useAuth();

  return (
    <Card>
      {/* Title for the profile section */}
      <Typography.Title level={3}>Profile</Typography.Title>

      {/* Use Descriptions to display the user information in a bordered table */}
      <Descriptions column={1} bordered>

        {/* username */}
        <Descriptions.Item label="Username">{user?.username}</Descriptions.Item>

        {/* email */}
        <Descriptions.Item label="Email">{user?.email || '-'}</Descriptions.Item>

        {/* role */}
        <Descriptions.Item label="Role">{user?.role}</Descriptions.Item>
      </Descriptions>
    </Card>
  );
}
