function ret = mk_heavyball(~, opts)
  B = opts.poststep.heavyball.B;

  function state = compute(state)
    state.x_act = state.x_act + B*state.dx_act;
  end
  
  ret.compute = @compute;
  ret.name = "heavy-ball";

end
