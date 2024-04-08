function opts = mk_start(obj_fun, opts)
  
  % handle starting points
  if ~isfield(opts, "start") || isempty(opts.start)
    if ~isfield(opts, "n_start")
      opts.n_start = 5;
    end
    n_start = opts.n_start;
    start=zeros(nvar, n_start);
    for it = 1:n_start
      start(:, it) = random("Uniform", obj_fun.LO, obj_fun.UP);
    end
  end
  [~,opts.n_start] = size(opts.start);

end