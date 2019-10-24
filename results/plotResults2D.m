clc
clear all
close all
addpath([pwd '\Evaluation Metrics'])
Hyper=[];
NumofNDS=[];
DeltaM=[];
for index=1:20
figure
load(['WSD-NSGA-III_N_' num2str(index)]);
paretoFront=nsga3.paretoFront.solutionsObjectiveValues;

hyperVolume = HyperVolume(paretoFront);

delta = DeltaQuotMetric(paretoFront);

NumofNDS=[NumofNDS length(paretoFront)];
Hyper=[Hyper hyperVolume];
DeltaM=[DeltaM delta];

%numberOfSensors=[numberOfSensors]; % Added

%plot3(paretoFront(:,1),paretoFront(:,2),paretoFront(:,3),'*',...
%    'LineWidth',1.5)

x=paretoFront(:,1);
y=paretoFront(:,2);

plot(x,y,'*','LineWidth',1.5)
grid
xlabel('objective 1')
ylabel('obejctive 2')
%zlabel('objective 3')
axis([0 100 0 1])
%axis([0 100 0 1 0 1])

end


figure 
bar(NumofNDS)
xlabel('configuration')
ylabel('NDS')

figure 
bar(Hyper)
xlabel('configuration')
ylabel('hyper volume')

figure 
bar(DeltaM)
xlabel('configuration')
ylabel('Delta')

% Print numberOfSensors
%figure 
%bar(numberOfSensors)
%xlabel('configuration')
%ylabel('numberOfSensors')

% Print elapsedTime
%figure 
%bar(toc)
%xlabel('configuration')
%ylabel('elapsedTime')


