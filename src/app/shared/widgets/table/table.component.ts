import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { IOrder } from '../../../core/models/interfaces/order';
import { OrderTableData } from '../../../core/constant/table-data';

@Component({
  selector: 'app-table',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './table.component.html',
  styleUrl: './table.component.scss',
})
export class TableComponent {
  @Input() headings: string[] = [];
  @Input() tableData: OrderTableData[] = [];
  @Input() activeTab: string = 'all';
}
