classdef NSGA3
    
    properties (SetAccess = private)
        VarSize;
        nDivision;                  %number of divisions
        Zr;                         %refernce points
        pCrossover;                 % Crossover Percentage
        pMutation;                  % Mutation Percentage
        nCrossover;                 % Number of Parnets (Offsprings)
        nMutation;                  % Number of Mutants
        sigma;                      % Mutation Step Size
        numberOfSolutions;        % Number of individuals in the population
        numberOfObjectives;       % Number of objectives
        solutionsObjectiveValues; % Cost values of the solutions
        numberOfIterations;       % Number of generations
        lowerBounds;              % Lower Bounds
        upperBoundsX;              % Higher Bounds X
         upperBoundsY;              % Higher Bounds Y
        crossoverRate;
        mutationRate;
        params;                    % parameters
        currentIteration;         % Number of current iteration
        computationTime;           % Computation time
        dimensionOfSolution;
        paretoFront;
        F;                        %
        pop;                      %population 
        empty_individual;
    end
    methods
        function nsga3 = NSGA3(VarSize,nDivision,numberOfSolutions,numberOfObjectives, ...
                numberOfIterations,lowerBounds,upperBoundsX,upperBoundsY,pCrossover,pMutation,mutationRate,dimensionOfSolution)
           nsga3.VarSize=VarSize;
            nsga3.nDivision=nDivision;
            nsga3.numberOfSolutions=numberOfSolutions;
            nsga3.dimensionOfSolution=dimensionOfSolution;
            nsga3.numberOfSolutions = numberOfSolutions;
            nsga3.numberOfObjectives = numberOfObjectives;
            nsga3.numberOfIterations = numberOfIterations;
            nsga3.lowerBounds = lowerBounds;
            nsga3.upperBoundsX = upperBoundsX;
            nsga3.upperBoundsY = upperBoundsY;
            nsga3.pCrossover=pCrossover;
            nsga3.pMutation=pMutation;
            nsga3.mutationRate = mutationRate;
            
        end
        paretoFront = RunAlgorithm(nsga3,ObjectiveFunction);
        nsga3=initlazation(nsga3);
        nsga3 = GenerateReferencePoints(nsga3);
% %         state = IsDominant(nsga3,solution1ObjValues,solution2ObjValues);
% %         nsga = FastNonDominatedSort(nsga);
% %         dominationMatrix = CalculateDominationMatrix(nsga);
% %         dominationInfo = FindDominationInfo(nsga,dominationMatrix);
% %         [front,nsga] = FindRankedParetoFronts(nsga,dominationInfo);
% %         nsga = CalculateCrowdingDistance(nsga,front);
% %         newPopulation = nsga_SelectionOperator(nsga);
% %         [child1,child2] = Crossover(nsga,parent1,parent2);
% %         newPopulation = Mutation(nsga,solution);
% %         nsga = ExtractNextPopulation(nsga);
% %         individual = CheckBounds(nsga,individual);
% %         PlotRankedParetoFronts(nsga);
% %         
    end
end