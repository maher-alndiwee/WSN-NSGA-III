function mojpso = Initialization(mojpso)

global xValues yValues sinkNodePosition
global RsValues RcValues

counter = 0;
while counter<mojpso.numberOfSolutions
    
    % Initialize the solution
    solution = mojpso.solutionStruct;
    
    % Generate a random number of solutions
    numberOfSensors = randi([mojpso.lowerBounds(1) mojpso.higherBounds(1)]);
    solution.numberOfSensors = numberOfSensors;
    
    % Generate randomly the x y coordinates
    randXIndices = randi(length(xValues),numberOfSensors,1);
    randYIndices = randi(length(yValues),numberOfSensors,1);
    solution.x = [xValues(randXIndices);sinkNodePosition(1)];
    solution.y = [yValues(randYIndices);sinkNodePosition(2)];
    
    % Generate the sensing range for each sensor
    [covered,RsiMin] = ComputeMinimumRsi(solution,mojpso.lowerBounds(2),mojpso.higherBounds(2),RsValues(end));
    if covered
        % The environment could be covered by the sensors
        solution.Rs = RsiMin;
    else
        % The environment could not be covered by the sensors
        continue;
    end
    
    % Generate the connectivity radius for each sensor
    [connected,RciMin] = ComputeMinimumRci(solution,RcValues(end));
    if connected
        % The network is connected
        solution.Rc = RciMin;
    else
        % The network is not connected
        continue;
    end
    
    % Add the new solution
    counter = counter + 1;
    mojpso.solutions(counter) = solution;
    GeneralTest(solution)
    
    % Evaluate the solution
    costValues = ObjectiveFunction(mojpso,counter);
    mojpso.solutionsObjectiveValues(counter,:) = costValues;
    mojpso.localPareto(counter).paretoSet{1} = mojpso.solutions(counter);
    mojpso.localPareto(counter).paretoFront{1} = costValues;
    mojpso.localPareto(counter).numberOfSolutions{1} = 1;

end

end