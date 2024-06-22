import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import {
  OrderTableData,
  UserTableData,
} from '../../../core/constant/table-data';

@Component({
  selector: 'app-table',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.scss'],
})
export class TableComponent {
  @Input() headings: string[] = [];
  @Input() tableData: OrderTableData[] = [];
  @Input() activeTab: string = 'all';
}
