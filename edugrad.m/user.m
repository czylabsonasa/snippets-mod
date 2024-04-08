% entry point script
% responsibility:
%   - sets + resets the path
%   - gets default options + testfunctions
%   - sets the actual function
%   - the default attributes can be overridden here
%   - calls wrap
% run it from its containing dir. (->genpath())

clear; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pths = genpath(pwd());
addpath(pths);
% path

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tf = importdata("testfunc.json");
tf = jsondecode(string(tf));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_options = default_options();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fun = tf.quad1;
% xs = -4:4;
% ys = -4*ones(size(xs));


obj_fun = tf.Rosenbrock;
xs = -1.5:0.5:1.5;
ys = -ones(size(xs));


user_options.start = [xs;ys];
user_options.start = user_options.start(:,1);

user_options.inbound = false; %true;

user_options.usedf = true;false; %true;
user_options.useH = true;false; % true;

%user_options.n_start = 2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_options.direction.do = "newton"; %"grad_descent";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_options.step.do = "fixstep";
user_options.step.fixstep.A = 1;

% user_options.step.do = "fminbnd";
% user_options.step.fminbnd.A = 2;
% 
% user_options.step.do = "armijo_inc";
% user_options.step.armijo_inc.C = 0.7;
% user_options.step.armijo_inc.maxit = 5;

% user_options.step.do = "armijo";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_options.pre_step.do = ""; %"momentum";
user_options.pre_step.momentum.B = 0.9;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

user_options.post_step.do = ""; %"heavyball";
user_options.post_step.heavyball.B = 0.4;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wrap(obj_fun, user_options);

rmpath(pths);
