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

  constructor(private _order: OrdersService) {}

  ngOnInit(): void {
    this.fetchAllOrders();
  }

  mappedOrders: OrderTableData[] = [];

  fetchAllOrders() {
    this._order.getAllOrders(0, 10).subscribe((res: ApiResponse) => {
      console.log(res.data.content[0]);
      if (res.status === 200) {
        this.mappedOrders = res.data.content.map((order) => ({
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
      } else {
        // Handle error
        console.log('Failed to fetch orders with status: ' + res.status);
      }
    });
  }

  filteredOrders: OrderTableData[] = [];

  filterOrders() {
    this.filteredOrders = this.mappedOrders.filter(
      (order) => order.Status.toLowerCase() === this.activeTab.toLowerCase()
    );
  }

  // ngOnChanges(changes: SimpleChanges): void {
  //   console.log('Changes: ', changes['activeTab'].currentValue);
  //   if (changes['activeTab'] && changes['activeTab'].currentValue) {
  //     this.activeTab = changes['activeTab'].currentValue;
  //     this.filterOrders();
  //   }
  // }
  // setActiveTab(status: string) {
  //   console.log('Active tab: ', status);
  //   this.activeTab = status;
  //   this.filterOrders();
  // }

  // ordersData: IOrder[] = [
  //   {
  //     id: 1,
  //     orderName: 'camera',
  //     countOfOrders: 1,
  //     breakable: true,
  //     expiryDate: '1-2 Days',
  //     expectedPrice: 100.0,
  //     orderPhotoUrl: 'https://picsum.photos/id/9/200',
  //     from: 'This is FROM test',
  //     to: 'This is TO test',
  //     senderPhoneNumber: '+201554111002',
  //     receiverPhoneNumber: '01054888469',
  //     orderStatus: 'Active',
  //   },
  //   {
  //     id: 2,
  //     orderName: 'laptop',
  //     countOfOrders: 1,
  //     breakable: false,
  //     expiryDate: '3-4 Days',
  //     expectedPrice: 1200.0,
  //     orderPhotoUrl: 'https://picsum.photos/id/0/200',
  //     from: 'This is FROM test 2',
  //     to: 'This is TO test 2',
  //     senderPhoneNumber: '+201554111003',
  //     receiverPhoneNumber: '01054888470',
  //     orderStatus: 'Canceled',
  //   },
  //   {
  //     id: 3,
  //     orderName: 'phone',
  //     countOfOrders: 2,
  //     breakable: false,
  //     expiryDate: '1-2 Days',
  //     expectedPrice: 800.0,
  //     orderPhotoUrl: 'https://picsum.photos/id/16/200',
  //     from: 'This is FROM test 3',
  //     to: 'This is TO test 3',
  //     senderPhoneNumber: '+201554111004',
  //     receiverPhoneNumber: '01054888471',
  //     orderStatus: 'Pending',
  //   },
  //   {
  //     id: 4,
  //     orderName: 'headphones',
  //     countOfOrders: 1,
  //     breakable: true,
  //     expiryDate: '2-3 Days',
  //     expectedPrice: 150.0,
  //     orderPhotoUrl: 'https://picsum.photos/id/18/200',
  //     from: 'This is FROM test 4',
  //     to: 'This is TO test 4',
  //     senderPhoneNumber: '+201554111005',
  //     receiverPhoneNumber: '01054888472',
  //     orderStatus: 'Pending',
  //   },
  // ];
}
