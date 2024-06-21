export interface IAdmin {
  userName: string;
  password: string;
}

export interface AdminData {
  role: string;
  stripeId: null | string;
  userId: number;
  token: string;
  refreshToken: string;
}

export interface AdminResponse {
  status: number;
  message: string;
  data: AdminData;
}
