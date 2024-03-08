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

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [SvgComponent, ReactiveFormsModule, FormsModule, CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss',
})
export class LoginComponent {
  isLoading = false;
  inSubmission = false;
  // showAlert = false;
  // alertMsg = 'Please wait! We are logging you in';
  // alertColor = 'orange';

  userName = new FormControl('', [Validators.required]);
  password = new FormControl('', [
    Validators.required,
    Validators.minLength(4),
  ]);

  loginForm = new FormGroup({
    userName: this.userName,
    password: this.password,
  });

  constructor(private _auth: AuthService) {}
  login() {
    // this.isLoading = true;

    this._auth.logIn(this.loginForm.value as IAdmin);
  }
}
