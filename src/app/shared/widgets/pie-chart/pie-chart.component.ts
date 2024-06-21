import { Component } from '@angular/core';
import { Chart, registerables } from 'chart.js';
import { HighchartsChartModule } from 'highcharts-angular';
// import * as Highcharts from 'highcharts';
import * as Highcharts from 'highcharts/highstock';
Chart.register(...registerables);
@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [HighchartsChartModule],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss',
})
export class PieChartComponent {}
