clear all ; 
clf ;

f = @(t, y)  -4*y./t+t.^3.*y.^2;

tb = 0.5:0.03:2.5 ;
yb = -1:0.1:1.5 ;

[T,Y] = meshgrid(tb, yb) ;
dY = f(T, Y) ;
dT = ones(size(dY)) ;
quiver(T,Y, dT, dY) ;


mo = @(t) 1 ./(1-log(t)) .*t.^(-4) ;

xx = linspace(0.5,2.5) ;
hold on ;
plot(xx, mo(xx)) ;

ylim([-1,1.5]) ;