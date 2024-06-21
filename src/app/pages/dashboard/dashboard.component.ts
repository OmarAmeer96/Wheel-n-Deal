import { Component, OnInit } from '@angular/core';
import { DashCardComponent } from '../../shared/widgets/dash-card/dash-card.component';
import { PieChartComponent } from '../../shared/widgets/pie-chart/pie-chart.component';
import { StatService } from '../../core/services/stat.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss',
  imports: [DashCardComponent, PieChartComponent],
})
export class DashboardComponent implements OnInit {
  numOfAllUsers!: number;
  numOfOrders!: number;
  numOfCommuters!: number;
  totalRevenue!: number;

  constructor(private _stat: StatService) {}
  ngOnInit(): void {
    this.getStatisticalData();
  }

  getStatisticalData() {
    this._stat.getStatisticalData().subscribe({
      next: (res) => {
        console.log('res', res);
        const {
          numOfAllUsers = 0,
          numOfAllOrders = 0,
          numOfCommuters = 0,
          totalRevenue = 0,
        } = this._stat.getStatVar(
          'numOfAllUsers',
          'numOfAllOrders',
          'numOfCommuters',
          'totalRevenue'
        );
        this.numOfAllUsers = numOfAllUsers;
        this.numOfOrders = numOfAllOrders;
        this.numOfCommuters = numOfCommuters;
        this.totalRevenue = totalRevenue;
      },
      error: (error) => {
        console.error('Error fetching statistical data:', error);
      },
      complete: () => {},
    });
  }
}

/*
 numOfAllUsers: number;
  numOfCustomers: number;
  numOfCommuters: number;
  numOfOrders: number;
  totalRevenue: number;
*/
