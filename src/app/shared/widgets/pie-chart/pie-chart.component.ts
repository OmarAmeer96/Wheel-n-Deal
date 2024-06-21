import {
  Component,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
} from '@angular/core';
import { Chart, Legend, registerables } from 'chart.js';
import { HighchartsChartModule } from 'highcharts-angular';

Chart.register(...registerables);
@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [HighchartsChartModule],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss',
})
export class PieChartComponent implements OnInit, OnChanges {
  @Input() successfulOrders = 0;
  @Input() failureOrders = 0;
  @Input() pendingOrders = 0;
  @Input() totalOrders = 0;
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

  updateChartData(): void {
    this.chartData.data = [
      this.successfulOrders,
      this.failureOrders,
      this.pendingOrders,
    ];
  }

  ngOnInit(): void {
    this.renderChart();
  }
  private myChart!: Chart<'doughnut', number[], string> | null;
  chartData = {
    labels: ['Success', 'Failure', 'Pending'],
    data: [this.successfulOrders, this.failureOrders, this.pendingOrders],
  };

  renderChart() {
    if (this.myChart) {
      // Destroy the existing chart instance
      this.myChart.destroy();
    }

    this.totalOrders =
      this.successfulOrders + this.failureOrders + this.pendingOrders;
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
            weight: 1,
          },
        ],
      },
      options: {
        responsive: true, // Makes the chart responsive
        plugins: {
          legend: {
            display: false,
          },
          tooltip: {
            enabled: true, // Enables tooltips
          },
        },
        cutout: '70%', // Adjust the size of the inner cutout
        rotation: 90, // Rotates the chart by -90 degrees
        animation: {
          animateRotate: true, // Animates the rotation of the chart
          animateScale: true, // Animates the scaling of the chart
        },
      },
    });
  }
}
