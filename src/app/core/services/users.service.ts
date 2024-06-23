import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { base_url } from '../constant/api-constant';
import { Observable } from 'rxjs';
import { UserResponse } from '../models/interfaces/users';

@Injectable({
  providedIn: 'root',
})
export class UsersService {
  constructor(private _http: HttpClient) {}

  getAllUsers(pageNum: number, pageSize: number): Observable<UserResponse> {
    return this._http.get<UserResponse>(
      `${base_url}/admin/users?pageNum=${pageNum}&pageSize=${pageSize}`
    );
  }
}
