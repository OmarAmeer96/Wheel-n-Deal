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

  public statisticalData!: DataModel;

  getStatVar(...keys: (keyof DataModel)[]) {
    return keys.reduce((obj, key) => {
      obj[key] = this.statisticalData[key];
      console.log(obj);

      return obj;
    }, {} as Partial<DataModel>);
  }

  getStatisticalData(): Observable<ResponseStatModel> {
    return this._http
      .get<ResponseStatModel>(`${base_url}/admin/count-all`)
      .pipe(
        tap((res) => {
          console.log('stat data ', res.data);
          this.statisticalData = res.data;
        })
      );
  }
}
