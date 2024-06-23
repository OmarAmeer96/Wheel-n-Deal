import { CommonModule } from '@angular/common';
import {
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
import { SvgComponent } from '../svg/svg.component';
import jsPDF from 'jspdf';
import autoTable, { RowInput } from 'jspdf-autotable';

@Component({
  selector: 'app-table',
  standalone: true,
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.scss'],
  imports: [CommonModule, SvgComponent],
})
export class TableComponent<T> implements OnInit, OnChanges {
  @Input() headings!: string[];
  @Input() activeTab!: string;
  @Input() tableData!: T[];
  @Input() dataType!: 'order' | 'user';

  orderTableData: OrderTableData[] = [];
  userTableData: UserTableData[] = [];

  ngOnInit(): void {
    this.processTableData();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['tableData'] || changes['dataType'] || changes['activeTab']) {
      this.processTableData();
    }
  }

  processTableData(): void {
    if (this.dataType === 'order') {
      this.orderTableData = (this.tableData as OrderTableData[]).filter(
        (row) =>
          this.activeTab.toLowerCase() === 'all' ||
          row.Status.toLowerCase().trim() ===
            this.activeTab.toLowerCase().trim()
      );
      console.log('orderTableData', this.orderTableData);

      this.userTableData = [];
    } else if (this.dataType === 'user') {
      this.userTableData = this.tableData as UserTableData[];
      this.orderTableData = [];
    }
  }

  // Type Guard for OrderTableData
  isOrderTableData(data: any): data is OrderTableData[] {
    return (
      Array.isArray(data) && data.length > 0 && 'orderSpecificProp' in data[0]
    );
  }

  // Type Guard for UserTableData
  isUserTableData(data: any): data is UserTableData[] {
    return (
      Array.isArray(data) && data.length > 0 && 'userSpecificProp' in data[0]
    );
  }

  // Modified processTableData method using type guards
  processTableData1(): void {
    if (this.isOrderTableData(this.tableData)) {
      // Now TypeScript knows this.tableData is OrderTableData[]
      this.orderTableData = (this.tableData as OrderTableData[]).filter(
        (row) =>
          this.activeTab.toLowerCase() === 'all' ||
          row.Status.toLowerCase().trim() ===
            this.activeTab.toLowerCase().trim()
      );
      this.userTableData = [];
    } else if (this.isUserTableData(this.tableData)) {
      // Now TypeScript knows this.tableData is UserTableData[]
      this.userTableData = this.tableData;
      this.orderTableData = [];
    }
  }

  //  CSV
  exportToCSV(): void {
    // Determine which data to export based on dataType
    const dataToExport =
      this.dataType === 'order' ? this.orderTableData : this.userTableData;

    // Convert data to CSV format
    let csvContent = 'data:text/csv;charset=utf-8,';
    csvContent += this.generateCSVHeaders(dataToExport);
    dataToExport.forEach((row) => {
      csvContent += this.generateCSVRow(row) + '\n';
    });

    // Trigger download
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement('a');
    link.setAttribute('href', encodedUri);
    link.setAttribute('download', 'export.csv');
    document.body.appendChild(link); // Required for FF

    link.click(); // This will download the data file named "export.csv".
  }

  generateCSVHeaders(data: any[]): string {
    // Generate CSV headers based on the object keys of the first item
    // This is a simple implementation; adjust according to your data structure
    return Object.keys(data[0]).join(',') + '\n';
  }

  generateCSVRow(row: any): string {
    // Convert an object to a CSV row string
    // This is a simple implementation; adjust according to your data structure
    return Object.values(row).join(',');
  }
}

/**
 *  exportToPDF1(): void {
    // Determine which data to export based on dataType
    const dataToExport =
      this.dataType === 'order' ? this.orderTableData : this.userTableData;

    // Initialize jsPDF
    const doc = new jsPDF();

    const options = {
      margin: { top: 20 },
      styles: { fillColor: [255, 0, 0] }, // Example: Red fill color for cells
      columnStyles: { 0: { cellWidth: 'auto' } }, // Example: Auto width for the first column
      didDrawPage: () => {
        // Add a header
        doc.text('Header', 10, 10);
      },
    };

    // Define the columns for autoTable
    const columns = Object.keys(dataToExport[0]).map((key) => ({
      title: key,
      dataKey: key,
    }));

    // Use autoTable to add the table to the document
    autoTable(doc, {
      columns: columns,
      body: dataToExport as any[],
      margin: { top: 20 },
      styles: {
        fillColor: [255, 0, 0],
        fontSize: 10,
        cellPadding: 5,
        lineWidth: 0.5,
        lineColor: [0, 0, 0],
      }, // Example: Red fill color for cells
      columnStyles: { 0: { cellWidth: 'wrap' } }, // Example: Auto width for the first column

      didDrawPage: () => {
        // Add a header
        doc.text('Header', 10, 10);
      },
    });

    // Save the PDF
    doc.save('export.pdf');
  }
 *
 */

// exportToPDF(): void {
//   // Determine which data to export based on dataType
//   const dataToExport =
//     this.dataType === 'order' ? this.orderTableData : this.userTableData;

//   // Initialize jsPDF
//   const doc = new jsPDF();

//   // Define the columns for autoTable
//   const columns = Object.keys(dataToExport[0]).map((key) => ({
//     header: key.charAt(0).toUpperCase() + key.slice(1),
//     dataKey: key,
//   }));

//   const transformedColumns = columns.map((col) => [col.header]);
//   // Use autoTable to add the table to the document
//   autoTable(doc, {
//     head: [transformedColumns.map((col) => col[0])],
//     body: dataToExport.map(
//       (row) => columns.map((col) => row[col.dataKey as keyof typeof row]) // Assert that col.dataKey is a key of row
//     ),
//     margin: { top: 20, left: 10, right: 10, bottom: 10 },
//     styles: {
//       fillColor: [255, 255, 255],
//       textColor: [0, 0, 0],
//       fontSize: 10,
//       cellPadding: 10,
//       lineWidth: 0.5,
//       lineColor: [0, 0, 0],
//     },
//     columnStyles: {
//       all: { cellWidth: 'wrap', fillColor: [255, 0, 0] }, // Auto width for the first column, with gray background
//     },
//     didDrawPage: (data) => {
//       // Add a header
//       doc.setFontSize(5);
//       doc.setTextColor(10);
//       doc.text(`My ${this.activeTab} Report`, data.settings.margin.left, 10);
//     },
//     willDrawCell: (data) => {
//       // Add custom styles for specific cells if needed
//       if (data.section === 'body' && data.column.dataKey === 'Status') {
//         data.cell.styles.textColor =
//           data.cell.raw === 'Pending' ? [255, 0, 0] : [0, 255, 0];
//       }
//     },
//     // Add autoSize configuration for columns
//   });

//   // Save the PDF
//   doc.save('export.pdf');
// }
