function nsga3 = initialization(nsga3)

global xValues yValues sinkNodePosition
global RsValues RcValues
nsga3 = GenerateReferencePoints(nsga3);


nsga3.nCrossover = 2*round(nsga3.pCrossover*nsga3.numberOfSolutions/2); % Number of Parnets (Offsprings)

nsga3.nMutation = round(nsga3.pMutation*nsga3.numberOfSolutions);  % Number of Mutants
nsga3.sigma = 0.1*(nsga3.upperBounds(2)-nsga3.lowerBounds(2)); % Mutation Step Size


%% Colect Parameters

nsga3.params.nPop = nsga3.numberOfSolutions;
nsga3.params.Zr = nsga3.Zr;
nsga3.params.nZr = size(nsga3.Zr,2);
nsga3.params.zmin = [];
nsga3.params.zmax = [];
nsga3.params.smin = [];


%% Initialization

disp('Staring NSGA-III ...');

nsga3.empty_individual.Position = [];
nsga3.empty_individual.Cost = [];
nsga3.empty_individual.Rank = [];
nsga3.empty_individual.DominationSet = [];
nsga3.empty_individual.DominatedCount = [];
nsga3.empty_individual.NormalizedCost = [];
nsga3.empty_individual.AssociatedRef = [];
nsga3.empty_individual.DistanceToAssociatedRef = [];

nsga3.pop = repmat(nsga3.empty_individual, nsga3.numberOfSolutions, 1);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter = 0;
while counter<nsga3.numberOfSolutions
    
    % Initialize the solution
    solution = nsga3.solutionStruct;
    
    % Generate a random number of solutions
    numberOfSensors = randi([nsga3.lowerBounds(1) nsga3.upperBounds(1)]);
    solution.numberOfSensors = numberOfSensors;
    
    % Generate randomly the x y coordinates
    randXIndices = randi(length(xValues),numberOfSensors,1);
    randYIndices = randi(length(yValues),numberOfSensors,1);
    solution.x = [xValues(randXIndices);sinkNodePosition(1)];
    solution.y = [yValues(randYIndices);sinkNodePosition(2)];
    
    % Generate the sensing range for each sensor
    [covered,RsiMin] = ComputeMinimumRsi(solution,nsga3.lowerBounds(2),nsga3.upperBounds(2),RsValues(end));
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
    nsga3.pop(counter).Position = solution;
   % GeneralTest(solution)
    % Evaluate the solution
    costValues = ObjectiveFunction(solution);
    nsga3.pop(counter).Cost = costValues';

end
% Determine Domination
[nsga3] = SortAndSelectPopulation(nsga3);


end
