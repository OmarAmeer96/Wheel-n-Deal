import { Component } from '@angular/core';
import { HighchartsChartModule } from 'highcharts-angular';
// import * as Highcharts from 'highcharts';
import * as Highcharts from 'highcharts/highstock';

@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [HighchartsChartModule],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss',
})
export class PieChartComponent {
  Highcharts: typeof Highcharts = Highcharts;
  chartOptions: Highcharts.Options = {
    series: [
      {
        data: [1, 2, 3],
        type: 'pie',
      },
    ],
  };
}
