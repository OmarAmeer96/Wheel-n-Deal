import { Component } from '@angular/core';
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';

@Component({
  selector: 'app-orders',
  standalone: true,
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.scss',
  imports: [HCardsComponent],
})
export class OrdersComponent {}
