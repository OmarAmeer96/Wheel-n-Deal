import { Component, computed, signal } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CustomSidenavComponent } from '../../shared/widgets/custom-sidenav/custom-sidenav.component';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [RouterModule, CustomSidenavComponent],
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.scss',
})
export class AdminComponent {
  collapsed = signal(false);
  sidenavWidth = '260px'; // initialize with the default value

  // set sideNavCollapsed(value: boolean) {
  //   console.log('sideNavCollapsed setter called with:', value);
  //   this.collapsed.set(value);
  //   this.sidenavWidth = value ? '88px' : '260px';
  //   console.log('sidenavWidth set to:', this.sidenavWidth);
  // }

  onSidenavToggle(collapsed: boolean) {
    console.log('onSidenavToggle called with:', collapsed);
    this.sidenavWidth = collapsed ? '88px' : '260px';
    console.log('sidenavWidth set to:', this.sidenavWidth);
  }
}
