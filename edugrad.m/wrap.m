% prepares/executes the optimization
%   - def: inbound
%   - def: 'f','df','H' via 'mk_ funs'
%   - runs the optimization from each point of 'start'
% creates contour + funct. value plots

function wrap(obj_fun, opts)
  arguments
    obj_fun struct
    opts struct
  end

  opts = mk_inbound(obj_fun, opts);

  opts = mk_stop(obj_fun, opts);

  obj_fun = mk_obj_fun(obj_fun, opts);

  opts = mk_direction(obj_fun, opts);
  
  opts = mk_pre_step(obj_fun, opts);

  opts = mk_step(obj_fun, opts);

  opts = mk_post_step(obj_fun, opts);


  % nvar = obj_fun.nvar;
  f = obj_fun.f;

  opt_loc = obj_fun.opt_loc; 
  opt_val = f(opt_loc);

 
  opts = mk_start(obj_fun, opts);

  [inter_plot, final_plot] = mk_plot(obj_fun, opts);

  stats = [0;0;0]; % ||xakt-xopt|| átlag + it átlag, nfuneval átlag
  subtract = 0; % handle the excess fun-calls made by plot

  obj_fun.reset_funeval();
  for x0 = opts.start
    disp(x0);
    [X, result] = edugrad(obj_fun, x0, opts);
    stats = stats + [result.it; result.nfuneval; abs(f(result.x_act)-opt_val)];
    
    [~,c] = size(X);
    subtract = subtract + c; 

    inter_plot(X);
  end
  if opts.n_start>1
    %stats(2) = stats(2)-subtract;
  end
  stats = stats/opts.n_start;

  final_plot(result, stats, X);
end

