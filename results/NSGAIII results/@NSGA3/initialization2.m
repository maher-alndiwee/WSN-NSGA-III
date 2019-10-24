function nsga3=initialization(nsga3)

nsga3 = GenerateReferencePoints(nsga3);


nsga3.nCrossover = 2*round(nsga3.pCrossover*nsga3.numberOfSolutions/2); % Number of Parnets (Offsprings)

nsga3.nMutation = round(nsga3.pMutation*nsga3.numberOfSolutions);  % Number of Mutants
nsga3.sigma = 0.1*((nsga3.upperBoundsX+nsga3.upperBoundsX)/2-nsga3.lowerBounds); % Mutation Step Size


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
for i = 1:nsga3.numberOfSolutions
    nsga3.pop(i).Position.x = unifrnd(nsga3.lowerBounds,nsga3.upperBoundsX,[1,nsga3.dimensionOfSolution/2]);
    nsga3.pop(i).Position.x = [nsga3.pop(i).Position.x nsga3.upperBoundsX/2];   % adding the sink node
    nsga3.pop(i).Position.y = unifrnd(nsga3.lowerBounds,nsga3.upperBoundsY,[1,nsga3.dimensionOfSolution/2]);
    nsga3.pop(i).Position.y = [nsga3.pop(i).Position.y nsga3.upperBoundsY/2];    %adding the sink node
    nsga3.pop(i).Cost = CostFunction(nsga3.pop(i).Position);
end
% Sort Population and Perform Selection
[nsga3] = SortAndSelectPopulation(nsga3);

end