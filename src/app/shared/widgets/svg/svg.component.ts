import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { Observable, Subscription, map } from 'rxjs';
import { SvgIconService } from '../../../core/services/svg-icon.service';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-svg',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './svg.component.html',
  styleUrl: './svg.component.scss',
})
export class SvgComponent implements OnInit, OnDestroy {
  @Input() public name!: string;
  @Input() public class!: string;
  public svgIcon!: Observable<SafeHtml>;
  private svgSubscription!: Subscription;

  constructor(private _sanitizer: DomSanitizer, private _svg: SvgIconService) {}

  ngOnInit(): void {
    this.svgIcon = this._svg
      .getSvg(this.name)
      .pipe(map((value) => this._sanitizer.bypassSecurityTrustHtml(value)));
    this.svgSubscription = this.svgIcon.subscribe();
  }

  ngOnDestroy(): void {
    this.svgSubscription?.unsubscribe();
  }
}
