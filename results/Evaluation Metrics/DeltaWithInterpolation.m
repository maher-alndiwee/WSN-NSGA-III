function diversity = DeltaWithInterpolation(paretoFront,f1max,f2max)
% This function is implementation for the Diversity metric
% Make sure to add the required condition according to the problem under
% study

numOfParetoSolutions = size(paretoFront,1);     % Number of pareto solutions

% Sort the pareto solutions fittness according to the first fitness values f1
[~,sortedInd] = sort(paretoFront(:,1));
sortedFitnessValues = paretoFront(sortedInd,:);

% Calculate the euclidean distance (di) between consecutive solutions
distance = pdist2(sortedFitnessValues(1:end-1,:) ,sortedFitnessValues(2:end,:));
consecutiveDistances = diag(distance) ;

% Calculate the average  of the consecutive distances
averageDistance = mean(consecutiveDistances);

% Extreme solutions
ft = fittype('poly2');

fitresult1 = fit( sortedFitnessValues(:,1), sortedFitnessValues(:,2), ft );   % sortedFitnessValues1 represents x data
extremeSolution1(1) = f1max;
extremeSolution1(2) = fitresult1(f1max);

fitresult2 = fit( sortedFitnessValues(:,2), sortedFitnessValues(:,1), ft );   % sortedFitnessValues2 represents x data
extremeSolution2(2) = f2max;
extremeSolution2(1) = fitresult2(f2max);

% Calculate the euclidean distances between the extreme solutions and the boundary solutions
distanceL = pdist2(extremeSolution1,sortedFitnessValues(end,:));
distanceF = pdist2(extremeSolution2,sortedFitnessValues(1,:));

% Calculate Diversity metric , Apply equation (18)
diversity = (distanceL+distanceF+sum(abs(consecutiveDistances-averageDistance)))/...
    (distanceL+distanceF+(numOfParetoSolutions-1)*averageDistance);

end