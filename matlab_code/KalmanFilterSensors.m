function [x_filter_1,x_filter_2,x,Sigma_1,Sigma_2] = KalmanFilterSensors(A,C,W,V,x0,S1,S2,T)

%This function takes in two sensor combinations (of the same length), and 
% runs the Kalman filter on the system with each set of sensors active.

n = length(A);
B = length(S1);

V_hat_1 = build_nonzeroV(V,S1);
C_hat_1 = build_nonzeroC(C,S1);
Sigma_1 = dare(A,C_hat_1',W,V_hat_1);
K_1 = A*Sigma_1*C_hat_1'/(C_hat_1*Sigma_1*C_hat_1'+V_hat_1);

V_hat_2 = build_nonzeroV(V,S2);
C_hat_2 = build_nonzeroC(C,S2);
Sigma_2 = dare(A,C_hat_2',W,V_hat_2);
K_2 = A*Sigma_2*C_hat_2'/(C_hat_2*Sigma_2*C_hat_2'+V_hat_2);

x = zeros(n,T);
x_filter_1 = zeros(n,T);
x_filter_2 = zeros(n,T);
y = zeros(B,T);
x(:,1) = x0;
x_filter_1(:,1) = x0;
x_filter_2(:,1) = x0;
t=1;

while t<T
    y(:,t) = C_hat_1*x(:, t) + mvnrnd(zeros(B,1), V_hat_1)';
    x(:,t+1) = A*x(:, t) + mvnrnd(zeros(n,1), W)';
    x_filter_1(:,t+1) = (A-K_1*C_hat_1)*x_filter_1(:,t) + K_1*y(:,t);
    x_filter_2(:,t+1) = (A-K_2*C_hat_2)*x_filter_2(:,t) + K_2*y(:,t);
    t = t+1;
end

    
