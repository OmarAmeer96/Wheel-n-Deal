import { Component } from '@angular/core';
import { SvgComponent } from '../../shared/svg/svg.component';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [SvgComponent],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss',
})
export class LoginComponent {}
