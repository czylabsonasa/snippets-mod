function ret = mk_grad_descent(obj_fun, opts) % ignore parameters

  function state = compute(state)
    state.p = -state.df_act;
  end

  ret.compute = @compute;
  ret.name = "gradient descent";
  
end
