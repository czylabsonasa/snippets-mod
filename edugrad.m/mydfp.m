% dfp implementacio a jegyzet alapjan

clear;
websave("testfunc.json", "https://arato.inf.unideb.hu/noszaly.csaba/data/testfunc.json");
tf = jsondecode(string(importdata("testfunc.json")));
fun = tf.Rosenbrock;

figure(1);
plot_contour(fun,55,55);
  
f = eval(fun.f);
fv = @(x) f(x(1),x(2));
df = eval(fun.df);
dfv = @(x) df(x(1),x(2));
H = eval(fun.H);
Hv = @(x) H(x(1),x(2));


I = eye(2);

% x0 = [-1.2; 1];
x0 = (fun.UP-fun.LO)*rand(2,1)+ fun.LO;
B0 = I; % Hv(x0);
A0 = 10;

xakt = x0;
dfakt = dfv(xakt);
Bakt = B0;
X = [xakt];
Y = [fv(xakt)];

for it=1:1000
  p = Bakt \ (-dfakt);
  A = A0;
  while any(xakt + A*p < fun.LO | xakt + A*p > fun.UP)
    A = A / 2;
  end
  alfa = fminbnd(@(a) fv(xakt + a*p), 0, A);
  xnext = xakt + alfa * p;

  X = [X, xnext];
  Y = [Y, fv(xnext)];

  dfnext = dfv(xnext);

  s = xnext - xakt; % = alfa*p
  y = dfnext - dfakt ;

  if norm(s, 1)<norm(xnext,1)*1e-6 || norm(dfnext)<1e-6
    break;
  end
  
  Bakt = ( I - (y*s') / (s'*y) )*Bakt*( I - (s*y') / (s'*y) ) + (y*y') / (y'*s);
  xakt = xnext;
  dfakt = dfnext;

end

last = X(:,end);
dto = norm(last-fun.xopt);
title( sprintf( "it: %d\n dist-to-opt: %.4e\n last: (%.2f; %.2f)", it, dto, last(1), last(2) ) );

plot(X(1,:), X(2,:),".-");
xlim([fun.LO-0.05*abs(fun.LO), fun.UP+0.05*abs(fun.UP)]);
ylim([fun.LO-0.05*abs(fun.LO), fun.UP+0.05*abs(fun.UP)]);

figure(2)
plot(Y, ".-");