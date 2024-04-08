% if opts.inbound == false then A is fixed
% otherwise we try to increase or decrease it as needed

function ret = mk_fminbnd(obj_fun, opts) % ignore parameters
  preA = opts.step.fminbnd.A;
  inbound = opts.inbound;
  is_inbound = opts.is_inbound;
  f = obj_fun.f;

  A = preA;

  function state = compute(state)
    p = state.p;
    x = state.x_act;
    a = A;
    if inbound
      %y = f(x);
      RR = 1.5;
      while is_inbound(x + RR*a*p)
        % y1 = f(x + RR*a*p);
        % if y1>y, break; end
        % y = y1;
        a = RR*a;
      end
      while ~is_inbound(x + a*p)
        a = a/2;
      end
    end
    a = fminbnd(@(aa) f(x + aa*p), 0, a);
    state.A = a;
    state.x_next = x + a*p;
    A = a;
  end

  ret.compute = @compute;
  ret.name = "fminbnd";
end
