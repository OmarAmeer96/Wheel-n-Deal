import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AdminResponse, IAdmin } from '../models/interfaces/admin';
import { Observable } from 'rxjs';
import { base_url } from '../constant/api-constant';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(private _http: HttpClient) {}

  private baseUrl = base_url;

  logIn(formData: IAdmin): Observable<AdminResponse> {
    console.log('formData', formData);
    return this._http.post<AdminResponse>(
      `${this.baseUrl}/auth/signin`,
      formData
    );
  }
}
// return this._http.post(
//   'https://wheel-n-deal-production.up.railway.app/api/v1/auth/signin',
//   formData
// );
