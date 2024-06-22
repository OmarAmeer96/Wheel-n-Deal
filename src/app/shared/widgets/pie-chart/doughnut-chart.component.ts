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
  @Input() totalOrders = 0;

  private myChart: Chart<'doughnut', number[], string> | null = null;
  chartData = {
    labels: ['Success', 'Failure', 'Pending'],
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
      changes['totalOrders']
    ) {
      this.updateChartData();
      this.renderChart();
    }
  }

  private updateChartData(): void {
    this.chartData.data = [
      this.successfulOrders,
      this.failureOrders,
      this.pendingOrders,
    ];
    this.totalOrders =
      this.successfulOrders + this.failureOrders + this.pendingOrders;
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
            backgroundColor: ['#00B074', '#ef3826', '#FF981A'],
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
