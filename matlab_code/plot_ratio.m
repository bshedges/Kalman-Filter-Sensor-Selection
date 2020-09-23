
% We can make a heat map of the likelihood that our algorithm is optimal
% for sensor placement. 


n=4; %Size of our A matrix
L=25;% L is the number of times we check if our sensor selection is optimal
     % as L increases, the ratio from is_optimal should converge to one value
P=5; %P is the maximum number of sensors we can place. (runtime is very 
     % long if P>10 is chosen)
ratio = NaN(P);
pchooseB = NaN(P);

% Now we compute an approximation of the probability that the sensor
% selection is optimal based for a range 1:P. We also compute pchooseB at
% the same points to see the relationship between these plots.
    
tic;
for p=1:P
    for B=1:p-1
        ratio(p,B) = check_optimal(n,p,B,L);
        pchooseB(p,B) = nchoosek(p,B);
    end
    ratio(p,p) = 1;
    pchooseB(p,p) = 1;
end
time=toc;


% We now plot the figures. These plots outline what is perhaps obvious:
%   In general, as pchooseB increases (pchooseB represents the number of 
%   possible sensor combinations), the likelihood that the sensor selection
%   we get from our algorithm decreases.

% Plots

% Undocument the following code if you want to see the plots individually

% figure(1)
% surf(1:P,1:P,ratio)
% colorbar
% title('Likelihood That Algorithm 1 Gives Optimal Sensor Location')
% ylabel('Possible Sensor Locations')
% xlabel('Chosen Sensor Locations')
% shading interp
% view(2);
% 
% 
% figure(2)
% surf(1:P,1:P,pchooseB)
% colorbar
% title('n choose k')
% ylabel('n')
% ylim([1,P])
% xlabel('k')
% xlim([1,P])
% shading interp
% view(2);

% Since we are taking few discrete points (and since we arent approximating
% something continuous, it might make more sense to look at a discrete mesh
% instead of a surface. Unfortunately, this type of plot is much harder to
% read. Nonetheless, we will plot meshes as well

% figure(3)
% mesh(1:P,1:P,ratio)
% colorbar
% title('Likelihood That Algorithm 1 Gives Optimal Sensor Location')
% ylabel('Possible Sensor Locations')
% xlabel('Chosen Sensor Locations')
% shading interp
% view(2);
% 
% figure(4)
% mesh(1:P,1:P,pchooseB)
% colorbar
% title('n choose k')
% ylabel('n')
% ylim([1,P])
% xlabel('k')
% xlim([1,P])
% shading interp
% view(2);

% Now we can plot all four on the same plot for easy comparison

gcf = figure(5);
hold on
subplot(2,2,1)
surf(1:P,1:P,ratio)
colorbar
title('Likelihood That Algorithm 1 Gives Optimal Sensor Location')
ylabel('Possible Sensor Locations')
xlabel('Chosen Sensor Locations')
shading interp
view(2);

subplot(2,2,2)
surf(1:P,1:P,pchooseB)
colorbar
title('n choose k')
ylabel('n')
ylim([1,P])
xlabel('k')
xlim([1,P])
shading interp
view(2);

subplot(2,2,3)
mesh(1:P,1:P,ratio)
colorbar
ylabel('Possible Sensor Locations')
xlabel('Chosen Sensor Locations')
shading interp
view(2);

subplot(2,2,4)
mesh(1:P,1:P,pchooseB)
colorbar
ylabel('n')
ylim([1,P])
xlabel('k')
xlim([1,P])
shading interp
view(2);
hold off

set(gcf, 'Position',  [100, 100, 900, 600])
        