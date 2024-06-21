import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { DataModel, ResponseStatModel } from '../models/interfaces/statistical';
import { Observable, tap } from 'rxjs';
import { base_url } from '../constant/api-constant';

@Injectable({
  providedIn: 'root',
})
export class StatService {
  constructor(private _http: HttpClient) {}

  private statisticalData!: DataModel;

  getStatVar(...keys: (keyof DataModel)[]) {
    return keys.reduce((obj, key) => {
      obj[key] = this.statisticalData[key];
      return obj;
    }, {} as Partial<DataModel>);
  }

  getStatisticalData(): Observable<ResponseStatModel> {
    return this._http.get<ResponseStatModel>(`${base_url}/admin/count`).pipe(
      tap((res) => {
        this.statisticalData = res.data;
      })
    );
  }
}
