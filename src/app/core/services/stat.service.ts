import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { DataModel, ResponseStatModel } from '../models/interfaces/statistical';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { base_url } from '../constant/api-constant';

@Injectable({
  providedIn: 'root',
})
export class StatService {
  private _statisticalData = new BehaviorSubject<DataModel>({} as DataModel); // Initialize with an empty object or default value

  constructor(private _http: HttpClient) {}

  getStatVar(...keys: (keyof DataModel)[]) {
    const currentData = this._statisticalData.value;
    console.log('getVar', currentData);

    return keys.reduce((obj, key) => {
      obj[key] = currentData[key];
      return obj;
    }, {} as Partial<DataModel>);
  }

  getStatisticalData(): Observable<ResponseStatModel> {
    return this._http
      .get<ResponseStatModel>(`${base_url}/admin/count-all`)
      .pipe(
        tap((res) => {
          this._statisticalData.next(res.data); // Update the BehaviorSubject value
        })
      );
  }

  // Method to allow components to subscribe to changes
  get statisticalData(): Observable<DataModel> {
    return this._statisticalData.asObservable();
  }
}
