function costValues = ObjectiveFunction(solution)

global gridPoints numberOfGridPoints

%% The first function
costValues(1) = solution.numberOfSensors;

%% The second function
dists = pdist2(gridPoints,[solution.x(1:end-1) solution.y(1:end-1)]);
summation = sum(dists <= repmat(solution.Rs,numberOfGridPoints,1),2);
costValues(2) = length(find(summation>1))/numberOfGridPoints;

%% The third function
dists = pdist2([solution.x(end) solution.y(end)],[solution.x(1:end-1) solution.y(1:end-1)]);
dists(dists == 0) = 1;    % dist = 0 when a sensor randomly takes the coordinates of the sink 
tempVar = solution.Rc./dists;
costValues(3) = mean(tempVar)+std(tempVar);

end