% A is fixed, only decrease is possible
% 

function ret = mk_armijo(obj_fun, opts) % ignore parameters
  A = opts.step.armijo.A;
  C = opts.step.armijo.C;
  R = opts.step.armijo.R;  
  maxit = opts.step.armijo.maxit;  
  f = obj_fun.f;
  is_inbound = opts.is_inbound;
  

  function state = compute(state)
    p = state.p;
    x = state.x_act;
    df = state.df_act;
    delta = dot(df, p);
    fx = f(x);

    a = A;
    for it=1:maxit
      if is_inbound(x + a*p) && f(x + a*p) < fx + C * a * delta
        break;
      end
      a = a*R;
    end
    state.A = a;
    state.x_next = x + a*p;
  end

  ret.compute = @compute;
  ret.name = "Armijo";
end
