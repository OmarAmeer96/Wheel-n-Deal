export interface ResponseStatModel {
  status: number;
  message: string;
  data: DataModel;
}

export interface DataModel {
  numOfAllUsers: number;
  numOfCustomers: number;
  numOfCommuters: number;
  numOfOrders: number;
  totalRevenue: number;
}
