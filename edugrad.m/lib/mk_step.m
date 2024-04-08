function opts = mk_step(obj_fun, opts)
  ret = eval("mk_" + opts.step.do+ "(obj_fun, opts)");

  if ~isfield(ret,"initialize")
    ret.initialize = @initialize;
  end

  if ~isfield(ret,"update")
    ret.update = @update;
  end

  opts.edugrad.step = ret;
end

function initialize(~)
end

function update(~)
end
