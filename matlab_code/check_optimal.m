function [ratio,time] = check_optimal(n,p,B,L)

% We now would like a function to compute how many times the greedy
% solution is the one that minimizes the trace. We do this by calculating
% the trace when we take every possible combination of sensors.

% Here, L is the number of times we would like to run the comparison.
% n is the size of A and W
% p is the number of rows of C, and the dimension of V
% B is the number of sensors we need to place. B<=p

ismin=0;
Q = 1:p;
W = eye(n);
V = eye(p);
S_matrix = nchoosek(Q,B); % A list of all possible sensor locations

tic;
for k = 1:L
    A = rand(n);
    C = rand(p,n);
    S = PriKFSS(Q,A,C,W,V,B);
    tr = zeros(1,length(S));

    for i=1:length(S_matrix)
        Sigma = cov_matrix(S_matrix(i,:),A,W,V,C);
        tr(i) = trace(Sigma);
    end
    [~,j] = min(tr);

    if S_matrix(j,:) == S
        ismin = ismin+1;
    end
end
time = toc;

ratio = ismin/L;

