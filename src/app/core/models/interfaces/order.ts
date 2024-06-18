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
