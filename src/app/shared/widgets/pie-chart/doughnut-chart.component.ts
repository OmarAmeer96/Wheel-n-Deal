import {
  Component,
  Input,
  OnChanges,
  SimpleChanges,
  OnInit,
} from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  selector: 'app-doughnut-chart',
  standalone: true,
  imports: [],
  templateUrl: './doughnut-chart.component.html',
  styleUrls: ['./doughnut-chart.component.scss'],
})
export class DoughnutChartComponent implements OnInit, OnChanges {
  @Input() successfulOrders = 0;
  @Input() failureOrders = 0;
  @Input() pendingOrders = 0;
  @Input() confirmiedOrders = 0;
  @Input() not_activeOrders = 0;
  @Input() in_progressOrders = 0;
  @Input() returnedOrders = 0;
  @Input() totalOrders = 7;

  private myChart: Chart<'doughnut', number[], string> | null = null;
  chartData = {
    labels: [
      'Not Active',
      'Pending',
      'Confirmed',
      'In-Progress',
      'Success',
      'Failed',
      'Returned',
    ],
    data: [] as number[],
  };

  ngOnInit(): void {
    this.updateChartData();
    this.renderChart();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (
      changes['successfulOrders'] ||
      changes['failureOrders'] ||
      changes['pendingOrders'] ||
      changes['totalOrders'] ||
      changes['confirmiedOrders'] ||
      changes['not_activeOrders'] ||
      changes['in_progressOrders'] ||
      changes['returnedOrders']
    ) {
      this.updateChartData();
      this.renderChart();
    }
  }

  private updateChartData(): void {
    this.chartData.data = [
      this.not_activeOrders,
      this.pendingOrders,
      this.confirmiedOrders,
      this.in_progressOrders,
      this.successfulOrders,
      this.failureOrders,
      this.returnedOrders,
    ];
    this.totalOrders =
      this.successfulOrders +
      this.failureOrders +
      this.pendingOrders +
      this.confirmiedOrders +
      this.not_activeOrders +
      this.in_progressOrders +
      this.returnedOrders;
  }

  private renderChart(): void {
    if (this.myChart) {
      this.myChart.data.datasets[0].data = this.chartData.data;
      this.myChart.update();
      return;
    }

    this.myChart = new Chart('myChart', {
      type: 'doughnut',
      data: {
        labels: this.chartData.labels,
        datasets: [
          {
            label: 'Orders',
            data: this.chartData.data,
            backgroundColor: [
              '#D3D3D3', // Not_Active: Light Gray
              '#FFA500', // Pending: Orange
              '#4CAF50', // Confirmed: Green
              '#2196F3', // In-Progress: Blue
              '#8BC34A', // Success: Light Green
              '#f44336', // Failed: Red
              '#9C27B0', // Returned: Purple
            ],
            hoverOffset: 1,
            borderWidth: 10,
            borderRadius: 6,
            hoverBorderWidth: 0,
            borderAlign: 'center',
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
          legend: {
            display: false,
          },
          tooltip: {
            enabled: true,
          },
        },
        cutout: '70%',
        rotation: 90,
        animation: {
          animateRotate: true,
          animateScale: true,
        },
      },
    });
  }
}
