function ret = mk_newton(obj_fun, opts)

  H = obj_fun.H;

  function state = compute(state)
    state.p = H(state.x_act) \ (-state.df_act);
  end


  ret.compute = @compute;
  ret.name = "newton";

end
