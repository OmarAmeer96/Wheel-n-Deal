import { Component, OnInit, SimpleChange, SimpleChanges } from '@angular/core';
import { SvgComponent } from '../../shared/widgets/svg/svg.component';
import {
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';
import { AdminResponse, IAdmin } from '../../core/models/interfaces/admin';
import { RouterModule } from '@angular/router';
import { Router } from '@angular/router';
import { StatService } from '../../core/services/stat.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    SvgComponent,
    ReactiveFormsModule,
    FormsModule,
    CommonModule,
    RouterModule,
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss',
})
export class LoginComponent implements OnInit {
  isLoading = false;
  inSubmission = false;
  isAuth = false;

  username = new FormControl('', [Validators.required]);
  password = new FormControl('', [
    Validators.required,
    Validators.minLength(4),
  ]);

  loginForm = new FormGroup({
    username: this.username,
    password: this.password,
  });

  constructor(
    private _auth: AuthService,
    private router: Router,
    private _stat: StatService
  ) {}
  ngOnInit(): void {
    if (this.isAuth) {
      this.fetchStatData();
    }
  }
  ngOnChanges(changes: SimpleChanges) {
    if (changes['isAuth'] && this.isAuth) {
      this.fetchStatData();
    }
  }

  public login() {
    this.isLoading = true;
    this._auth.logIn(this.loginForm.value as IAdmin).subscribe({
      next: (res) => {
        localStorage.setItem('token', res.data.token);
        this.isAuth = true;
      },
      error: (error) => {
        console.error('Error logging in:', error);
      },
      complete: () => {
        this.router.navigate(['admin/dashboard']);
        this.isLoading = false;
      },
    });
  }
  fetchStatData() {
    this._stat.getStatisticalData().subscribe({
      next: (res) => {
        console.log('after login', res.data);
      },
    });
  }
}
