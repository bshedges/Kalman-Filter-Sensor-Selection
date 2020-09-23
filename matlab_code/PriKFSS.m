function [S,time] = PriKFSS(Q,A,C,W,V,B)

% This function uses the Greedy algorithm to calculate optimal sensor
% location for Kalman Filtering of a linear dynamical system. Specifically
% a Priori Covariance method. The algorithm is outlined in the original
% paper.

% S is the chosen set of sensors, and time is the runtime of the loop.

k=1;
S = [];
Q_temp = Q;

tic;
while k<=B
    tr = [];
    for i = 1:length(Q_temp)
        S_temp = S;
        S_temp(end+1)=Q_temp(i);
        V_hat = build_nonzeroV(V,S_temp);
        C_hat = build_nonzeroC(C,S_temp);
        % For dim(A) large, there's a possibility that DARE won't converge.
        %  We will skip cases where this is true for the intent of some of
        %  the analysis, but we would normally make sure it converges
        %  before this point otherwise.
        try
            dare(A,C_hat',W,V_hat);
        catch
            disp('Riccati equation does not have a finite solution')
            continue
        end
        Sigma_Z = dare(A,C_hat',W,V_hat);
        tr(i) = trace(Sigma_Z);   
    end
    [~,j] = min(tr);
    S(end+1) = Q_temp(j);
    Q_temp = setdiff(Q_temp,Q_temp(j));
    k = k+1;
end
time = toc;

S = sort(S);
        
    
        