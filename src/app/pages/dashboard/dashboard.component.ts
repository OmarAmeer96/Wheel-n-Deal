import { Component } from '@angular/core';
import { DashCardComponent } from '../../shared/widgets/dash-card/dash-card.component';
import { PieChartComponent } from '../../shared/widgets/pie-chart/pie-chart.component';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss',
  imports: [DashCardComponent, PieChartComponent],
})
export class DashboardComponent {
  totalUsers = 100;
  totalOrders = 1000;
  totalCommuter = 291;
  totalRevenue = 100000;
}
