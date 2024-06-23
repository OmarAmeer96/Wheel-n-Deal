export interface ToggleDataModel {
  title: string;
  status: string;
}

export const ToggleStaticsData: ToggleDataModel[] = [
  {
    title: 'All',
    status: 'all',
  },
  {
    title: 'Not_Active',
    status: 'not_active',
  },
  {
    title: 'Pending',
    status: 'pending',
  },
  {
    title: 'Confirmed',
    status: 'confirmed',
  },
  {
    title: 'In-Progress',
    status: 'in-progress',
  },
  {
    title: 'Success',
    status: 'success',
  },
  {
    title: 'Failed',
    status: 'FAILED  ',
  },
];

export const ToggleUserData: ToggleDataModel[] = [
  {
    title: 'All',
    status: 'all',
  },
  {
    title: 'Commuter',
    status: 'commuter',
  },
  {
    title: 'User',
    status: 'user',
  },
];
