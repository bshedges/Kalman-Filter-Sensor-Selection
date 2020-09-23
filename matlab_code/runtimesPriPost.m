

% I will write a script to compare the runtimes for Priori and Posteriori
% algorithms for n increasing

% n,p,B,L

p=10;
Q = 1:p;
B=5;
N=40; % Choose N<=40. Otherwise, DARE has trouble converging fairly often.
      %  N is the largest matrix for which we will check runtime.
Post_runtimes = NaN(N,1);
Pri_runtimes = NaN(N,1);

V = eye(p);

for n=1:N
    eigs = 0:1/n:(1-1e-5);
    A = rand(n);
    % We need that (A,C) is detectable, so we will include a try-catch to
    % place the eigenvalues of A using matlab function place. This is
    % obviously not a perfect way to check detectability, but it's better
    % than not checking.
    C = rand(p,n);
    try 
        place(A',C',eigs);
    catch
        disp('(A,C) might not be detectable')
        continue
    end
    W = eye(n);
    [~,t1] = PriKFSS(Q,A,C,W,V,B);
    Pri_runtimes(n) = t1;
    if n<=25
        [~,t2,counter] = PostKFSS(Q,A,C,W,V,B);
        Post_runtimes(n) = t2;
    end
%     disp(num2str(n))
end

figure(11)
plot(1:N,Pri_runtimes,'--^',1:N,Post_runtimes,'--s')
title('Priori and Posteriori Runtimes with changing n')
xlabel('number of states')
ylabel('runtime (seconds)')
legend('Priori','Posteriori')

n=2;
A = rand(n);
W = eye(n);
P = 20;
Post_runtimes_2 = NaN(P-B,1);
Pri_runtimes_2 = NaN(P-B,1);
i = 1;


for p = B:P
    Q = 1:p;
    V = eye(p);
    C = rand(p,n);
    [~,t1] = PriKFSS(Q,A,C,W,V,B);
    Pri_runtimes_2(i) = t1;
    [~,t2,counter] = PostKFSS(Q,A,C,W,V,B);
    Post_runtimes_2(i) = t2;
    i = i+1;
end

figure(12)
plot(B:P,Pri_runtimes_2,'--^',B:P,Post_runtimes_2,'--s')
title('Priori and Posteriori Runtimes with changing p')
xlabel('number of states')
ylabel('runtime (seconds)')
legend('Priori','Posteriori')



