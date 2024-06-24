import { Component, OnInit } from '@angular/core';
import { DashCardComponent } from '../../shared/widgets/dash-card/dash-card.component';
import { DoughnutChartComponent } from '../../shared/widgets/pie-chart/doughnut-chart.component';
import { StatService } from '../../core/services/stat.service';
import { BarChartComponent } from '../../shared/widgets/bar-chart/bar-chart.component';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss',
  imports: [DashCardComponent, DoughnutChartComponent, BarChartComponent],
})
export class DashboardComponent implements OnInit {
  numOfAllUsers!: number;
  numOfOrders!: number;
  numOfCommuters!: number;
  totalRevenue!: number;

  numOfAllOrders = 0;
  NotActiveOrders = 0;
  pendingOrders = 0;
  confirmedOrders = 0;
  inProgressOrders = 0;
  successfulOrders = 0;
  failureOrders = 0;
  ReturnedOrders = 0;
  totalOrders =
    this.successfulOrders +
    this.failureOrders +
    this.pendingOrders +
    this.confirmedOrders +
    this.NotActiveOrders +
    this.inProgressOrders +
    this.ReturnedOrders;

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
          'numOfNotActiveOrders',
          'numOfPendingOrders',
          'numOfInProgressOrders',
          'numOfInSuccessOrders',
          'numOfFailedOrders',
          'numOfInReturnedOrders'
        );

        // Destructure with default values
        const {
          numOfAllUsers = 0,
          numOfAllOrders = 0,
          numOfCommuters = 0,
          totalRevenue = 0,
          numOfNotActiveOrders = 0,
          numOfPendingOrders = 0,
          numOfConfirmedOrders = 0,
          numOfInProgressOrders = 0,
          numOfInSuccessOrders = 0,
          numOfFailedOrders = 0,
          numOfInReturnedOrders = 0,
        } = stats;

        // Assign to instance variables
        this.numOfAllUsers = numOfAllUsers;
        this.numOfOrders = numOfAllOrders;
        this.numOfCommuters = numOfCommuters;
        this.totalRevenue = totalRevenue;
        this.successfulOrders = numOfInSuccessOrders;
        this.failureOrders = numOfFailedOrders;
        this.ReturnedOrders = numOfInReturnedOrders;
        this.NotActiveOrders = numOfNotActiveOrders;
        this.pendingOrders = numOfPendingOrders;
        this.confirmedOrders = numOfConfirmedOrders;
        this.inProgressOrders = numOfInProgressOrders;
      },
      error: (error) => {
        console.error('Error fetching statistical data:', error);
      },
      complete: () => {},
    });
  }
}
