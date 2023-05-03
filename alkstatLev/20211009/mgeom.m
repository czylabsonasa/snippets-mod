clear all;
N = 1000;

S = 0;
for i=1:N
  k=0;
  while true
    k=k+1
    if randi(6)==6, break; end
  end
  S=S+k;
end
S/N