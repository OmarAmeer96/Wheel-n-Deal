export interface OrderCreatedLastWeek {
  date: string;
  count: number;
}

export const ordersCreatedLastWeek: OrderCreatedLastWeek[] = [
  { date: 'Monday', count: 4 },
  { date: 'Tuesday', count: 2 },
  { date: 'Wednesday', count: 1 },
  { date: 'Thursday', count: 2 },
  { date: 'Friday', count: 1 },
  { date: 'Saturday', count: 1 },
  { date: 'Sunday', count: 5 },
];

export interface chartData {
  labels: string[];
  data: number[];
}
