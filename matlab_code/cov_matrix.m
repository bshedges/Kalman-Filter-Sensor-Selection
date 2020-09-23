function Sigma = cov_matrix(S,A,W,V,C)

% this function takes S, a set of sensors and finds the covariance matrix
%  with those sensors turned on, by solving the DARE.

k = length(S);

if k == length(V)
    V_hat=V;
    C_hat=C;
else
    V_hat = build_nonzeroV(V,S);
    C_hat = build_nonzeroC(C,S);
end

Sigma = dare(A,C_hat',W,V_hat);