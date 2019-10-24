function gd = GenerationalDistance(paretoFront,trueParetoFront,q)
% Convergence Metric.
% The Generational Distance (GD) metric.
% S_objs: objectives values correspond to optimal solution set.
% P_objs: objectives values correspond to P | where P: finite number of 
% non-dominated solutions that approximates the true PF.
% q usually equals to 2 

numOfSolsInS = size(paretoFront,1); % Number of solutions in S
di = zeros(1,numOfSolsInS);
for i = 1:numOfSolsInS
    di(i) = min(pdist2(paretoFront(i,:),trueParetoFront));
end

gd = (sum(di.^q)^(1/q))/numOfSolsInS;

end