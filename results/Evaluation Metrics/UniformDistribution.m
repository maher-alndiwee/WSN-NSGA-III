function ud = UniformDistribution(paretoFront,segma)
% Diversity Metrics.
% Distribution in diversity metrics.
% Uniform Distribution (UD) metric.
% S: optimal solution set.
% segma: niche radius.

numOfSolsInS = size(paretoFront,1); % Number of solutions in S
nc = zeros(1,numOfSolsInS);
for i = 1:numOfSolsInS
    tempS = paretoFront; tempS(i,:) = [];
    dists = pdist2(paretoFront(i,:),tempS);
    nc(i) = length(find(dists<segma));
end
ncMean = mean(nc);
num = sum((nc-ncMean).^2);
den = numOfSolsInS-1;
Dnc = sqrt(num/den);

ud = 1/(1+Dnc);

end