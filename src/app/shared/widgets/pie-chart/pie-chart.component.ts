import {
  Component,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
} from '@angular/core';

import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss',
})
export class PieChartComponent implements OnInit, OnChanges {
  @Input() numOfAllCustomers: number = 0;
  @Input() numOfAllCommuters: number = 0;

  private myChart: Chart<'pie', number[], string> | null = null;

  chartData = {
    labels: ['Customers', 'Commuters'],
    data: [this.numOfAllCustomers, this.numOfAllCommuters],
  };

  ngOnInit(): void {
    this.updateChartData();
    this.renderChart();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['numOfAllCustomers'] || changes['numOfAllCommuters']) {
      this.updateChartData();
      this.renderChart();
    }
  }

  private updateChartData() {
    this.chartData.data = [this.numOfAllCustomers, this.numOfAllCommuters];
  }

  private renderChart() {
    if (this.myChart) {
      this.myChart.data.datasets[0].data = this.chartData.data;
      this.myChart.update();
      return;
    }

    this.myChart = new Chart('UserPieChart', {
      type: 'pie',
      data: {
        labels: this.chartData.labels,
        datasets: [
          {
            data: this.chartData.data,
            backgroundColor: ['#83b4bf', '#9e9e9e'],
            hoverBackgroundColor: ['#83b4bf80', '#9e9e9e80'],
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
            backgroundColor: '#fff',
            titleAlign: 'center',
            bodyFont: {
              family: 'Inter',
              size: 21,
              style: 'normal',
              weight: 'bolder',
            },
            bodyAlign: 'center',
            bodySpacing: 19,
            padding: 19,
            bodyColor: '#333',
            titleColor: '#333',
          },
        },
      },
    });
  }
}
