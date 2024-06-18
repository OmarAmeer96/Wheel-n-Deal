import { Component } from '@angular/core';
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { CommonModule } from '@angular/common';
import { ToggleBarComponent } from '../../shared/widgets/toggle-bar/toggle-bar.component';
import { ToggleStaticsData } from '../../core/constant/toggle-data';
import { TableComponent } from '../../shared/widgets/table/table.component';
import { IOrder } from '../../core/models/interfaces/order';

@Component({
  selector: 'app-orders',
  standalone: true,
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.scss',
  imports: [HCardsComponent, CommonModule, ToggleBarComponent, TableComponent],
})
export class OrdersComponent {
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

  ordersData: IOrder[] = [
    {
      id: 1,
      orderName: 'camera',
      countOfOrders: 1,
      breakable: true,
      expiryDate: '1-2 Days',
      expectedPrice: 100.0,
      orderPhotoUrl:
        'https://res.cloudinary.com/dzwidv5zn/image/upload/v1718456145/kqupogytjk0dfocik6t8.jpg',
      from: 'This is FROM test',
      to: 'This is TO test',
      senderPhoneNumber: '+201554111002',
      receiverPhoneNumber: '01054888469',
      orderStatus: 'Active',
    },
    {
      id: 2,
      orderName: 'laptop',
      countOfOrders: 1,
      breakable: false,
      expiryDate: '3-4 Days',
      expectedPrice: 1200.0,
      orderPhotoUrl: 'https://picsum.photos/id/0/200',
      from: 'This is FROM test 2',
      to: 'This is TO test 2',
      senderPhoneNumber: '+201554111003',
      receiverPhoneNumber: '01054888470',
      orderStatus: 'Canceled',
    },
    {
      id: 3,
      orderName: 'phone',
      countOfOrders: 2,
      breakable: false,
      expiryDate: '1-2 Days',
      expectedPrice: 800.0,
      orderPhotoUrl: 'https://picsum.photos/id/16/200',
      from: 'This is FROM test 3',
      to: 'This is TO test 3',
      senderPhoneNumber: '+201554111004',
      receiverPhoneNumber: '01054888471',
      orderStatus: 'Pending',
    },
    {
      id: 4,
      orderName: 'headphones',
      countOfOrders: 1,
      breakable: true,
      expiryDate: '2-3 Days',
      expectedPrice: 150.0,
      orderPhotoUrl: 'https://picsum.photos/id/18/200',
      from: 'This is FROM test 4',
      to: 'This is TO test 4',
      senderPhoneNumber: '+201554111005',
      receiverPhoneNumber: '01054888472',
      orderStatus: 'Pending',
    },
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

  mappedOrders = this.ordersData.map((order) => ({
    ID: order.id,
    Status: order.orderStatus,
    'Customer ID': order.senderPhoneNumber, // Replace with actual property name
    'Commuter ID': order.receiverPhoneNumber, // Replace with actual property name
    From: order.from,
    To: order.to,
    'Order Name': order.orderName,
    'Expiry Data': order.expiryDate,
    Price: order.expectedPrice,
    Amount: order.countOfOrders, // Replace with actual property name
    Breakable: order.breakable,
    Picture: order.orderPhotoUrl,
  }));
}
