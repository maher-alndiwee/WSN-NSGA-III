function mojpso = RunAlgorithm(mojpso)


% Initialize the first generation
mojpso = Initialization(mojpso);

mojpso.allSolutions = mojpso.solutions;
mojpso.allObjectivesValues = mojpso.solutionsObjectiveValues;

% Determine the global pareto front
mojpso.globalPareto = BuildRankedPareto(mojpso,1:mojpso.numberOfSolutions,[]);

% Determine the current iteration pareto front
mojpso.iterationPareto = mojpso.globalPareto;

for t = 1:mojpso.numberOfIterations
    clc
    t
    for k = 1:mojpso.numberOfSolutions
        randNum = rand;
        if randNum < mojpso.c1
            % Choose a solution from the global pareto front
            targetSolution = ChooseTargetSolution(mojpso,mojpso.globalPareto);
        elseif randNum > mojpso.c2
            % Choose a solution from the local pareto front
            targetSolution = ChooseTargetSolution(mojpso,mojpso.localPareto(k));
        else
            % Choose a solution from the iteration pareto front
            targetSolution = ChooseTargetSolution(mojpso,mojpso.iterationPareto);
        end
        
        % Update the solution
        mojpso.solutions(k) = CombineSolutionsCoverage(mojpso,mojpso.solutions(k),targetSolution);
        %GeneralTest(mojpso.solutions(k))
        % Evaluate the solution
        mojpso.solutionsObjectiveValues(k,:) = ObjectiveFunction(mojpso,k);
        
        % Add the solution to the whole solutions set
        mojpso.allSolutions = [mojpso.allSolutions;mojpso.solutions(k)];
        mojpso.allObjectivesValues = [mojpso.allObjectivesValues;mojpso.solutionsObjectiveValues(k,:)];
        
        % Update the local pareto front
        indices = find(mod(1:length(mojpso.allSolutions),mojpso.numberOfSolutions)==k);
        if isempty(indices)
            % Empty when mod return 0 value
            indices = find(mod(1:length(mojpso.allSolutions),mojpso.numberOfSolutions)==0);
        end
        mojpso.localPareto(k) = BuildRankedPareto(mojpso,indices,[]);
    end
    
    % Update the current iteration pareto front
    indices = t*mojpso.numberOfSolutions+1:(t+1)*mojpso.numberOfSolutions;
    mojpso.iterationPareto = BuildRankedPareto(mojpso,indices,[]);
    
    % Update the global pareto front
    backGeneration = max(t-mojpso.timeLag+2,1);
    indices = (backGeneration-1)*mojpso.numberOfSolutions+1:(t+1)*mojpso.numberOfSolutions;
    mojpso.globalPareto = BuildRankedPareto(mojpso,indices,mojpso.globalPareto);
end

end