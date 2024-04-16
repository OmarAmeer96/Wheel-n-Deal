import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CustomSidenavComponent } from './shared/widgets/custom-sidenav/custom-sidenav.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CustomSidenavComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = "Wheel N' Deal";
}
