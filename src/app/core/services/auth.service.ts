import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AdminResponse, IAdmin } from '../models/interfaces/admin';
import { Observable, catchError, throwError } from 'rxjs';
import { base_url } from '../constant/api-constant';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(private _http: HttpClient) {}

  private baseUrl = base_url;

  logIn(formData: IAdmin): Observable<AdminResponse> {
    console.log('Attempting to log in with formData', formData);
    const httpOptions = {
      headers: new HttpHeaders({}), // Explicitly setting headers to an empty object
    };
    return this._http
      .post<AdminResponse>(`${this.baseUrl}/auth/signin`, formData, httpOptions)
      .pipe(
        catchError((error) => {
          console.error('Login error:', error);
          return throwError(() => error);
        })
      );
  }
}
