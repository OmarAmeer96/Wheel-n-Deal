import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SidenavService {
  private _sidenavState = new BehaviorSubject<boolean>(false);
  sidenavState$ = this._sidenavState.asObservable();

  toggleSidenav() {
    this._sidenavState.next(!this._sidenavState.value);
  }
}
