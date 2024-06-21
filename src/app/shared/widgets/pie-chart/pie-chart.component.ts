import { Component, OnInit } from '@angular/core';
import { Chart, Legend, registerables } from 'chart.js';
import { HighchartsChartModule } from 'highcharts-angular';

import { StatService } from '../../../core/services/stat.service';
Chart.register(...registerables);
@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [HighchartsChartModule],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss',
})
export class PieChartComponent implements OnInit {
  constructor(private _stat: StatService) {}
  ngOnInit(): void {
    this.renderChart();
  }

  totalOrders = 100;
  successfulOrders = 30;
  failureOrders = 35;
  pendingOrders = 35;

  chartData = {
    labels: ['Success', 'Failure', 'Pending'],
    data: [this.successfulOrders, this.failureOrders, this.pendingOrders],
  };

  loadchartData() {}

  renderChart() {
    const myChart = new Chart('myChart', {
      type: 'doughnut',
      data: {
        labels: this.chartData.labels,
        datasets: [
          {
            label: 'Orders',
            data: this.chartData.data,
            backgroundColor: ['#00B074', '#ef3826', '#FF981A'],
            hoverOffset: 3,
            borderWidth: 10,
            borderRadius: 2,
            hoverBorderWidth: 0,
          },
        ],
      },
      options: {
        plugins: {
          legend: {
            display: false,
          },
        },
      },
    });
  }
}

// renderChart__(chartId: string, chartType: any) {
//   const myChart = new Chart(chartId, {
//     type: chartType,
//     data: {
//       labels: ['Success', 'Failure', 'Pending'],
//       datasets: [
//         {
//           label: 'Orders',
//           data: [
//             this.successfulOrders,
//             this.failureOrders,
//             this.pendingOrders,
//           ],
//           backgroundColor: ['#00B074', 'rgb(255, 99, 132)', '#FF981A'],
//           hoverOffset: 3,
//         },
//       ],
//     },
//     options: {
//       Legend: {
//         position: 'right',
//       },
//     },
//   });
// }
