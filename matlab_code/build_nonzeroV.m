function V_hat = build_nonzeroV(V,S)

% This function inputs V (the covariance matrix from our original problem),
%   S, the set of sensors that are currently installed

% V_hat outputs the nonzero elements of the matrix we get when computing
% Z*V*Z'

S = sort(S);
k = length(S);
V_hat = zeros(k);

for i = 1:k
    for j = 1:k
        V_hat(i,j) = V(S(i),S(j));
    end
end
