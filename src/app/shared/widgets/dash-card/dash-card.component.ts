import { Component, Input } from '@angular/core';
import { SvgComponent } from '../svg/svg.component';

@Component({
  selector: 'app-dash-card',
  standalone: true,
  templateUrl: './dash-card.component.html',
  styleUrl: './dash-card.component.scss',
  imports: [SvgComponent],
})
export class DashCardComponent {
  @Input() title!: string;
  @Input() icon!: string;
  @Input() data!: number;
}
