n=4;
B = 3;
P = 20;
N = 20;
t1 = NaN(P,1);
t2 = NaN(P,1);

for p = B+1:P
    [t1(p),t2(p)] = runtimes_helper(n,p,B);
end

figure(1)
plot(1:P,t1,'--s',1:P,t2,'--^')
legend('Greedy Algorithm','Brute Force')
title('Greedy Algorithm vs Brute Force for Solving KFSS, Number of Sensor Locations')

clear t1 t2 n

t1 = NaN(N,1);
t2 = NaN(N,1);
p = 10;

for n=1:N
    [t1(n),t2(n)] = runtimes_helper(n,p,B);
end

figure(2)
plot(1:N,t1,'--s',1:N,t2,'--^')
legend('Greedy Algorithm','Brute Force')
title('Greedy Algorithm vs Brute Force for Solving KFSS, Size of A')
