import { Component } from '@angular/core';
import { OrdersService } from '../../core/services/orders.service';
import { OrderTableData, UserTableData } from '../../core/constant/table-data';
import { ApiResponse } from '../../core/models/interfaces/order';
import { ToggleStaticsData } from '../../core/constant/toggle-data';
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { ToggleBarComponent } from '../../shared/widgets/toggle-bar/toggle-bar.component';
import { SvgComponent } from '../../shared/widgets/svg/svg.component';
import { TableComponent } from '../../shared/widgets/table/table.component';
import { UsersService } from '../../core/services/users.service';
import { UserResponse } from '../../core/models/interfaces/users';

@Component({
  selector: 'app-users',
  standalone: true,
  templateUrl: './users.component.html',
  styleUrl: './users.component.scss',
  imports: [HCardsComponent, ToggleBarComponent, SvgComponent, TableComponent],
})
export class UsersComponent {
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
    'Username',
    'Phone',
    'National ID',
    'Gender',
    'Picture',
    'Total Orders',
    'Canceled Orders',
    'Wallet',
  ];

  constructor(private _user: UsersService) {}

  ngOnInit(): void {
    console.log('Starting');

    this.fetchAllUsers();
  }

  mappedUsers: UserTableData[] = [];

  fetchAllUsers() {
    debugger;
    console.log('from fetch');

    this._user.getAllUsers(0, 10).subscribe((res: UserResponse) => {
      console.log(res.data.content[0]);
      if (res.status === 200) {
        console.log('Users data: ', this.mappedUsers);
      } else {
        // Handle error
        console.log('Failed to fetch users with status: ' + res.status);
      }
    });
  }

  filteredOrders: OrderTableData[] = [];

  // filterOrders() {
  //   this.filteredOrders = this.mappedOrders.filter(
  //     (order) => order.Status.toLowerCase() === this.activeTab.toLowerCase()
  //   );
  // }
}
