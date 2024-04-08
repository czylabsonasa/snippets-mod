function opts = mk_direction(obj_fun, opts)
  ret = eval("mk_" + opts.direction.do+ "(obj_fun, opts)");

  if ~isfield(ret,"initialize")
    ret.initialize = @initialize;
  end
  
  if ~isfield(ret,"update")
    ret.update = @update;
  end

  opts.edugrad.direction = ret;
end

function initialize(~)
end

function update(~)
end
