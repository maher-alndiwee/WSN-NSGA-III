clc
clear all
close all
addpath([pwd '\Evaluation Metrics'])
Hyper=[];
NumofNDS=[];
DeltaM=[];
for index=1:10
figure
load(['WSD-NSGA-III_N_' num2str(index)]);
paretoFrontnsga3=nsga3.paretoFront.solutionsObjectiveValues;
load(['result index' num2str(index)]);
paretoFrontmojpso=mojpso.globalPareto.paretoFront{1};
load(['NSGAII1000-' num2str(index)]);
paretoFrontnsga2=paretoFront.solutionsObjectiveValues;

hyperVolume = HyperVolume(paretoFrontnsga3);
hyperVolumemojpso = HyperVolume(paretoFrontmojpso);
hyperVolumensga2 = HyperVolume(paretoFrontnsga2);

delta = DeltaQuotMetric(paretoFrontnsga3);
deltamojpso = DeltaQuotMetric(paretoFrontmojpso);
deltansga2 = DeltaQuotMetric(paretoFrontnsga2);
% Find set Coverage from  nsga to moga {Capacity metric}
   setCoverage(index,1) = SetCoverage2(paretoFrontnsga2,paretoFrontmojpso);
   setCoverage(index,2) = SetCoverage2(paretoFrontmojpso,paretoFrontnsga2);

    % Find set Coverage from  moga to nsga {Capacity metric}
   setCoverage(index,3) = SetCoverage2(paretoFrontnsga2,paretoFrontnsga3) ;
   setCoverage(index,4) = SetCoverage2(paretoFrontnsga3,paretoFrontnsga2) ;

    
    setCoverage(index,5) = SetCoverage2(paretoFrontmojpso,paretoFrontnsga3);
    setCoverage(index,6) = SetCoverage2(paretoFrontnsga3,paretoFrontmojpso);
    
NumofNDS=[NumofNDS [length(paretoFrontnsga3);length(paretoFrontmojpso);length(paretoFrontnsga2)]];
Hyper=[Hyper [hyperVolume;hyperVolumemojpso;hyperVolumensga2]];
DeltaM=[DeltaM [delta;deltamojpso;deltansga2]];

%numberOfSensors=[numberOfSensors]; % Added




plot3(paretoFrontnsga3(:,1),paretoFrontnsga3(:,2),paretoFrontnsga3(:,3),'*g',...
    'LineWidth',1.5)
hold on 

plot3(paretoFrontmojpso(:,1),paretoFrontmojpso(:,2),paretoFrontmojpso(:,3),'ob',...
    'LineWidth',1.5)
plot3(paretoFrontnsga2(:,1),paretoFrontnsga2(:,2),paretoFrontnsga2(:,3),'+k',...
    'LineWidth',1.5)
%x=paretoFront(:,1);
%y=paretoFront(:,2);

%plot(x,y,'*','LineWidth',1.5)
grid
xlabel('Number Of Sensors','LineWidth',1,'FontWeight','bold','FontSize',14)
ylabel('Power Consumption','LineWidth',1,'FontWeight','bold','FontSize',14)
zlabel('Network Congestion','LineWidth',1,'FontWeight','bold','FontSize',14)
%axis([0 100 0 1])
%axis([0 100 0 1 0 1])
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11) 

end
avrHyper =mean(Hyper,2);
avrDelta = mean(DeltaM,2);
avrNumOfNDS = mean(NumofNDS,2);
avrSetCoverage=mean(setCoverage);
figure 
bar(NumofNDS')
xlabel('Configuration','LineWidth',1,'FontWeight','bold','FontSize',14)
ylabel('NDS','LineWidth',1,'FontWeight','bold','FontSize',14)
xlim([0 11]);
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11) 

figure 
bar(Hyper')
xlabel('Configuration','LineWidth',1,'FontWeight','bold','FontSize',14)
ylabel('Hyper Volume','LineWidth',1,'FontWeight','bold','FontSize',14)
xlim([0 11]);
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11) 

figure 
bar(DeltaM')
xlim([0 11]);
xlabel('Configuration')
ylabel('Delta')
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11) 
figure 
set(axes,'XTick',zeros(1,0),'XTickLabel',{});
coloredBar(avrNumOfNDS')
xlabel('Method','LineWidth',1,'FontWeight','bold','FontSize',14);
ylabel(' Average Of NDS','LineWidth',1,'FontWeight','bold','FontSize',14)
xlim([0 4]);
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11)
figure 
set(axes,'XTick',zeros(1,0),'XTickLabel',{});
coloredBar(avrHyper')
xlabel('Method','LineWidth',1,'FontWeight','bold','FontSize',14);
ylabel(' Average Of HyperVolume','LineWidth',1,'FontWeight','bold','FontSize',14)
xlim([0 4]);
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11)

figure 
coloredBar(avrDelta')
xlim([0 4]);
xlabel('Method','LineWidth',1,'FontWeight','bold','FontSize',14)
ylabel('Average Of Delta','LineWidth',1,'FontWeight','bold','FontSize',14)
legend({'NSGAIII','MOJPSO','NSGAII'},'FontWeight','bold','FontSize',11) 
figure 
set(axes,'XTick',zeros(1,0),'XTickLabel',{});
coloredBar(avrSetCoverage)
xlim([0 7]);
ylim([0 1]);
xlabel('Method','LineWidth',1,'FontWeight','bold','FontSize',14);
ylabel(' Average Of Set Coverage','LineWidth',1,'FontWeight','bold','FontSize',14);
legend({'NSGAII to mojpso','MOJPSO to NSGAII','NSGAII to NSGAIII','NSGAIII to NSGAII','MOJPSO to NSGAIII','NSGAIII to MOJPSO'},'FontWeight','bold','FontSize',11)
% Print numberOfSensors
%figure 
%bar(numberOfSensors)
%xlabel('Configuration')
%ylabel('numberOfSensors')

% Print elapsedTime
%figure 
%bar(toc)
%xlabel('Configuration')
%ylabel('elapsedTime')


