function opts=mk_inbound(obj_fun, opts)
  if opts.inbound == true
    opts.is_inbound = @(x) all(x>=obj_fun.LO & x<=obj_fun.UP);
  else
    opts.is_inbound = @(x) true;
  end
end
