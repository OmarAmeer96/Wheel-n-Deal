import { HttpInterceptorFn } from '@angular/common/http';

export const tokenInterceptor: HttpInterceptorFn = (req, next) => {
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
