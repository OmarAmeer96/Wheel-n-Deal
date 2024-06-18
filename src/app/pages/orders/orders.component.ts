import { Component } from '@angular/core';
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-orders',
  standalone: true,
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.scss',
  imports: [HCardsComponent, CommonModule],
})
export class OrdersComponent {
  cards = [
    { record: '849', label: 'Total orders' },
    { record: '123', label: 'Pending orders' },
    // ...
  ];
}
