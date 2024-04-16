import { Component } from '@angular/core';
import { MenuItem } from '../../../core/utils/menuItem';
import { SidenavService } from '../../../core/services/sidenav.service';
import { map } from 'rxjs/operators';
import { sidenavData } from '../../../core/constant/sidenav-data';
import { SvgComponent } from '../svg/svg.component';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  imports: [RouterModule, CommonModule, SvgComponent],
  selector: 'app-custom-sidenav',
  templateUrl: './custom-sidenav.component.html',
  styleUrls: ['./custom-sidenav.component.scss'],
})
export class CustomSidenavComponent {
  menuItems: MenuItem[] = [...sidenavData];

  sidenavCollapsed$ = this.sidenavService.sidenavState$;
  sidenavWidth$ = this.sidenavService.sidenavState$.pipe(
    map((collapsed) => (collapsed ? '88px' : '260px'))
  );

  constructor(private sidenavService: SidenavService) {}

  toggleSidenav() {
    this.sidenavService.toggleSidenav();
  }
}
