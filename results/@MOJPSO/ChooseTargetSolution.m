function targetSolution = ChooseTargetSolution(mojpso,paretoStruct)

% Assign a probability for each rank 
numberOfRanks = length(paretoStruct.paretoSet);
rankProbability = (numberOfRanks:-1:1)/sum(1:numberOfRanks);

% Choose randomly a rank according to the probabilities 
ind = find(rand<cumsum(rankProbability),1);

% Choose a random solution from the selected rank
targetSolution = paretoStruct.paretoSet{ind}(randi(paretoStruct.numberOfSolutions{ind}));

end