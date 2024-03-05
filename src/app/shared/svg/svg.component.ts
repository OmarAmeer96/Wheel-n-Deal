import {
  Component,
  Input,
  OnChanges,
  SecurityContext,
  SimpleChanges,
} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
@Component({
  selector: 'app-svg',
  standalone: true,
  imports: [],
  template: `<span [class]="class" [innerHTML]="svgIcon"></span>`,
  // templateUrl: './svg.component.html',
  styleUrl: './svg.component.scss',
})
export class SvgComponent implements OnChanges {
  @Input() public name!: string;
  @Input() public class!: string;
  public svgIcon!: any;

  constructor(private _http: HttpClient, private _sanitizer: DomSanitizer) {}
  ngOnChanges(changes: SimpleChanges): void {
    this._http
      .get(`assets/SVGs/${this.name}.svg`, { responseType: 'text' })
      .subscribe({
        next: (value) => {
          this.svgIcon = this._sanitizer.bypassSecurityTrustHtml(value);
        },
        error(err) {
          console.error(err);
        },
      });
  }
}
