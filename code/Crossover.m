function [ch1,ch2]=crossover(nsga3,p1,p2)
global sinkNodePosition RsValues RcValues

ch1 = nsga3.solutionStruct;
ch2 = nsga3.solutionStruct;
xValues = [p1.x;p2.x];
yValues = [p1.y;p2.y];
ch1Conect=false;
ch2Conect=false;
while(~ch1Conect)
    
    % Generate a random number of solutions
    numberOfSensors = randi([nsga3.lowerBounds(1) nsga3.upperBounds(1)]);
    ch1.numberOfSensors = numberOfSensors;
    % Generate randomly the x y coordinates
    randXIndices = randi(length(xValues),numberOfSensors,1);
    randYIndices = randi(length(yValues),numberOfSensors,1);
    ch1.x = [xValues(randXIndices);sinkNodePosition(1)];
    ch1.y = [yValues(randYIndices);sinkNodePosition(2)];
    
    % Generate the sensing range for each sensor
    [covered,RsiMin] = ComputeMinimumRsi(ch1,nsga3.lowerBounds(2),nsga3.upperBounds(2),RsValues(end));
    if covered
        % The environment could be covered by the sensors
        ch1.Rs = RsiMin;
    else
        % The environment could not be covered by the sensors
        continue;
    end
    
    % Generate the connectivity radius for each sensor
    [connected,RciMin] = ComputeMinimumRci(ch1,RcValues(end));
    if connected
        % The network is connected
        ch1.Rc = RciMin;
        ch1Conect = true;
    else
        % The network is not connected
        continue;
    end
end
while(~ch2Conect)
    
    % Generate a random number of solutions
    numberOfSensors = randi([nsga3.lowerBounds(1) nsga3.upperBounds(1)]);
    ch2.numberOfSensors = numberOfSensors;
    % Generate randomly the x y coordinates
    randXIndices = randi(length(xValues),numberOfSensors,1);
    randYIndices = randi(length(yValues),numberOfSensors,1);
    ch2.x = [xValues(randXIndices);sinkNodePosition(1)];
    ch2.y = [yValues(randYIndices);sinkNodePosition(2)];
    
    % Generate the sensing range for each sensor
    [covered,RsiMin] = ComputeMinimumRsi(ch2,nsga3.lowerBounds(2),nsga3.upperBounds(2),RsValues(end));
    if covered
        % The environment could be covered by the sensors
        ch2.Rs = RsiMin;
    else
        % The environment could not be covered by the sensors
        continue;
    end
    
    % Generate the connectivity radius for each sensor
    [connected,RciMin] = ComputeMinimumRci(ch2,RcValues(end));
    if connected
        % The network is connected
        ch2.Rc = RciMin;
        ch2Conect = true;
    else
        % The network is not connected
        continue;
    end
end