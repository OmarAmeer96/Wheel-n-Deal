import { MenuItem } from '../utils/menuItem';

export const sidenavData: MenuItem[] = [
  {
    routerLink: 'dashboard',
    icon: 'fas fa-home',
    label: 'Dashboard',
  },
  {
    routerLink: 'users',
    icon: 'fas fa-user',
    label: 'Users',
  },
  {
    routerLink: 'orders',
    icon: 'fas fa-box',
    label: 'Orders',
  },
  {
    routerLink: 'support',
    icon: 'fas fa-handshake-angle',
    label: 'Support',
  },
  {
    routerLink: 'payments',
    icon: 'fas fa-credit-card',
    label: 'Payments',
  },
];
