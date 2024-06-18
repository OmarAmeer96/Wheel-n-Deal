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
    title: 'Pending',
    status: 'pending',
  },
  {
    title: 'Active',
    status: 'active',
  },
  {
    title: 'In-Progress',
    status: 'in-progress',
  },
  {
    title: 'Canceled',
    status: 'canceled',
  },
];
