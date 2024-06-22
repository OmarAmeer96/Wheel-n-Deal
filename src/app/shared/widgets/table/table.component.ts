import { CommonModule } from '@angular/common';
import {
  AfterContentInit,
  AfterViewInit,
  Component,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
} from '@angular/core';
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
export class TableComponent implements OnInit, OnChanges {
  @Input() headings!: any[];
  @Input() activeTab!: string;
  @Input() tableData!: OrderTableData[];

  ngOnInit(): void {
    console.log('Table Data on init:', this.tableData);
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['tableData']) {
      console.log('Table Data on changes:', this.tableData);
      // Additional logic here if needed
    }
  }
}
