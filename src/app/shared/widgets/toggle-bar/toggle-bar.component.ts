import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ToggleDataModel } from '../../../core/constant/toggle-data';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-toggle-bar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './toggle-bar.component.html',
  styleUrl: './toggle-bar.component.scss',
})
export class ToggleBarComponent {
  @Input() toggleData: ToggleDataModel[] = [];
  @Input() currentActiveBtn?: string;

  @Output() setActive$ = new EventEmitter<string>();

  ngOnInit(): void {
    // frist item will be active by default
    if (!this.currentActiveBtn && this.toggleData?.length)
      this.currentActiveBtn = this.toggleData[0].status;
  }

  setActiveBtn(status: string) {
    this.currentActiveBtn = status;
    this.setActive$.emit(status);
  }
}
