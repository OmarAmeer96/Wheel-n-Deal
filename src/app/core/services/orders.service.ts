import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { base_url } from '../constant/api-constant';
import { ApiResponse } from '../models/interfaces/order';

@Injectable({
  providedIn: 'root',
})
export class OrdersService {
  constructor(private _http: HttpClient) {}

  getAllOrders(pageNum: number, pageSize: number): Observable<ApiResponse> {
    return this._http.get<ApiResponse>(
      `${base_url}/admin/orders?pageNum=${pageNum}&pageSize=${pageSize}`
    );
  }
}
