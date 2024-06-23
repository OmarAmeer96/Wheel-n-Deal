export interface ResponseStatModel {
  status: number;
  message: string;
  data: DataModel;
}

export interface DataModel {
  numOfAllUsers: number;
  numOfCustomers: number;
  numOfCommuters: number;
  totalRevenue: number;
  numOfAllOrders: number;
  numOfNotActiveOrders: number;
  numOfPendingOrders: number;
  numOfConfirmedOrders: number;
  numOfInProgressOrders: number;
  numOfInSuccessOrders: number;
  numOfFailedOrders: number;
  numOfInReturnedOrders: number;
}

export interface ICard {
  record: number;
  label: string;
}
