import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class StatService {
  constructor(private _http: HttpClient) {}

  getStatisticalData() {}

  // getAllOrders(pageNum: number, pageSize: number): Observable<ApiResponse> {
  //   return this._http.get<ApiResponse>(
  //     `${base_url}/admin/orders?pageNum=${pageNum}&pageSize=${pageSize}`
  //   );
  // }
}
