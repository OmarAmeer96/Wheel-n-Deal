export interface OrderTableData {
  ID: number;
  Status: string;
  'Customer ID': string;
  'Commuter ID': string;
  From: string;
  To: string;
  'Order Name': string;
  'Expiry Data': string;
  Price: number;
  Amount: number;
  Breakable: boolean;
  Picture: string;
}

export interface UserTableData {
  id: number;
  username: string;
  phone: string;
  nationalId: string | null;
  gender: 'MALE' | 'FEMALE' | null;
  picture: string | null;
  totalOrders: number;
  canceledOrders: number;
  wallet: number;
}
