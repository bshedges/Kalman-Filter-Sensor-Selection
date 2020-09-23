function [Sigma,counter] = PostDARE(A,C,W,V)

% This function iteratively solves the Posteriori Sigma equation, very
%   similar to built-in function DARE. Unlike DARE, PostDARE is not often
%   able to converge for n>25.

n = length(A);
Sigma_prev = ones(n);
Sigma_next = zeros(n);
counter=0;

while norm(Sigma_next-Sigma_prev) > 1e-5
    if counter > 300
        break
    end
    Sigma_prev = Sigma_next;
    Sigma_temp = A*Sigma_prev*A'+W;
    Sigma_next = Sigma_temp - Sigma_temp*C'*inv(C*Sigma_temp*C'+V)*(C*Sigma_temp);
    counter = counter+1;
end

Sigma = Sigma_prev;
