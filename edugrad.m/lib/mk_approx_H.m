function H = mk_approx_H(f, nvar, opts)
  arguments
    f function_handle
    nvar  int16
    opts struct
  end

  I = eye(nvar);
  maxit = opts.maxit;
  tol = opts.tol;

  function y=dq(x,h)
    y=zeros(nvar, nvar);
    for i=1:nvar
      for j=i:nvar
        y(i,j) = f(x+h*I(:,i)+h*I(:,j))-f(x+h*I(:,i)-h*I(:,j))-f(x-h*I(:,i)+h*I(:,j))+f(x-h*I(:,i)-h*I(:,j));
        y(j,i) = y(i,j);
      end
    end
    y = y / (4*h*h);
  end

  
  function y = loc_H(x)
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
  
  H = @loc_H;
end
