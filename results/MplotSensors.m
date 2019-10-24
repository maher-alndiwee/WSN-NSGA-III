clc
clear all
close all
addpath('Evaluation Metrics/')
addpath('results/');
X=0;
Y=0;
strings=input('press :\n s to plot Rs \n c to plot Rc \n v to plot voronoi \n ','s');
for index=1:20
load(['WSD-NSGA-III_N_',num2str(index)]);
figure
Y=nsga3.paretoFront.solutions(1).y;
X=nsga3.paretoFront.solutions(1).x;
[vx,vy] = voronoi(X,Y);
X(end)=[];
Y(end)=[];

xlim([0 1000])
ylim([0 1000])
plot(X,Y,'b*','MarkerSize',7)
hold on 
plot(500,500,'r.','MarkerSize',25)
if (strcmp(strings,'s'))
Rss=Rsmax*ones(size(X,1),1);
viscircles([X,Y],Rss');
elseif (strcmp(strings,'c'))
    Rcc=Rcmax*ones(size(X,1),1);
viscircles([X,Y],Rcc')
elseif (strcmp(strings,'v'))
plot(vx,vy,'r-')
end
axis([0 1000 0 1000])
hold off
end


