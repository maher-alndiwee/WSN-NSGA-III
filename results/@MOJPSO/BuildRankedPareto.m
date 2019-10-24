function paretoStruct = BuildRankedPareto(mojpso,indices,oldPareto)

% Create a new pareto struct
paretoStruct = mojpso.paretoStruct;

% Get the solution set
solutions = mojpso.allSolutions(indices);
objectives = mojpso.allObjectivesValues(indices,:);

if ~isempty(oldPareto)
    % To save the elitism 
    solutions = [solutions;oldPareto.paretoSet{1}];
    objectives = [objectives;oldPareto.paretoFront{1}];
end

% Make sure that there is not redundant solutions
[objectives,ind] = unique(objectives,'rows','stable');
solutions = solutions(ind);

counter = 0;
while ~isempty(objectives)
    counter = counter + 1;
    
    % Determine the pareto set
    paretoIndices = DetermineParetoFront(objectives);
    paretoStruct.paretoSet{counter} = solutions(paretoIndices);
    paretoStruct.paretoFront{counter} = objectives(paretoIndices,:);
    paretoStruct.numberOfSolutions{counter} = length(paretoIndices);
    
    % Remove the upper rank solutions
    objectives(paretoIndices,:) = [];
    solutions(paretoIndices) = [];
end

end