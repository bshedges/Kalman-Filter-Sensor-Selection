Bradley Hedges
20555403


This document will outline what code to run and how to run it

I recommend starting with the script 'runme.m' and setting k = [1] only. This will run the function Priori KFSS (which is the algorithm outlined in my paper), and compares it against the actual optimal sensor combination according to our metric of minimum error covariance. For an explanation of what PriKFSS does, open that function next.

Next I recommend running 'runtimesPriPost.m'. This script runs my priori and posteriori algorithms against each other. Technically they are of the same order and should converge at the same rates. They do not, because I was unable to code PostKFSS as efficiently as PriKFSS. PriKFSS requires one to use Matlab function DARE, and PostKFSS requires one to make a script to solve a system similar to DARE.

After that, run 'plot_ratio.m'. Documentation for what the code does is written in it.

Next, go back to the 'runme.m' file. Choose k = [1,2]. This actually runs the Kalman filter with the greedy sensor placement found by PriKFSS, as well as the actual optimal sensor placement (they might be the same).

For further analysis, run 'Kalman_Filter_Compare.m'. It explains how it works.

Everything else is a helper function