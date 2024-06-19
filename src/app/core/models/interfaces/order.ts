export interface IOrder {
  id: number;
  orderName: string;
  countOfOrders: number;
  breakable: boolean;
  expiryDate: string;
  expectedPrice: number;
  orderPhotoUrl: string;
  from: string;
  to: string;
  senderPhoneNumber: string;
  receiverPhoneNumber: string;
  orderStatus: string;
}

export interface ISort {
  direction: string;
  property: string;
  ignoreCase: boolean;
  nullHandling: string;
  ascending: boolean;
  descending: boolean;
}

export interface IPageable {
  pageNumber: number;
  pageSize: number;
  sort: ISort[];
  offset: number;
  unpaged: boolean;
  paged: boolean;
}

export interface OrdersResponse {
  content: IOrder[];
  pageable: IPageable;
  totalPages: number;
  totalElements: number;
  last: boolean;
  size: number;
  number: number;
  sort: ISort[];
  numberOfElements: number;
  first: boolean;
  empty: boolean;
}

export interface ApiResponse {
  status: number;
  message: string;
  data: OrdersResponse;
}
