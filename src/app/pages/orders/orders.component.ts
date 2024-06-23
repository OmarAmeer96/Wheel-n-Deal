// Angular Core
import { Component, OnDestroy, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

// Constants & Models/Interfaces
import { ApiResponse, IOrder } from '../../core/models/interfaces/order';
import { OrderTableData } from '../../core/constant/table-data';
import { ToggleStaticsData } from '../../core/constant/toggle-data';

// Services
import { OrdersService } from '../../core/services/orders.service';
import { StatService } from '../../core/services/stat.service';

// Widgets/Components
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { SvgComponent } from '../../shared/widgets/svg/svg.component';
import { TableComponent } from '../../shared/widgets/table/table.component';
import { ToggleBarComponent } from '../../shared/widgets/toggle-bar/toggle-bar.component';
import { DataModel, ICard } from '../../core/models/interfaces/statistical';
import { Observable, Subscription, map } from 'rxjs';

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
export class OrdersComponent implements OnInit, OnDestroy {
  private statDataSub!: Subscription;
  // Data properties
  toggleData = ToggleStaticsData;
  activeTab = ToggleStaticsData[0].status;

  orderStat: Partial<DataModel> = {
    numOfAllOrders: 0,
    numOfPendingOrders: 0,
    numOfInProgressOrders: 0,
    numOfInSuccessOrders: 0,
    numOfFailedOrders: 0,
  };

  cards: ICard[] = [
    { record: 0, label: 'Total orders' },
    {
      record: 0,
      label: 'Pending orders',
    },
    {
      record: 0,
      label: 'In-Progress Orders',
    },
    {
      record: 0,
      label: 'Successful Orders',
    },
    {
      record: 0,
      label: 'Failed Orders',
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

  // Data lists
  mappedOrders: OrderTableData[] = [];
  filteredOrders: OrderTableData[] = [];

  constructor(private _order: OrdersService, private _stat: StatService) {}

  ngOnInit(): void {
    this.fetchCardData();
    this.fetchAllOrders();
    this.listenToStatDataSub();
  }

  private fetchCardData(): void {
    this.orderStat = this._stat.getStatVar(
      'numOfAllOrders',
      'numOfPendingOrders',
      'numOfInProgressOrders',
      'numOfInSuccessOrders',
      'numOfFailedOrders'
    ) as Partial<DataModel>;

    this.cards = this.cards.map((card, index) => {
      const key = Object.keys(this.orderStat)[
        index
      ] as keyof Partial<DataModel>;
      card.record = this.orderStat[key] ?? 0;
      return card;
    });
  }

  filterOrders() {
    console.log('Filtering orders with status: ', this.activeTab);

    this.filteredOrders = this.mappedOrders.filter(
      (order) => order.Status.toLowerCase() === this.activeTab.toLowerCase()
    );
  }

  private fetchAllOrders(): void {
    this._order.getAllOrders(0, 30).subscribe({
      next: (res: ApiResponse) => {
        if (res.status === 200) {
          this.mapOrders(res.data.content);
          console.log('Orders fetched successfully: ', this.mappedOrders[8]);
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
  }

  listenToStatDataSub() {
    this.statDataSub = this._stat.statisticalData.subscribe({
      next: (data: DataModel) => {
        this.orderStat = data;
        console.log('from listenToStatDataSub: ', this.orderStat);
        this.fetchCardData();
      },
      error: (err) => console.error('Error fetching stat data: ', err),
    });
  }

  ngOnDestroy(): void {
    if (this.statDataSub) {
      this.statDataSub.unsubscribe();
    }
  }
}
