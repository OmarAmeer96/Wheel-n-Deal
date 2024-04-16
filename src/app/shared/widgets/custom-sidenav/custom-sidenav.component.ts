import { CommonModule } from '@angular/common';
import {
  Component,
  EventEmitter,
  Output,
  computed,
  signal,
} from '@angular/core';
import { RouterModule } from '@angular/router';
import { sidenavData } from '../../../core/constant/sidenav-data';
import { MenuItem } from '../../../core/utils/menuItem';
import { SvgComponent } from '../svg/svg.component';

@Component({
  selector: 'app-custom-sidenav',
  standalone: true,
  imports: [CommonModule, RouterModule, SvgComponent],
  templateUrl: './custom-sidenav.component.html',
  styleUrl: './custom-sidenav.component.scss',
})
export class CustomSidenavComponent {
  menuItems = signal<MenuItem[]>([...sidenavData]);
  @Output() sidenavToggle = new EventEmitter<boolean>();
  private collapsed = false;

  toggleSidenav() {
    this.collapsed = !this.collapsed;
    this.sidenavToggle.emit(this.collapsed);
  }

  sideNavCollapsed(): boolean {
    return this.collapsed;
  }

  sidenavWidth(): string {
    return this.collapsed ? '88px' : '260px';
  }
}
