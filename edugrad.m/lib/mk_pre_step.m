function opts = mk_pre_step(obj_fun, opts)
  ret = struct();
  
  if opts.pre_step.do >""
    ret = eval("mk_" + opts.pre_step.do+ "(obj_fun, opts)");
  end

  if ~isfield(ret,"initialize")
    ret.initialize = @initialize;
  end

  if ~isfield(ret,"compute")
    ret.compute = @compute;
  end

  if ~isfield(ret,"update")
    ret.update = @update;
  end

  opts.edugrad.pre_step = ret;
end

function initialize(~)
end

function state = compute(state)
end

function update(~)
end
