clear
clc

% This function runs the 5 major scripts. They can take a long time to run
% so I've defined a vector k. The Functions are labeled 1:5 and Function i
% will only run if i is in k. Functions 2 and 3 take the longest to run, so
% definitely suppress them if you want to see what happens in the other
% scripts.

k = [1,2,3,4,5];

B1 = 4;
p1 = 10;
n1 = 2;
Q1 = 1:p1;
W1 = eye(n1);
V1 = eye(p1);
A1 = rand(n1);

% We make sure the system doesn't blow up for readability
for i = 1:100
    eig_max = max(eig(A1));
    if eig_max < 1
        break
    end
    A1 = rand(n1);
end
C = rand(p1,n1);
S = PriKFSS(Q1,A1,C,W1,V1,B1);

%% Function 1

if ismember(1,k)
    disp(['the greedy sensor placement for this system is [',num2str(S),']'])

    S_opt = optimal_S(Q1,A1,C,W1,V1,B1);
    if S_opt == S
        disp('this is the optimal sensor placement')
    else
        disp('this is not the optimal sensor placement')
        disp(['the optimal sensor placement is [',num2str(S_opt),']'])
    end
end

%% Function 2

if ismember(2,k)
    run('runtimes.m');
end


%% Function 3

if ismember(3,k)
    run('plot_ratio.m');
end

%% Function 4

if ismember(4,k)
    
    x0 = zeros(n1,1);
    T = 100;
    S_opt = optimal_S(Q1,A1,C,W1,V1,B1);
    [x_greedy,x_opt,x1,Sigma_1,Sigma_2] = KalmanFilterSensors(A1,C,W1,V1,x0,S,S_opt,T);

    figure(10)
    plot(1:T,x_greedy(1,:),1:T,x_opt(1,:),1:T,x1(1,:))
    title('Kalman Filtering with Greedy/Random Sensor Placement')
    legend(['Greedy (',num2str(S),')'],['optimal (',num2str(S_opt),')'],'exact')
    xlabel('time')
    ylabel('x')
end

%% Function 5

if ismember(5,k)
    run('runtimesPriPost');
end
