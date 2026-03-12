import { createBrowserRouter } from 'react-router-dom';
import AdminLayout from '../components/layout/AdminLayout';
import StudentLayout from '../components/layout/StudentLayout';
import ProtectedRoute from '../components/ProtectedRoute';
import RoleGuard from '../components/RoleGuard';
import AdminDashboardPage from '../pages/admin/AdminDashboardPage';
import BookingRequestsPage from '../pages/admin/BookingRequestsPage';
import RoomManagementPage from '../pages/admin/RoomManagementPage';
import LoginPage from '../pages/auth/LoginPage';
import RegisterPage from '../pages/auth/RegisterPage';
import LandingPage from '../pages/shared/LandingPage';
import NotFoundPage from '../pages/shared/NotFoundPage';
import ProfilePage from '../pages/shared/ProfilePage';
import BookingHistoryPage from '../pages/student/BookingHistoryPage';
import MyBookingsPage from '../pages/student/MyBookingsPage';
import RoomDetailPage from '../pages/student/RoomDetailPage';
import RoomsPage from '../pages/student/RoomsPage';
import StudentDashboardPage from '../pages/student/StudentDashboardPage';
import BuildingManagementPage from '../pages/admin/BuildingManagementPage';
import EquipmentManagementPage from '../pages/admin/EquipmentManagementPage';

// Define the application routes using React Router
export const router = createBrowserRouter([
  // Define the root route

  // the landing page
  { path: '/', element: <LandingPage /> },

  // the login pages
  { path: '/login', element: <LoginPage /> },

  // the register page
  { path: '/register', element: <RegisterPage /> },

  // the protected routes
  {
    // if the user is authenticated, render the child routes
    element: <ProtectedRoute />,
    children: [
      {
        // the student routes
        element: <RoleGuard role="student" />,
        children: [
          {
            path: '/student',
            element: <StudentLayout />,
            children: [
              // the student dashboard and set the default path
              { index: true, element: <StudentDashboardPage /> },

              // the student rooms page
              { path: 'rooms', element: <RoomsPage /> },

              // the student room detail page
              { path: 'rooms/:id', element: <RoomDetailPage /> },

              // the student my bookings page
              { path: 'bookings', element: <MyBookingsPage /> },

              // the student booking history page
              { path: 'history', element: <BookingHistoryPage /> },

              // the student profile page
              { path: 'profile', element: <ProfilePage /> },
            ],
          },
        ],
      },
      {
        // the admin routes
        element: <RoleGuard role="admin" />,
        children: [
          {
            path: '/admin',
            element: <AdminLayout />,
            children: [
              // the admin dashboard and set the default path
              { index: true, element: <AdminDashboardPage /> },

              // the admin room management page
              { path: 'rooms', element: <RoomManagementPage /> },
              
              // the admin building management page
              { path: 'buildings', element: <BuildingManagementPage /> },

              // the admin equipment management page
              { path: 'equipments', element: <EquipmentManagementPage /> },

              // the admin booking requests page
              { path: 'requests', element: <BookingRequestsPage /> },

              // the admin profile page
              { path: 'profile', element: <ProfilePage /> },
            ],
          },
        ],
      },
    ],
  },

  // the not found page
  { path: '*', element: <NotFoundPage /> },
]);
