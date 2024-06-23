import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { StatService } from './core/services/stat.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = "Wheel N' Deal";

  constructor(private _stat: StatService) {}

  // ngOnInit(): void {
  //   this._stat.getStatisticalData().subscribe({
  //     next: (res) => {
  //       console.log('res', res.message);
  //     },
  //   });
  // }
}
