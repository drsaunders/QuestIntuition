beta = 3.5;
gamma = 0;
x = -0.2:0.01:0.2;
y = questfunc(x,beta,gamma);
figure; plot(x,y);

s = y(2:end)-y(1:end-1);
t = y .* (1-y);
b = t(2:end) ./ s.^2;
[m n] = min(b);
figure; plot(x(2:end),b)
questfunc(x(n),beta,gamma)