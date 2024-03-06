import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SvgIconService {
  constructor(private _http: HttpClient, private _sanitizer: DomSanitizer) {}

  getSvg(name: string): Observable<string> {
    return this._http.get(`assets/SVGs/${name}.svg`, {
      responseType: 'text',
    });
  }
}
