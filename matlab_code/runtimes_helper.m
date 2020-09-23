function [t1,t2] = runtimes_helper(n,p,B)

Q = 1:p;
A = rand(n);
C = rand(p,n);
W = eye(n);
V = eye(p);

[~,t1] = PriKFSS(Q,A,C,W,V,B);

tic;
S_all = nchoosek(Q,B);
L = nchoosek(p,B);
Sigma_min = 1000;
index = 0;

tic;
for k=1:L
    S = S_all(k,:);
    Sigma = cov_matrix(S,A,W,V,C);
    if Sigma < Sigma_min
        Sigma_min = Sigma;
        index = k;
    end
end

S = S_all(index,:);
t2 = toc;

