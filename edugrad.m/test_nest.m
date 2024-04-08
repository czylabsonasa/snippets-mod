function [f1, f2, f3, get] = test_nest()
  n = 0;

  function pf1()
    n = n + 1;
  end

  function pf2()
    n = n + 1;
  end

  function pf3()
    n = n + 1;
  end

  function y = pget()
    y = n;
  end

  f1 = @pf1;
  f2 = @pf2;
  f3 = @pf3;
  get = @ pget;

end
