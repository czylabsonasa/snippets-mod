% creates the callable form of 'f', 'df', 'H' (+nfuneval handling)

function fun=mk_funs(fun, opts)
  arguments
    fun struct
    opts struct
  end

  nfuneval =  0;

  nvar = fun.nvar

  f = eval("@(x)" + mk_vec_form(fun.f, nvar));

  add_df = nvar;
  add_H = nvar^2;
  if isfield(fun, "df") && isfield(opts, "usedf") && opts.usedf == true
    df = eval("@(x)" + mk_vec_form(fun.df, nvar));
  else
    df = mk_approx_grad(@loc_f, nvar, opts.approx_grad); % f is not nfuneval aware
    add_df = 0;
  end

  if isfield(fun, "H") && opts.useH == true
    H = eval("@(x)" + mk_vec_form(fun.H, nvar));
  else
    H = mk_approx_H(@loc_f, nvar, opts.approx_H);
    add_H = 0;
  end

  function y=loc_f(x)
    nfuneval = nfuneval + 1;
    %nfuneval
    y = f(x);
  end

  function y=loc_df(x)
    nfuneval = nfuneval + add_df;
    %if add_df>0, nfuneval, end

    y = df(x);
  end

  function y=loc_H(x)
    nfuneval = nfuneval + add_H;
    %if add_H>0, nfuneval, end

    y = H(x);
  end

  function y = get_funeval()
    y = nfuneval;
  end

  function reset_funeval()
    nfuneval=0;
  end

%disp(nfuneval)

  fun.f = @loc_f;
  fun.df = @loc_df;
  fun.H = @loc_H;
  fun.get_funeval = @get_funeval;
  fun.reset_funeval = @reset_funeval;
end



function str = mk_vec_form(str, nvar)
  for it=nvar:-1:1
    from = sprintf("x%d", it);
    to = sprintf("x(%d)", it);
    str = replace(str, from, to);
  end
end

