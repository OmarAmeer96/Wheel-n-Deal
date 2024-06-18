import { Component, Input } from '@angular/core';
import { SvgComponent } from '../svg/svg.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-h-cards',
  standalone: true,
  templateUrl: './h-cards.component.html',
  styleUrl: './h-cards.component.scss',
  imports: [SvgComponent, CommonModule],
})
export class HCardsComponent {
  @Input() icon!: string;
  @Input() record!: string;
  @Input() label!: string;
}
