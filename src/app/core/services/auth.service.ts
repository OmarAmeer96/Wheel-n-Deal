import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { IAdmin } from '../models/interfaces/admin';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(private _http: HttpClient) {}

  private baseUrl = '';

  logIn(formData: IAdmin): Observable<any> {
    return this._http.post(`${this.baseUrl}/login`, formData);
  }
}
