function nsga3 = RunAlgorithm(nsga3)
startTime = cputime;
disp('Initialization ...')

nsga3=initialization(nsga3);
%% NSGA-III Main Loop

for it = 1:nsga3.numberOfIterations
 
    % Crossover
    popc = repmat(nsga3.empty_individual, nsga3.nCrossover/2, 2);
    for k = 1:nsga3.nCrossover/2

        i1 = randi([1 nsga3.numberOfSolutions]);
        p1 = nsga3.pop(i1);

        i2 = randi([1 nsga3.numberOfSolutions]);
        p2 = nsga3.pop(i2);

        [popc(k, 1).Position, popc(k, 2).Position] = Crossover(p1.Position, p2.Position);

        popc(k, 1).Cost = CostFunction(popc(k, 1).Position);
        popc(k, 2).Cost = CostFunction(popc(k, 2).Position);

    end
    popc = popc(:);

    % Mutation
    popm = repmat(nsga3.empty_individual, nsga3.nMutation, 1);
    for k = 1:nsga3.nMutation

        i = randi([1 nsga3.numberOfSolutions]);
        p = nsga3.pop(i);

        popm(k).Position = Mutate(p.Position, nsga3.mutationRate, nsga3.sigma);

        popm(k).Cost = CostFunction(popm(k).Position);

    end

    % Merge
    nsga3.pop = [nsga3.pop
           popc
           popm]; 
    
    % Sort Population and Perform Selection
    [nsga3] = SortAndSelectPopulation(nsga3);
    
    % Store paretoFront
    for idx = 1:numel(nsga3.F{1})
    nsga3.paretoFront.solutions(idx)  = nsga3.pop(nsga3.F{1}(idx)).Position;
    nsga3.paretoFront.solutionsObjectiveValues(idx,:) = nsga3.pop(nsga3.F{1}(idx)).Cost;
    end
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of paretoFront Members = ' num2str(numel(nsga3.F{1}))]);

    % Plot F1 Costs
    % figure(1);
    % PlotCosts(nsga3.paretoFront);
    % pause(0.01);
 
end

%% Results

disp(['Final Iteration: Number of F1 Members = ' num2str(numel(nsga3.paretoFront))]);
disp('Optimization Terminated.');
endTime = cputime;
nsga3.computationTime = endTime-startTime;


