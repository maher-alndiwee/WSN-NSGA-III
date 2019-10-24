function diversity = Delta(paretoFront,extremSol1,extremSol2)
% This function is implementation for the Diversity metric
% Make sure to add the required condition according to the problem under
% study

numOfParetoSolutions = size(paretoFront,1);     % Number of pareto solutions

% Sort the pareto solutions fittness according to the first fitness values f1
[~,sortedInd] = sort(paretoFront(:,1));
sortedFitnessValues = paretoFront(sortedInd,:);

% Calculate the euclidean distance (di) between consecutive solutions
consecutiveDistances = zeros(1,numOfParetoSolutions-1);%;
for k = 1:numOfParetoSolutions-1
    consecutiveDistances(k) = pdist2(sortedFitnessValues(k,:) ,sortedFitnessValues(k+1,:));
end

% Calculate the average  of the consecutive distances
averageDistance = mean(consecutiveDistances);

% Calculate the euclidean distances between the extreme solutions and the boundary solutions
distanceL1 = pdist2(extremSol1,sortedFitnessValues(1,:));
distanceL2 = pdist2(extremSol1,sortedFitnessValues(end,:));
distanceL  = min(distanceL1,distanceL2);

distanceF1 = pdist2(extremSol2,sortedFitnessValues(1,:));
distanceF2 = pdist2(extremSol2,sortedFitnessValues(end,:));
distanceF  = min(distanceF1,distanceF2);

% Calculate Diversity metric , Apply equation (18)
diversity = (distanceL+distanceF+sum(abs(consecutiveDistances-averageDistance)))/...
    (distanceL+distanceF+(numOfParetoSolutions-1)*averageDistance);

end