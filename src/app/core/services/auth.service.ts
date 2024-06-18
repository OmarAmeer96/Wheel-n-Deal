import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { IAdmin } from '../models/interfaces/admin';
import { Observable } from 'rxjs';
import { base_url } from '../constant/api-constant';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(private _http: HttpClient) {}

  private baseUrl = base_url;

  logIn(formData: IAdmin): Observable<any> {
    console.log('formData', formData);
    // return this._http.post(`${this.baseUrl}/auth/signin`, formData);
    return this._http.post(
      'https://wheel-n-deal-production.up.railway.app/api/v1/auth/signin',
      formData
    );
  }
}
