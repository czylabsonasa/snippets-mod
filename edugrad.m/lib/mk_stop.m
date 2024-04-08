function opts = mk_stop(~, opts)
  xtol = opts.xtol;
  dftol = opts.dftol;
  function s = stop_fun(state)
    s = "";
    if norm(state.dx_next, 1)<norm(state.x_next, 1)*xtol 
      s = "|xtol";
    end
    if norm(state.df_act, 1)<dftol
      s = s + "|dftol";
    end
    if s ~= "", s=s+"|"; end
  end

  opts.stop = @stop_fun;
end
