import { Component, OnInit } from '@angular/core';
import { DashCardComponent } from '../../shared/widgets/dash-card/dash-card.component';
import { DoughnutChartComponent } from '../../shared/widgets/pie-chart/doughnut-chart.component';
import { StatService } from '../../core/services/stat.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss',
  imports: [DashCardComponent, DoughnutChartComponent],
})
export class DashboardComponent implements OnInit {
  numOfAllUsers!: number;
  numOfOrders!: number;
  numOfCommuters!: number;
  totalRevenue!: number;

  successfulOrders = 0;
  failureOrders = 0;
  pendingOrders = 0;
  totalOrders = this.successfulOrders + this.failureOrders + this.pendingOrders;

  constructor(private _stat: StatService) {}
  ngOnInit(): void {
    this.getStatisticalData();
  }

  getStatisticalData() {
    this._stat.getStatisticalData().subscribe({
      next: () => {
        const stats = this._stat.getStatVar(
          'numOfAllUsers',
          'numOfAllOrders',
          'numOfCommuters',
          'totalRevenue',
          'numOfInSuccessOrders',
          'numOfFailedOrders',
          'numOfPendingOrders'
        );

        // Destructure with default values
        const {
          numOfAllUsers = 0,
          numOfAllOrders = 0,
          numOfCommuters = 0,
          totalRevenue = 0,
          numOfInSuccessOrders = 0,
          numOfFailedOrders = 0,
          numOfPendingOrders = 0,
        } = stats;

        // Assign to instance variables
        this.numOfAllUsers = numOfAllUsers;
        this.numOfOrders = numOfAllOrders;
        this.numOfCommuters = numOfCommuters;
        this.totalRevenue = totalRevenue;
        this.successfulOrders = numOfInSuccessOrders;
        this.failureOrders = numOfFailedOrders;
        this.pendingOrders = numOfPendingOrders;
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
