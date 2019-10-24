function  SC2 = SetCoverage2(paretoFront1,paretoFront2)
% Capacity metric.
% Coverage of Two Sets (or Metric C).
% S1_objs: the objectives values correspond to the first optimal solution set.
% S2_objs: the objectives values correspond to second optimal solution set.

numOfSolsInS1 = size(paretoFront1,1);        % Number of solutions in S1
numOfSolsInS2 = size(paretoFront2,1);        % Number of solutions in S2
nonDomIndices = true(1,numOfSolsInS2);  % Indices of non-dominated solutions in S2 by S1
for i = 1:numOfSolsInS2
    for j = 1:numOfSolsInS1
        if all(paretoFront1(j,:)<=paretoFront2(i,:)) && any(paretoFront1(j,:)<paretoFront2(i,:))
            nonDomIndices(i) = false;
            break
        end
    end
end

numOfDomSolsInS2 = length(find(~nonDomIndices)); % Number of dominated solutions in S2 by S1
SC2 = numOfDomSolsInS2/numOfSolsInS2;

end