import { Component, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { CommonModule } from '@angular/common';
import { ToggleBarComponent } from '../../shared/widgets/toggle-bar/toggle-bar.component';
import { ToggleStaticsData } from '../../core/constant/toggle-data';
import { TableComponent } from '../../shared/widgets/table/table.component';
import { ApiResponse, IOrder } from '../../core/models/interfaces/order';
import { SvgComponent } from '../../shared/widgets/svg/svg.component';
import { OrdersService } from '../../core/services/orders.service';
import { OrderTableData } from '../../core/constant/table-data';

@Component({
  selector: 'app-orders',
  standalone: true,
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.scss',
  imports: [
    HCardsComponent,
    CommonModule,
    ToggleBarComponent,
    TableComponent,
    SvgComponent,
  ],
})
export class OrdersComponent implements OnInit {
  toggleData = ToggleStaticsData;
  activeTab = ToggleStaticsData[0].status;
  cards = [
    { record: '849', label: 'Total orders' },
    { record: '135', label: 'Pending orders' },
    { record: '210', label: 'Active orders' },
    { record: '301', label: 'In-Progress Orders' },
    { record: '210', label: 'Canceled Orders' },
    // ..
  ];
  tableHeaders = [
    'ID',
    'Status',
    'Customer ID',
    'Commuter ID',
    'From',
    'To',
    'Order Name',
    'Expiry Data',
    'Price',
    'Amount',
    'Breakable',
    'Picture',
  ];

  mappedOrders: OrderTableData[] = [];
  filteredOrders: OrderTableData[] = [];

  constructor(private _order: OrdersService) {}

  ngOnInit(): void {
    this.fetchAllOrders();
  }

  private fetchAllOrders(): void {
    this._order.getAllOrders(0, 10).subscribe({
      next: (res: ApiResponse) => {
        if (res.status === 200) {
          this.mapOrders(res.data.content);
        } else {
          console.error('Failed to fetch orders with status: ', res.status);
        }
      },
      error: (err) => console.error('Error fetching orders: ', err),
    });
  }

  private mapOrders(orders: IOrder[]): void {
    this.mappedOrders = orders.map((order) => ({
      ID: order.id,
      Status: order.orderStatus,
      'Customer ID': order.senderPhoneNumber,
      'Commuter ID': order.commuterPhoneNumber ?? 'N/A',
      From: order.from,
      To: order.to,
      'Order Name': order.orderName,
      'Expiry Data': order.expiryDate,
      Price: order.expectedPrice,
      Amount: order.countOfOrders,
      Breakable: order.breakable,
      Picture: order.orderPhotoUrl,
    }));
    console.log('Orders data: ', this.mappedOrders);
  }

  filterOrders() {
    this.filteredOrders = this.mappedOrders.filter(
      (order) => order.Status.toLowerCase() === this.activeTab.toLowerCase()
    );
  }
}
