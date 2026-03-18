import { lazy, Suspense, type ReactNode } from 'react';
import { createBrowserRouter } from 'react-router-dom';
import LoadingScreen from '../components/LoadingScreen';
import ProtectedRoute from '../components/ProtectedRoute';
import RoleGuard from '../components/RoleGuard';

const AdminLayout = lazy(() => import('../components/layout/AdminLayout'));
const StudentLayout = lazy(() => import('../components/layout/StudentLayout'));
const AdminDashboardPage = lazy(() => import('../pages/admin/AdminDashboardPage'));
const BookingRequestsPage = lazy(() => import('../pages/admin/BookingRequestsPage'));
const RoomManagementPage = lazy(() => import('../pages/admin/RoomManagementPage'));
const UserManagementPage = lazy(() => import('../pages/admin/UserManagementPage'));
const BuildingManagementPage = lazy(() => import('../pages/admin/BuildingManagementPage'));
const EquipmentManagementPage = lazy(() => import('../pages/admin/EquipmentManagementPage'));
const LoginPage = lazy(() => import('../pages/auth/LoginPage'));
const RegisterPage = lazy(() => import('../pages/auth/RegisterPage'));
const LandingPage = lazy(() => import('../pages/shared/LandingPage'));
const NotFoundPage = lazy(() => import('../pages/shared/NotFoundPage'));
const ProfilePage = lazy(() => import('../pages/shared/ProfilePage'));
const BookingHistoryPage = lazy(() => import('../pages/student/BookingHistoryPage'));
const MyBookingsPage = lazy(() => import('../pages/student/MyBookingsPage'));
const RoomDetailPage = lazy(() => import('../pages/student/RoomDetailPage'));
const RoomsPage = lazy(() => import('../pages/student/RoomsPage'));
const StudentDashboardPage = lazy(() => import('../pages/student/StudentDashboardPage'));

function lazyRoute(element: ReactNode, text = 'Loading page...') {
  return (
    <Suspense fallback={<LoadingScreen text={text} />}>
      {element}
    </Suspense>
  );
}

// Define the application routes using React Router
export const router = createBrowserRouter([
  // the landing page
  { path: '/', element: lazyRoute(<LandingPage />, 'Loading landing page...') },

  // the login page
  { path: '/login', element: lazyRoute(<LoginPage />, 'Loading login page...') },

  // the register page
  { path: '/register', element: lazyRoute(<RegisterPage />, 'Loading registration page...') },

  // the protected routes
  {
    element: <ProtectedRoute />,
    children: [
      {
        element: <RoleGuard role="student" />,
        children: [
          {
            path: '/student',
            element: lazyRoute(<StudentLayout />, 'Loading workspace...'),
            children: [
              { index: true, element: lazyRoute(<StudentDashboardPage />, 'Loading dashboard...') },
              { path: 'rooms', element: lazyRoute(<RoomsPage />, 'Loading rooms...') },
              { path: 'rooms/:id', element: lazyRoute(<RoomDetailPage />, 'Loading room details...') },
              { path: 'bookings', element: lazyRoute(<MyBookingsPage />, 'Loading bookings...') },
              { path: 'history', element: lazyRoute(<BookingHistoryPage />, 'Loading booking history...') },
              { path: 'profile', element: lazyRoute(<ProfilePage />, 'Loading profile...') },
            ],
          },
        ],
      },
      {
        element: <RoleGuard role="admin" />,
        children: [
          {
            path: '/admin',
            element: lazyRoute(<AdminLayout />, 'Loading admin workspace...'),
            children: [
              { index: true, element: lazyRoute(<AdminDashboardPage />, 'Loading admin dashboard...') },
              { path: 'rooms', element: lazyRoute(<RoomManagementPage />, 'Loading room management...') },
              { path: 'buildings', element: lazyRoute(<BuildingManagementPage />, 'Loading building management...') },
              { path: 'equipments', element: lazyRoute(<EquipmentManagementPage />, 'Loading equipment management...') },
              { path: 'requests', element: lazyRoute(<BookingRequestsPage />, 'Loading booking requests...') },
              { path: 'users', element: lazyRoute(<UserManagementPage />, 'Loading user management...') },
              { path: 'profile', element: lazyRoute(<ProfilePage />, 'Loading profile...') },
            ],
          },
        ],
      },
    ],
  },

  // the not found page
  { path: '*', element: lazyRoute(<NotFoundPage />, 'Loading page...') },
]);
