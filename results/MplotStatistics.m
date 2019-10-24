clc
clear all
close all
addpath('Evaluation Metrics/')
addpath('results/');
X=0;
Y=0;
for index=1:20
load(['WSD-NSGA-III_N_',num2str(index)]);

NoS(index)=nsga3.paretoFront.solutions(1).numberOfSensors;
ToE(index)=ExecutionTime;
end
figure 
hold on
title('number of sensor for each configration');
set(gca,'Xlim',[0,21],'XTick',[1:20]);
bar(NoS)
xlabel('configration');
ylabel('number of sensors');
hold off

figure
hold on 
title('Execution time for each configuration')
set(gca,'Xlim',[0,21],'XTick',[1:20]);
bar(ToE)
xlabel('Configuration')
ylabel('Execution time [sec]')
hold off
