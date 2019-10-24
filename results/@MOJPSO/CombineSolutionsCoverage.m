function newSolution = CombineSolutionsCoverage(mojpso,currentSolution,targetSolution)

if isequal(currentSolution.x,targetSolution.x) && isequal(currentSolution.y,targetSolution.y)
    % Both of the solutions are identical
    newSolution = currentSolution;
    return;
end

global RcValues RsValues gridPoints numberOfGridPoints
newSolution = mojpso.solutionStruct;

%% Move toward the target
dists = pdist2([currentSolution.x(1:end-1) currentSolution.y(1:end-1)],...
    [targetSolution.x(1:end-1) targetSolution.y(1:end-1)]);

% Find the nearest neighbor for each node in the solution from the target
% solution
[~,ind] = min(dists,[],2);

currentSolution.x(1:end-1) = currentSolution.x(1:end-1) + rand*(targetSolution.x(ind) - currentSolution.x(1:end-1));
currentSolution.y(1:end-1) = currentSolution.y(1:end-1) + rand*(targetSolution.y(ind) - currentSolution.y(1:end-1));

currentSolution.x = ceil(currentSolution.x);
currentSolution.y = ceil(currentSolution.y);

%% Choose sensors
% Merge the two solutions
x = [currentSolution.x(1:end-1);targetSolution.x];
y = [currentSolution.y(1:end-1);targetSolution.y];
Rs = [currentSolution.Rs targetSolution.Rs];
tempGridPoints = gridPoints;

toBeSearchedNode = length(x);
toBeChosenFrom = toBeSearchedNode;
toBeChosenFromDists = [];

chosenNodes = toBeSearchedNode;

while ~isempty(tempGridPoints)
    % Compute the distance between the selected node and the other nodes
    dists = pdist2([x(toBeSearchedNode) y(toBeSearchedNode)],[x y]);
    
    % Deteremine the sensors that can get access to the selected node
    ind = find(dists<RcValues(end));
    ind(ismember(ind,toBeChosenFrom)) = [];
    toBeChosenFrom = [toBeChosenFrom ind];
    toBeChosenFromDists = [toBeChosenFromDists ceil(dists(ind))];
    
    % Choose the node that achieves the maximum coverage
    tempArray = toBeChosenFrom;
    tempArray(ismember(tempArray,chosenNodes)) = [];
    dists = pdist2(tempGridPoints,[x(tempArray) y(tempArray)]);
    cond = dists<=repmat(Rs(tempArray),size(tempGridPoints,1),1);
    numberOfCoveredPoints = sum(cond,1);
    [~,ind] = max(numberOfCoveredPoints);
    toBeSearchedNode = tempArray(ind);
    chosenNodes = [chosenNodes toBeSearchedNode];
    
    % Remove the covered points
    tempGridPoints(cond(:,ind),:)=[];
end

chosenNodes(1) = [];
toBeChosenFrom(1) = [];

% Create the new solution
newSolution.x = [x(chosenNodes);x(end)];
newSolution.y = [y(chosenNodes);y(end)];
newSolution.numberOfSensors = length(newSolution.x)-1;

newSolution.Rc = zeros(1,newSolution.numberOfSensors);
for s=1:newSolution.numberOfSensors
    ind = find(toBeChosenFrom == chosenNodes(s));
    newSolution.Rc(s) = toBeChosenFromDists(ind);
end

[covered,RsiMin1] = ComputeMinimumRsi(newSolution,mojpso.lowerBounds(2),mojpso.higherBounds(2),RsValues(end));
RsiMin2 = Rs(chosenNodes);
if covered
    % The environment could be covered by the sensors using voronoi
    
    dists = pdist2(gridPoints,[newSolution.x(1:end-1) newSolution.y(1:end-1)]);
    summation = sum(dists <= repmat(RsiMin1,numberOfGridPoints,1),2);
    cost1 = length(find(summation>1))/numberOfGridPoints;
    
    
    dists = pdist2(gridPoints,[newSolution.x(1:end-1) newSolution.y(1:end-1)]);
    summation = sum(dists <= repmat(RsiMin2,numberOfGridPoints,1),2);
    cost2 = length(find(summation>1))/numberOfGridPoints;
    
    if cost1<cost2
        % Voronoi is better
        newSolution.Rs = RsiMin1;
    else
        % The old values of Rs are better
        newSolution.Rs = RsiMin2;
    end
else
    % The environment could not be covered by the sensors using voronoi
    % method
    newSolution.Rs = RsiMin2;
end

end