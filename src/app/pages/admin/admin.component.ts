import { Component, OnInit, computed, signal } from '@angular/core';
import { RouterModule } from '@angular/router';
import { map } from 'rxjs';
import { SidenavService } from '../../core/services/sidenav.service';
import { CommonModule } from '@angular/common';
import { CustomSidenavComponent } from '../../shared/widgets/custom-sidenav/custom-sidenav.component';
import { StatService } from '../../core/services/stat.service';
import { ToolbarComponent } from '../../shared/widgets/toolbar/toolbar.component';

@Component({
  selector: 'app-admin',
  standalone: true,
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.scss',
  imports: [
    RouterModule,
    CustomSidenavComponent,
    CommonModule,
    ToolbarComponent,
  ],
})
export class AdminComponent implements OnInit {
  sidenavWidth$ = this.sidenavService.sidenavState$.pipe(
    map((collapsed) => (collapsed ? '88px' : '260px'))
  );

  constructor(
    private sidenavService: SidenavService,
    private _stat: StatService
  ) {}
  ngOnInit(): void {
    this._stat.getStatisticalData().subscribe({
      next: () => {
        console.log('hi from admin');
      },
    });
  }
}
