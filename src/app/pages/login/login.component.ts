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
import { IAdmin } from '../../core/models/interfaces/admin';
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

  userName = new FormControl('', [Validators.required]);
  password = new FormControl('', [
    Validators.required,
    Validators.minLength(4),
  ]);

  loginForm = new FormGroup({
    userName: this.userName,
    password: this.password,
  });

  constructor(private _auth: AuthService, private router: Router) {}

  login() {
    this.isLoading = true;
    // this._auth.logIn(this.loginForm.value as IAdmin).subscribe(
    //   () => {
    //     // Navigate to admin page
    //     // Replace 'admin' with the actual route path for the admin page
    //     this.router.navigate(['admin/dashboard']);
    //   },
    //   (error) => {
    //     // Handle login error
    //     console.error(error);
    //   }
    // );

    this._auth.logIn(this.loginForm.value as IAdmin).subscribe((res: any) => {
      if (res.status === 200) {
        // Authentication was successful
        console.log(res.message); // "Authentication successful."
        console.log(res.data.role); // "ADMIN"
        console.log(res.data.userId); // 1
        console.log(res.data.token); // The token
        console.log(res.data.refreshToken); // The refresh token

        // You can now store the tokens and the user's role and ID in your application,
        // for example in a service or in local storage, and use them for subsequent API calls.
      } else {
        // Handle error
        console.log('Authentication failed with status: ' + res.status);
      }
    });

    this.router.navigate(['admin/dashboard']);
  }
}
