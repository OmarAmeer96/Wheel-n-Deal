import { Component } from '@angular/core';
import { SvgComponent } from '../svg/svg.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-toolbar',
  standalone: true,
  templateUrl: './toolbar.component.html',
  styleUrl: './toolbar.component.scss',
  imports: [SvgComponent, CommonModule],
})
export class ToolbarComponent {
  today = new Date();
}
