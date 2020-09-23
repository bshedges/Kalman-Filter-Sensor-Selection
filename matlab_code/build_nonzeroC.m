function C_hat = build_nonzeroC(C,S)

% This function inputs C (the measurment matrix from our original problem),
%   S, the set of sensors that are currently installed

% C_hat is the nonzero rows of the matrix we get when computing
% Z*C

S = sort(S);
k = length(S);
C_hat = zeros(k,size(C,2));

for i=1:k
    C_hat(i,:) = C(S(i),:);
end
