function averageDiffVal = AverageDiffVal(refernceSet,testedSet)

if isempty(refernceSet)
    averageDiffVal = nan;
    return;
end

diffVals = zeros(size(testedSet,1),size(testedSet,2));
for k = 1:size(testedSet,1)
    [~,ind] = min(pdist2(testedSet(k,:),refernceSet));
    diffVals(k,:) = refernceSet(ind,:) - testedSet(k,:);
end

averageDiffVal = mean(mean(diffVals));
end