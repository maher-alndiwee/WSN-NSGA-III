function lifetimeRatio=Life(solution)
% This function is implementation for lifetime evaluatoion

global initialEnergy beta alpha amp numberOfSensors

route = cell(1,numberOfSensors);
distanceToNextNode = zeros(1,numberOfSensors);
shortestRouteToTheSink = zeros(1,numberOfSensors);

% Calculate distances between nodes
adjacency = AdjacencyMatrix(solution);
networkTopology = graph(adjacency);
distances = CalculateDistances(solution,networkTopology);

% Step 1: set the initial energy for each sensor node
nodeEnergy = initialEnergy*ones(1,numberOfSensors);

% Calculate the minimum distance
minimumDistance =  min(distances(:));

% Step 2: Calculate the minimum transmit energy per bit
minimumTransmitPower = beta*minimumDistance^alpha*amp;

% Step 3: Calculate the possible maximum number of sensing cycles
Tmax = floor(initialEnergy/minimumTransmitPower);

% Calculate the shortest route to sink node
sinkNodeInd = find(solution.x==500);
sensorsInd = [1:sinkNodeInd-1,sinkNodeInd+1:numberOfSensors+1];
for sen = 1:numberOfSensors
    [route{sen} ,shortestRouteToTheSink(sen)] = shortestpath(networkTopology,sensorsInd(sen),sinkNodeInd,'Method','positive');
end

% Calculate the Traffic Load due to node level with sink
maxRouteLength = max(shortestRouteToTheSink);
trafficLoad = maxRouteLength+1-shortestRouteToTheSink;

% Calculate the distance from each node to the next node
for sen = 1:numberOfSensors
    if shortestRouteToTheSink(sen)>1
        % Distance to the next node is the average distance of route
        neighborsDistance = distances(sen,distances(sen,:)~=inf);
        distanceToNextNode(sen) = mean(neighborsDistance);
    else
        % Distance to Sink is the direct distance of route
        distanceToNextNode(sen) = distances(sensorsInd(sen),sinkNodeInd);
    end
end

% Calculate the transmit energy , see equation (5)
transmitPower =  beta*trafficLoad.*distanceToNextNode.^alpha*amp;

% Calculate the minimum number of sensing cycles, T_failure
Tfailure = min(floor(nodeEnergy./transmitPower));

% Step 6: set life time to the ratio of the time until one of the sensor nodes runs
% out of energy , see equation (4)
lifetimeRatio= 1-(Tfailure/Tmax);

end
