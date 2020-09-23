function [S,time,counter2] = PostKFSS(Q,A,C,W,V,B)

% this function uses a Posteriori Greedy algorithm to optimize sensor
% location for the Kalman filtering of a dynamical system
% Q is the set of possible sensor, A is an nxn matrix, C an pxn matrix, W
% is nxn and V is pxp.

% S is the chosen set of sensors, and time is the runtime of the loop,
%   counter2 is 1 if at any point PostDARE did not converge, and 0
%   otherwise.

k=1;
S = [];
Q_temp = Q;
counter2 = 0;
n = length(A);

tic;
while k<=B
    tr = [];
    for i = 1:length(Q_temp)
        S_temp = S;
        S_temp(end+1)=Q_temp(i);
        V_hat = build_nonzeroV(V,S_temp);
        C_hat = build_nonzeroC(C,S_temp);
        [Sigma_Z,counter] = PostDARE(A,C_hat,W,V_hat);
        
        % This if statement checks if the PostDARE function converged
        if counter > 250
            counter2 = 1;
        end
        tr(i) = trace(Sigma_Z);   
    end
    [~,j] = min(tr);
    S(end+1) = Q_temp(j);
    Q_temp = setdiff(Q_temp,Q_temp(j));
    k = k+1;
end
time = toc;

if counter2 == 1;
    disp(['PostDARE did not converge for n=',num2str(n)])
end

S = sort(S);