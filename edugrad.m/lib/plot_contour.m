function plot_contour(ax, fun, d1, d2, nb1, nb2, nc)
  arguments 
    ax matlab.graphics.axis.Axes
    fun struct
    d1 int16 = 1
    d2 int16 = 2
    nb1 int16 = 50     % meshgrid
    nb2 int16 = 50
    nc int16 = 30     % contour
  end

  b1 = linspace(fun.LO(d1), fun.UP(d1), nb1);
  b2 = linspace(fun.LO(d2), fun.UP(d2), nb2);

  f = fun.f;
  [X,Y] = meshgrid(b1, b2); % X: the b1 in nb2 instances below each other
  Z = zeros(size(X));
  for i1=1:nb1
    for i2=1:nb2
      Z(i2,i1) = f([X(i2,i1); Y(i2,i1)]);
    end
  end

  contour(ax, X, Y, Z, nc)
end
