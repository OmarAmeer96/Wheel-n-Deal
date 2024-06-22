import { HttpInterceptorFn } from '@angular/common/http';

export const tokenInterceptor: HttpInterceptorFn = (req, next) => {
  debugger;
  let WND_token = '';
  if (typeof localStorage !== 'undefined') {
    WND_token = localStorage.getItem('token') || '';
  }

  const cloneRequest = req.clone({
    setHeaders: {
      Authorization: `Bearer ${WND_token}`,
    },
  });

  return next(cloneRequest);
};
