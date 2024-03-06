import {
  Component,
  Input,
  OnChanges,
  OnDestroy,
  OnInit,
  SimpleChanges,
} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { Observable } from 'rxjs';
@Component({
  selector: 'app-svg',
  standalone: true,
  imports: [],
  template: `<span [class]="class" [innerHTML]="svgIcon"></span>`,
  // templateUrl: './svg.component.html',
  styleUrl: './svg.component.scss',
})
export class SvgComponent implements OnInit, OnDestroy {
  @Input() public name!: string;
  @Input() public class!: string;
  public svgIcon!: SafeHtml;

  constructor(private _http: HttpClient, private _sanitizer: DomSanitizer) {}

  ngOnInit(): void {
    const assets: Observable<string> = this._http.get(
      `assets/SVGs/${this.name}.svg`,
      {
        responseType: 'text',
      }
    );

    assets.subscribe({
      next: (value) => {
        this.svgIcon = this._sanitizer.bypassSecurityTrustHtml(value);
      },
      error(err) {
        console.error(err);
      },
    });
  }
  ngOnDestroy(): void {}
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
