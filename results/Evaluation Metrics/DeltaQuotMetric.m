function delta = DeltaQuotMetric(paretoFront)

% Now it is ready for the case of two objective functions only

% Diversity Metrics.
% Distribution in diversity metrics.
% delta' metric Or M3* metric.
% S: optimal solution set.

[~,ind] = sort(paretoFront(:,1));
lexicographyOrder = paretoFront(ind,:);    % Must be a function for ordering (not implemented here !!)
numOfSolsInS = size(paretoFront,1); % Number of solutions in S
di = zeros(1,numOfSolsInS-1);
for i = 1:numOfSolsInS-1
    di(i) = pdist2(lexicographyOrder(i,:),lexicographyOrder(i+1,:));
end

d = mean(di); % For delta' metric
% OR
% d = max(di); % For M3* metric

delta = sum(abs(di-d))/(numOfSolsInS-1);

end