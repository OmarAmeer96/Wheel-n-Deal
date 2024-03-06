import {
  Component,
  Input,
  OnChanges,
  OnDestroy,
  OnInit,
  SimpleChanges,
} from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { Observable, Subscription, map } from 'rxjs';
import { SvgIconService } from '../../core/services/svg-icon.service';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-svg',
  standalone: true,
  imports: [CommonModule],
  template: `<span [class]="class" [innerHTML]="svgIcon | async"></span>`,
  // templateUrl: './svg.component.html',
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
    // Initialize the subscription in ngOnInit
    this.svgSubscription = this.svgIcon.subscribe();
  }

  ngOnDestroy(): void {
    // Unsubscribe from the subscription
    this.svgSubscription?.unsubscribe();
  }

  // ngOnInit(): void {
  //   const assets: Observable<string> = this._http.get(
  //     `assets/SVGs/${this.name}.svg`,
  //     {
  //       responseType: 'text',
  //     }
  //   );

  //   this._svg.getSvg(this.name).subscribe({
  //     next: (value) => {
  //       this.svgIcon = this._sanitizer.bypassSecurityTrustHtml(value);
  //     },
  //     error(err) {
  //       console.error(err);
  //     },
  //   });
  // }

  // ngOnChanges(changes: SimpleChanges): void {
  //   this._http
  //     .get(`assets/SVGs/${this.name}.svg`, { responseType: 'text' })
  //     .subscribe({
  //       next: (value) => {
  //         this.svgIcon = this._sanitizer.bypassSecurityTrustHtml(value);
  //       },
  //       error(err) {
  //         console.error(err);
  //       },
  //     });
  // }
}
