function SC1 = SetCoverage1(paretoFront1,paretoFront2)
% Capacity metric.
% Non-dominated Points by Reference Set.
% S_objs: objectives values correspond to optimal solution set.
% R_objs: objectives values correspond to reference set.

numOfSolsInS = size(paretoFront1,1);        % Number of solutions in S
numOfSolsInR = size(paretoFront2,1);        % Number of solutions in R
nonDomIndices = true(1,numOfSolsInS); % Indices of non-dominated solutions in S by R
for i = 1:numOfSolsInS
    for j = 1:numOfSolsInR
        if all(paretoFront2(j,:)<=paretoFront1(i,:)) && any(paretoFront2(j,:)<paretoFront1(i,:))
            nonDomIndices(i) = false;
            break
        end
    end
end

numOfNonDomSolsInS = length(find(nonDomIndices));
SC1 = numOfNonDomSolsInS/numOfSolsInS;

end