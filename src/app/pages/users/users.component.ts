// Angular Core Imports
import { Component } from '@angular/core';

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

/**```Component responsible for displaying user-related information,
 * including a toggle bar, cards for summary, and a table for detailed view.```
 */
@Component({
  selector: 'app-users',
  standalone: true,
  templateUrl: './users.component.html',
  styleUrl: './users.component.scss',
  imports: [HCardsComponent, ToggleBarComponent, SvgComponent, TableComponent],
})
export class UsersComponent {
  // UI related properties
  toggleData = ToggleUserData;
  activeTab = ToggleUserData[0].status;
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

  // Data models
  mappedUsers: UserTableData[] = [];
  filteredOrders: UserTableData[] = [];

  constructor(private _user: UsersService) {}

  /** Useage
   * Fetches all users on component initialization.
   */
  ngOnInit(): void {
    this.fetchAllUsers();
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
  filterOrders() {}
}
