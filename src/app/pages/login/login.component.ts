import { Component } from '@angular/core';
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
export class LoginComponent {
  isLoading = false;
  inSubmission = false;

  username = new FormControl('', [Validators.required]);
  password = new FormControl('', [
    Validators.required,
    Validators.minLength(4),
  ]);

  loginForm = new FormGroup({
    username: this.username,
    password: this.password,
  });

  constructor(private _auth: AuthService, private router: Router) {}

  login() {
    this.isLoading = true;

    // Call the login method from the AuthService
    this._auth
      .logIn(this.loginForm.value as IAdmin)
      .subscribe((res: AdminResponse) => {
        if (res.status === 200) {
          localStorage.setItem('token', res.data.token);
          this.router.navigate(['admin/dashboard']);
        } else {
          // Handle error
          console.log('Authentication failed with status: ' + res.status);
        }
      });
  }
}
