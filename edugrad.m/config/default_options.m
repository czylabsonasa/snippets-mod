% terminology: direction and stepsize
% x <-- x + a * p
% a>=0, p search direction
function options = default_options()
  options = struct();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find a direction
%
  grad_descent = struct();
 
  momentum.B=0.77;
  
  newton = struct();
  
  options.direction = struct( ...
    "grad_descent" , grad_descent,...
    "momentum", momentum,...
    "newton", newton,...
    "do", "grad_descent"...
   );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find a stepsize for the direction (also make that step)
% 

  fixstep.A = 0.1;

  % options.step = "armijo0";
  armijo.A = 10;
  armijo.C = 0.5;
  armijo.R = 0.5;
  armijo.maxit = 100;
  
  % options.step = "armijo1";
  armijo_inc.A = 10;
  armijo_inc.C = 0.5;
  armijo_inc.R = 0.5;
  armijo_inc.RR = 1.5;
  armijo_inc.maxit = 100;
  
  % options.step = "fminbnd";
  fminbnd.A = 1;

    
  options.step = struct( ...
    "fixstep" , fixstep,...
    "armijo", armijo,...
    "armijo_inc", armijo_inc,...
    "fminbnd", fminbnd,...
    "do", "fixstep"...
   );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  momentum.B=0.5;
  options.prestep = struct( ...
    "momentum", momentum,...
    "do", ""...
  );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  heavyball.B=0.1;
  options.poststep = struct( ...
    "heavyball", heavyball,...
    "do", ""...
  );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
% grad or not
  options.usedf = true;
  options.approx_grad.tol = 1e-5;
  options.approx_grad.maxit = 30;
% H or not
  options.useH = true;
  options.approx_H.tol = 1e-5;
  options.approx_H.maxit = 60;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
 
% general
% 
  options.maxit = 10000;
  options.xtol = 1e-9;
  options.dftol = 1e-6;
  options.inbound = true; % do not leave the LO-UP domain

end
