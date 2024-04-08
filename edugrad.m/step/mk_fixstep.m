function ret = mk_fixstep(~, opts) % ignore parameters
  A = opts.step.fixstep.A;
  is_inbound = opts.is_inbound;

  function state = compute(state)
    state.A = A; % several pointless updates
    tmp = state.x_act + A*state.p;
    if is_inbound(tmp)
      state.x_next = tmp;
    else
      state.x_next = state.x_act;
    end
  end

  ret.compute = @compute;
  ret.name = "fix-step";
end
