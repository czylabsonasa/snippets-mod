clear all;
N = 100;
n = 11;

ocbinom = sum(randi(2, n, N)-1);
plot(1:N, ocbinom, 'r*')
hold on;
plot([1,N], [n/2, n/2])
ocunif = rand(1,N)*n;
plot(1:N, ocunif, 'b*')

return

% S = 0;
% for i=1:N
%   S = S + sum(randi(2,1,n)-1);
% end
% S/N