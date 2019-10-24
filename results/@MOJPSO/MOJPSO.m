classdef MOJPSO
    properties (SetAccess=private)
        solutionStruct            % The structure of the solution
        solutions                 % The population
        solutionsObjectiveValues; % Cost values of the solutions
        
        allSolutions;             % Contain the solutions of the whole iteration
        allObjectivesValues;      % Contain the solutions objectives values of the whole iteration
        
        numberOfSolutions         % Number of individuals in the population
        numberOfIterations        % Number of generations
        lowerBounds               % Lower Bounds
        higherBounds              % Higher Bounds
        globalPareto              % Global pareto front and pareto set
        localPareto               % Local pareto front and pareto set (of each solution)
        iterationPareto           % Iteration pareto front and pareto set (of the current generation)
        paretoStruct;             % The structure of paret solutions
        timeLag;                  % To determine how many generations back to compute pareto global
        
        c1;                       % Constant to direct the search process
        c2;                       % Constant to direct the search process
    end
    methods
        function mojpso = MOJPSO(numberOfSolutions,numberOfIterations,lowerBounds,higherBounds,solutionStruct,...
                c1,c2,timeLag)
            
            mojpso.solutionStruct = solutionStruct;
            mojpso.solutions = repmat(solutionStruct,numberOfSolutions,1);
            mojpso.numberOfSolutions = numberOfSolutions;
            mojpso.solutionsObjectiveValues = zeros(numberOfSolutions,3);
            mojpso.numberOfIterations = numberOfIterations;
            mojpso.lowerBounds = lowerBounds;
            mojpso.higherBounds = higherBounds;
            
            mojpso.paretoStruct = struct('paretoSet',[],'paretoFront',[],'numberOfSolutions',[]);
            mojpso.globalPareto = mojpso.paretoStruct;
            mojpso.localPareto = repmat(mojpso.paretoStruct,numberOfSolutions,1);
            mojpso.iterationPareto = mojpso.paretoStruct;
            mojpso.timeLag = timeLag;
            
            mojpso.c1 = c1;
            mojpso.c2 = c2;
            
        end
        mojpso = Initialization(mojpso);
        costValues = ObjectiveFunction(mojpso,ind)
        mojpso = CombineSolutionsCoverage(mojpso,sol1,sol2);
        mojpso = RunAlgorithm(mojpso);
    end
end