function nsga = RunAlgorithm(nsga)

% Generate initial population

%% Initialize population
startTime = cputime;
disp('Initialization ...')

nsga = Initialization(nsga);

% Evaluate initial population
disp('Evaluation ... ')
for i=1:nsga.numberOfSolutions
    % Coverage Evaluation
    nsga.solutionsObjectiveValues(i,1)= Coverage(nsga.solutions(i).geometrySolution);
    
    % Lifetime evaluation
    nsga.solutionsObjectiveValues(i,2)= Life(nsga.solutions(i).geometrySolution);
end

% Do fast non-dominated sort
nsga = FastNonDominatedSort(nsga);

% Iteration Loop
for iter = 1:nsga.numberOfIterations
    
    % Update current iteration
    nsga.currentIteration = iter;
    clc
    % Display the number of generation
    disp(['Iteration: ' num2str(nsga.currentIteration)]);
    
    % Apply selection operator
    disp('selection ...')
    newPopulation = nsga_SelectionOperator(nsga);
    
    % Crossover for new population
    disp('Crossover ...')
    for j=1:nsga.numberOfSolutions/2
        
        if rand<=nsga.crossoverRate
            [newPopulation(2*j-1),newPopulation(2*j)] = Crossover(nsga,newPopulation(2*j-1),newPopulation(2*j));
        else
            newPopulation(2*j-1) = newPopulation(2*j-1);
            newPopulation(2*j) = newPopulation(2*j);
        end
        %         TestFunction(newPopulation(2*j-1));
        %         TestFunction(newPopulation(2*j));
    end
    
    % Mutation for new population
    disp('Mutation ...')
    for j=1:nsga.numberOfSolutions
        newPopulation(j) = Mutation(nsga,newPopulation(j));
        %        TestFunction(newPopulation(j));
    end
    
    
    % Evaluate new population
    newSolsObjectiveValues = zeros(nsga.numberOfSolutions,nsga.numberOfObjectives);
    disp('Evaluation ... ')
    for i=1:nsga.numberOfSolutions
        % Coverage evaluation
        newSolsObjectiveValues(i,1) = Coverage(newPopulation(i).geometrySolution);
        % Lifetime evaluation
        newSolsObjectiveValues(i,2) = Life(newPopulation(i).geometrySolution);
    end
    
    
    % Combine the new population and old population
    nsga.numberOfSolutions = nsga.numberOfSolutions*2;
    nsga.solutions = [nsga.solutions ; newPopulation];
    nsga.solutionsObjectiveValues = [nsga.solutionsObjectiveValues ; newSolsObjectiveValues];
    
    % Do fast non-dominated sort
    nsga = FastNonDominatedSort(nsga);
    
    % Extract the next population
    nsga = ExtractNextPopulation(nsga);
    
    % Plot the extracted generation
    % PlotRankedParetoFronts(nsga);
end

endTime = cputime;
nsga.computationTime = endTime-startTime;
% Return pareto front with rank 1
indices = nsga.solutionsRank==1;
nsga.paretoFront.solutions = nsga.solutions(indices);
nsga.paretoFront.solutionsObjectiveValues = nsga.solutionsObjectiveValues(indices,:);
end