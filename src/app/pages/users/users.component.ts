// Angular Core Imports
import { Component, OnChanges, OnDestroy, OnInit } from '@angular/core';

// Models and Services
import { IUser, UserResponse } from '../../core/models/interfaces/users';
import { UsersService } from '../../core/services/users.service';
import { UserTableData } from '../../core/constant/table-data';
import { ToggleUserData } from '../../core/constant/toggle-data';

// Shared Components
import { HCardsComponent } from '../../shared/widgets/h-cards/h-cards.component';
import { ToggleBarComponent } from '../../shared/widgets/toggle-bar/toggle-bar.component';
import { SvgComponent } from '../../shared/widgets/svg/svg.component';
import { TableComponent } from '../../shared/widgets/table/table.component';
import { StatService } from '../../core/services/stat.service';
import { DataModel, ICard } from '../../core/models/interfaces/statistical';
import { CommonModule } from '@angular/common';
import { Subscription } from 'rxjs';

/**```Component responsible for displaying user-related information,
 * including a toggle bar, cards for summary, and a table for detailed view.```
 */
@Component({
  selector: 'app-users',
  standalone: true,
  templateUrl: './users.component.html',
  styleUrl: './users.component.scss',
  imports: [
    HCardsComponent,
    ToggleBarComponent,
    SvgComponent,
    TableComponent,
    CommonModule,
  ],
})
export class UsersComponent implements OnInit, OnDestroy {
  // UI related properties
  toggleData = ToggleUserData;
  activeTab = ToggleUserData[0].status;
  cards: ICard[] = [
    { record: 849, label: 'Total Users' },
    { record: 135, label: 'Total Customers' },
    { record: 210, label: 'Total Commuter' },

    // ..
  ];

  userStat: Partial<DataModel> = {
    numOfAllUsers: 0,
    numOfCustomers: 0,
    numOfCommuters: 0,
  };

  tableHeaders = [
    'ID',
    'Username',
    'Rile',
    'Phone',
    'National ID',
    'Gender',
    'Picture',
    'Total Orders',
    'Canceled Orders',
    'Wallet',
  ];

  // Data models
  mappedUsers: UserTableData[] = [];
  filteredUsers: UserTableData[] = [];

  private statDataSub!: Subscription;

  constructor(private _user: UsersService, private _stat: StatService) {}

  /** Useage
   * Fetches all users on component initialization.
   */
  ngOnInit(): void {
    this.fetchCardData();
    this.fetchAllUsers();
    this.listenToStatDataSub();
  }

  fetchCardData() {
    this.userStat = this._stat.getStatVar(
      'numOfAllUsers',
      'numOfCustomers',
      'numOfCommuters'
    ) as Partial<DataModel>;

    this.cards = this.cards.map((card, index) => {
      const key = Object.keys(this.userStat)[index] as keyof Partial<DataModel>;
      card.record = this.userStat[key] ?? 0;
      return card;
    });
  }

  /** Useage
   * Fetches all users from the server and maps them to the UserTableData model.
   */
  fetchAllUsers() {
    this._user.getAllUsers(0, 50).subscribe((res: UserResponse) => {
      console.log(res);
      if (res.status === 200) {
        this.mappedUsers = res.data.content.map((user: IUser) => ({
          id: user.id,
          username: user.username,
          role: user.role,
          phone: user.phoneNumber,
          nationalId: user.nationalId ?? 'N/A',
          gender: user.gender ?? 'N/A',
          picture: user.profilePictureUrl,
          totalOrders: user.totalDelivers,
          canceledOrders: user.cancelDelivers,
          wallet: user.amount,
        }));
        console.log('Users data: ', this.mappedUsers);
      } else {
        // Handle error
        console.log('Failed to fetch users with status: ' + res.status);
      }
    });
  }

  /**
   * Filters orders based on the active tab. ```=>```
   * TODO: Change the UserTableData model to include a 'Status' property for filtering.
   */
  filterUsers() {
    console.log('Filtering users with status: ', this.activeTab);

    this.filteredUsers = this.mappedUsers.filter(
      (user) => user.role.toLowerCase() === this.activeTab.toLowerCase()
    );
  }

  listenToStatDataSub() {
    this.statDataSub = this._stat.statisticalData.subscribe({
      next: (data: DataModel) => {
        this.userStat = data;
        console.log('from listenToStatDataSub: ', this.userStat);
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
