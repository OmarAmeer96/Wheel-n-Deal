import { IPageable, ISort } from './order';

export interface IUser {
  id: number;
  phoneNumber: string;
  username: string;
  amount: number;
  gender: string | null;
  profilePictureUrl: string | null;
  nationalId: string | null;
  totalDelivers: number;
  cancelDelivers: number;
  role: string;
}

export interface UserData {
  content: IUser[];
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

export interface UserResponse {
  status: number;
  message: string;
  data: UserData;
}
