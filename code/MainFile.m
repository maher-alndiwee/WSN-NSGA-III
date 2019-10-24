clc
close all
for seed =3 : 3
    
    rng(seed);
global xValues yValues RsValues RcValues regionOfInterest  sinkNodePosition gridPoints numberOfGridPoints
    
   %% Problem parameters
regionOfInterest = 1000;                             % Size of the region of interest [m m]
regionResolution = 1;                                % Step of x and y coordinates
xValues = (0:regionResolution:regionOfInterest)';    % Range of x values
yValues = (0:regionResolution:regionOfInterest)';    % Range of y values
sinkNodePosition = (regionOfInterest/2)*ones(1,2);   % Position of the sink node

Rsmin = 1;                                           % The minimum value of sensing range
Rsmax = 200;                                         % The maximum value of sensing range
RsResolution = 1;                                    % Rs step
RsValues = Rsmin:RsResolution:Rsmax;                 % Range of Rs values

Rcmin = 1;                                           % The minimum value of connectivity range
Rcmax = 150;                                         % The maximum value of connectivity range
RcResolution = 1;                                    % Rc step
RcValues = Rcmin:RcResolution:Rcmax;                 % Range of Rc values

nMin = ceil((regionOfInterest(1)^2)/(pi*Rsmax^2));   % Minimum number of sensors
nMax = 100;        % maximum Number of sensors
%% Initialize grid points
numberOfGridPoints = 100;                            % Number of grid points per coordinate
x = linspace (0,regionOfInterest,numberOfGridPoints);
y = linspace (0,regionOfInterest,numberOfGridPoints);
[x,y] = meshgrid(x,y);
gridPoints=[x(:) y(:)];                              % The set of grid points
numberOfGridPoints=size(gridPoints,1);               % Number of grid points in the environment

    %% Approach definition
    lowerBounds = [nMin 0 0 Rsmin Rcmin];                                 % Variables are [nmin xmin ymin Rsmin Rcmin]
upperBounds = [nMax regionOfInterest regionOfInterest Rsmax Rcmax];  % Variables are [nmax xmax ymax Rsmax Rcmax]
solutionStruct = struct('numberOfSensors',[],'x',[],'y',[],'Rs',[],'Rc',[]);
    
    numberOfObjectives = 3;
    nVar = 2;    % Number of Decision Variables
    VarSize = [1 nVar]; % Size of Decision Variables Matrix
    %% NSGA III parameters
%     numberOfSolutions = 10;                         % Number Of Solutions
%     %dimensionOfSolution = 50;         % Dimension Of Solution
%     numberOfIterations = 5;                        % Number Of Iterations
%     nDivision =10;       %number of divisions to generate refrenc points
%     pCrossover = 0.5;       % Crossover Percentage
%     pMutation = 0.5;       % Mutation Percentage
%     mutationRate =0.1;  %.02;     % Mutation Rate
    %% NSGA III calling
    nsga3 =NSGA3(VarSize,nDivision,numberOfSolutions,numberOfObjectives, ...
        numberOfIterations,lowerBounds,upperBounds,pCrossover,pMutation,...
        mutationRate,solutionStruct);
    
    nsga3=RunAlgorithm(nsga3);
    computationTime = nsga3.computationTime;
    paretoFront.solutions = nsga3.paretoFront.solutions;
    paretoFront.solutionsObjectiveValues = nsga3.paretoFront.solutionsObjectiveValues ;
    
   
    toc;
end