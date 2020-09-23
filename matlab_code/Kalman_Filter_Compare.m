clear
clc

% This script will run the steady-state Kalman filtering of a system using
% the optimal sensor placement according to our algorithm. It will also run
% the Kalman filter for a randomly chosen set of sensors. 

% We will run the Kalman filter on N systems, and plot the results

N = 30;
T = 100;
n = 2;
p = 9;
B = 3;
Q = 1:p;

% We're interested with the difference between the trace of the Sigma our
% algorithm chooses and the trace we get from a random Sensor selection.
diff = NaN(1,N);
S_all = nchoosek(Q,B);
W = eye(n);
V = eye(p);
sig_min = 1000;

for i=1:N
    A = rand(n);
    % We make sure our system doesn't blow up too fast if at all, for
    %  readability.
    for j = 1:10
        e = max(eig(A));
        if e < 1
            break
        end
        A = rand(n);
    end
    C = rand(p,n);
    r = randi([1 length(S_all)],1,1);
    % We will use the Priori KFSS because it has better convergence.
    S_opt = PriKFSS(Q,A,C,W,V,B);
    S_rand = S_all(r,:);
    
    
    % We now plot the solutions. Note that these solutions don't give us
    %  too much information. Rather, they display that different sensor
    %  selections give different filtered solutions. 
    
    % Remember that our metric for a 'good' sensor selection is minimizing
    % the trace of Sigma, so we will include our values of tr(Sigma) on the
    % plots. One interesting thing to notice is that the closer the traces
    % are, the more similar the outputs are.
    
    x0 = zeros(n,1);
    [x_opt,x_rand,x1,Sig_opt,Sig_rand] = KalmanFilterSensors(A,C,W,V,x0,S_opt,S_rand,T);
    tr_opt = trace(Sig_opt);
    tr_rand = trace(Sig_rand);
    
    figure(i)
    plot(1:T,x_opt(1,:),1:T,x_rand(1,:),1:T,x1(1,:))
    text(3,min(x1(1,:))+0.1,['trace(Sigma Greedy)=',num2str(tr_opt)])
    text(3,min(x1(1,:))+0.25*abs(min(x1(1,:))),['trace(Sigma Random)=',num2str(tr_rand)])
    % Uncomment the lines below to display the Sigmas on the plots
    text(45,min(x1(1,:))+0.1, num2str(Sig_opt))
    text(45,min(x1(1,:))+0.25*abs(min(x1(1,:))),num2str(Sig_rand))
    
    title('Kalman Filtering with Greedy/Random Sensor Placement')
    legend(['Greedy (',num2str(S_opt),')'],['random (',num2str(S_rand),')'],'exact')
    xlabel('time')
    ylabel('x')
    % Un-comment the lines below to print the Sigma matrices we get at each
    % step.
    disp(i)
    disp(Sig_opt)
    disp(Sig_rand)
    if abs(tr_opt-tr_rand)>1e-13
        % Find how 'close' the random sensor selection and greedy sensor
        % selection are, unless they are the exact same.
        diff(i) = abs(tr_opt-tr_rand);
    end
end

% Below we find the index of figure that minimizes the difference of the 
%  traces (not considering the case where the random sensor selection is
%  the same as the one our algorithm chooses)
[~,i] = min(diff);
disp(i)


