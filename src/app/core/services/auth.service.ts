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

  private baseUrl = 'https://wheel-n-deal-production.up.railway.app/api/v1';

  logIn(formData: IAdmin): Observable<any> {
    return this._http.post(`${this.baseUrl}/auth/signin`, formData);
  }
}
