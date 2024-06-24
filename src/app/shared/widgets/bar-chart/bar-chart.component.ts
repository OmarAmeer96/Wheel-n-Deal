import {
  Component,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
} from '@angular/core';

import { Chart, registerables } from 'chart.js';
import {
  OrderCreatedLastWeek,
  chartData,
} from '../../../core/models/interfaces/charts';
import { StatService } from '../../../core/services/stat.service';

Chart.register(...registerables);
@Component({
  selector: 'app-bar-chart',
  standalone: true,
  imports: [],
  templateUrl: './bar-chart.component.html',
  styleUrl: './bar-chart.component.scss',
})
export class BarChartComponent implements OnInit, OnChanges {
  // ordersPerDay!: OrderCreatedLastWeek[];
  // chartData!: chartData;
  // private myChart: Chart<'bar', number[], string> | null = null;
  @Input() title: string = 'Orders Last Week'; // Title of the chart
  @Input() chartId: string = 'BarChart'; // Unique identifier for the chart
  @Input() labels: string[] = [];
  @Input() data: number[] = [];
  @Input() chartOptions: any = {
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
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          stepSize: 1,
        },
      },
      x: {
        grid: {
          offset: true,
        },
      },
    },
  }; // Chart options for customization
  @Input() chartType: string = 'bar'; // Chart type, default is 'bar'
  @Input() backgroundColor: string[] = [
    'rgba(255, 99, 132, 0.2)',
    'rgba(255, 159, 64, 0.2)',
    'rgba(255, 205, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(201, 203, 207, 0.2)',
  ];
  @Input() borderColor: string[] = [
    'rgb(255, 99, 132)',
    'rgb(255, 159, 64)',
    'rgb(255, 205, 86)',
    'rgb(75, 192, 192)',
    'rgb(54, 162, 235)',
    'rgb(153, 102, 255)',
    'rgb(201, 203, 207)',
  ];
  @Input() lable: string = 'Orders';
  private myChart: Chart<'bar', number[], string> | null = null;

  constructor(private _stat: StatService) {}
  ngOnInit(): void {
    this.renderChart();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['labels'] || changes['data'] || changes['chartOptions']) {
      this.renderChart();
    }
  }

  // featchChartData() {
  //   this._stat.getOrdersLastWeek().subscribe((data) => {
  //     console.log('chart data', data);

  //     this.ordersPerDay = data;
  //     this.chartData = {
  //       labels: this.ordersPerDay.map((order) => order.date),
  //       data: this.ordersPerDay.map((order) => order.count),
  //     };
  //     this.myChart?.destroy();
  //     this.renderChart();
  //   });
  // }

  // renderChart(): void {
  //   this.myChart = new Chart('OrderChart', {
  //     type: 'bar',
  //     data: {
  //       labels: this.chartData.labels,
  //       datasets: [
  //         {
  //           label: 'Orders',
  //           data: this.chartData.data,
  //           backgroundColor: [
  //             'rgba(255, 99, 132, 0.2)',
  //             'rgba(255, 159, 64, 0.2)',
  //             'rgba(255, 205, 86, 0.2)',
  //             'rgba(75, 192, 192, 0.2)',
  //             'rgba(54, 162, 235, 0.2)',
  //             'rgba(153, 102, 255, 0.2)',
  //             'rgba(201, 203, 207, 0.2)',
  //           ],
  //           borderColor: [
  //             'rgb(255, 99, 132)',
  //             'rgb(255, 159, 64)',
  //             'rgb(255, 205, 86)',
  //             'rgb(75, 192, 192)',
  //             'rgb(54, 162, 235)',
  //             'rgb(153, 102, 255)',
  //             'rgb(201, 203, 207)',
  //           ],
  //           borderWidth: 1,
  //         },
  //       ],
  //     },
  //     options: {
  //       responsive: true,
  //       maintainAspectRatio: true,
  //       plugins: {
  //         legend: {
  //           display: false,
  //         },
  //         tooltip: {
  //           enabled: true,
  //         },
  //       },
  //       scales: {
  //         y: {
  //           beginAtZero: true,
  //           ticks: {
  //             stepSize: 1,
  //           },
  //         },
  //         x: {
  //           grid: {
  //             offset: true,
  //           },
  //         },
  //       },
  //     },
  //   });
  // }

  private renderChart(): void {
    if (this.myChart) {
      this.myChart.destroy();
    }
    this.myChart = new Chart(this.chartId, {
      type: this.chartType as any,
      data: {
        labels: this.labels,
        datasets: [
          {
            label: this.lable,
            data: this.data,
            backgroundColor: this.backgroundColor,
            borderColor: this.borderColor,
            borderWidth: 1,
          },
        ],
      },
      options: {
        ...this.chartOptions,
      },
    });
  }
}
