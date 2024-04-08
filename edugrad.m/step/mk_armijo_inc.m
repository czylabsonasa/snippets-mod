% A is fixed, only decrease is possible
% 

function ret = mk_armijo_inc(obj_fun, opts) % ignore parameters
  preA = opts.step.armijo_inc.A;
  C = opts.step.armijo_inc.C;
  R = opts.step.armijo_inc.R;  
  RR = opts.step.armijo_inc.RR;  

  A = preA;

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
    % increase
    for it=1:maxit
      if ~is_inbound(x+a*RR*p) || f(x + a*RR*p) > fx + C*a*RR*delta
        break;
      end
      a=a*RR;
    end

    
    
    % decrease
    for it=1:maxit
      if is_inbound(x + a*p) && f(x + a*p) < fx + C * a * delta
        break;
      end
      a = a*R;
    end
    state.A = a;
    state.x_next = x + a*p;
    A = a;
  end

  ret.compute = @compute;
  ret.name = "Armijo + inc";
end
