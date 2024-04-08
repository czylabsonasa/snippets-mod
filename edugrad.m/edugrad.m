
function [X, result] = edugrad(obj_fun, x0, opts)
  arguments
    obj_fun struct
    x0 (:,1) double
    opts struct
  end

  ini_funeval = obj_fun.get_funeval();


  direction = opts.edugrad.direction;

  pre_step = opts.edugrad.pre_step;

  step = opts.edugrad.step;
  
  post_step = opts.edugrad.post_step;


  stop = opts.stop;
  df = obj_fun.df;
  nvar = obj_fun.nvar;

  null = zeros(nvar, 1);

  % state = parameters etc.
  state.dx_act = null;
  state.x_act = x0;
  state.df_act = df(x0);
  state.ddf_act  = null;

  X = [x0];


  direction.initialize(state);
  step.initialize(state);
  
  stop_ev = "";
  it = 0;
  while true
    it = it +1;
    if it>opts.maxit, stop_ev = "|maxit|"; break; end

    state = direction.compute(state);
    state = pre_step.compute(state);
    state = step.compute(state);
    state = post_step.compute(state);

    state.df_next = df(state.x_next);

    state.dx_next = state.x_next - state.x_act;
  
    stop_ev = stop(state);

    state.dx_act = state.dx_next; 
    
    state.x_act = state.x_next; 

    state.ddf_act = state.df_next - state.df_act;
    state.df_act = state.df_next; 

    direction.update(state);

    X = [X, state.x_act];

    if stop_ev ~= "", break; end

  end

%fprintf("a vegen: %d\n", obj_fun.get_funeval());

  result.norm_dx = norm(state.dx_act);
  result.norm_df =  norm(state.df_act);
  result.x_act = state.x_act;
  result.it = it;
  result.nfuneval = obj_fun.get_funeval()-ini_funeval;
  result.stop_ev = stop_ev;
end

