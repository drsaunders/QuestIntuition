function y = questfunc(x,beta,gamma)
if ~exist('beta','var')
    beta = 3.5;
end
if ~exist('gamma','var')
    gamma = 0.5;
end
y = 1-(1-gamma) * exp(-10.^(beta*x));
