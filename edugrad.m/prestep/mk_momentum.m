function mom = mk_momentum(~, opts)
  B = opts.prestep.momentum.B;

  function pars = momentum(pars)
    p = pars.p;
    dx = pars.dx_act;
    pp = dot(p,p);
    pdx = dot(p, dx);
    if pp + 1.1*B*pdx > 0
      B=1.1*B;
    end
    B = min(0.999, B);
    for it=1:10
      if pp + B*pdx > 0, break; end
      B = 0.5*B;
    end
    B = max(B, 0.0001);
      
    pars.p = p + B*dx;
  end
  
  mom = @momentum;

end
