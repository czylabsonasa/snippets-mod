function ret = mk_dfp(obj_fun, opts)
  B = eye(obj_fun.nvar);


  function initialize(state)
    if opts.direction.dfp.init == "H"
      B = obj_fun.H(state.x_act);
    else
      B = eye(obj_fun.nvar);
    end
  end

  function state = compute(state)
    state.p = B \ (-state.df_act);
    
  end


  function update(state)
  end


  ret = struct(...
    "initialize", @initialize,...
    "compute", @compute,...
    "update", @update,...
    "name", "dfp"...
  );
  
end
