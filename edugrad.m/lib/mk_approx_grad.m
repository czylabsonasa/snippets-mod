function df = mk_approx_grad(f, nvar, opts)
  arguments
    f function_handle
    nvar  int16
    opts struct
  end

  I = eye(nvar);
  maxit = opts.maxit;
  tol = opts.tol;

  function y=dq(x,h)
    y=zeros(nvar, 1);
    for j=1:nvar
      y(j) = f(x+h*I(:,j))-f(x-h*I(:,j));
    end
    y = y / (2*h);
  end

  
  function y = loc_df(x)
    dqx = @(h) dq(x,h);
    h=2^(-7); % ad-hoc choice
    y = dqx(h);
    for it = 1:maxit
      y0 = y;
      h = h/2;
      y = dqx(h);
      if norm(y-y0,inf)<tol*norm(y,inf), break; end
    end
  end
  
  df = @loc_df;
end
