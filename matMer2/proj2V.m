hold off;
clf;
clear;

% explicit alak jobboldala: f
f=@(t,y,dy) -dy-3*y+t-1;
fv=@(t,v) [v(2), f(t,v(1),v(2))]'; 
t0=0; tv=1; y0=[2,0]'; lepes=50;

fprintf("abszolút hiba\n") ;
fprintf("lépés\tEuler\tRK1\n") ;

lepesek=[4,8,16,32,64,128] ;
for it=1:length(lepesek)
  lepes=lepesek(it) ;
  
  [tE,yE]=EulerV(fv,[t0,tv],y0,lepes);
  [tR,yR]=RK1V(fv,[t0,tv],y0,lepes);
  subplot(2,3,it) ;
  plot(tE,yE(:,1),'*');
  hold on
  plot(tR,yR(:,1),'.');
  [t45,y45]=ode45(fv,[t0,tv],y0);
  plot(t45,y45(:,1),'d');

  legend('Euler','RK1','ode45', 'location','northeastoutside')
  fprintf("%d\t%.4f\t%.4f\n",...
    lepes,abs(yE(end,1)-y45(end,1)),abs(yR(end,1)-y45(end,1))) ;
end


% Euler módszer
function [t,y]=EulerV(f,tr,y0,lepes)
  t=linspace(tr(1),tr(2),lepes+1);
  y=zeros(2,lepes+1);
  h=t(2)-t(1); % == (tr(2)-tr(1)) / lepes
  y(:,1)=y0;
  for it=1:lepes
    y(:,it+1)=y(:,it)+h*f(t(it),y(:,it));
  end
  y=y';
end

% RK I változat az eloadas foliakban
function [t,y]=RK1V(f,tr,y0,lepes)
  t=linspace(tr(1),tr(2),lepes+1);
  y=zeros(2,lepes+1);
  h=t(2)-t(1);
  y(:,1)=y0;
  for it=1:lepes
    k1=f(t(it),y(:,it));
    k2=f(t(it)+h/2,y(:,it)+h/2*k1);
    y(:,it+1)=y(:,it)+h*k2;
  end
  y=y';
end
  