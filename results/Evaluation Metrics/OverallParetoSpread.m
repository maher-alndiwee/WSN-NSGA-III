function os = OverallParetoSpread(S_objs,PG_objs,PB_objs)
% Diversity Metrics.
% Spread in diversity metrics.
% The Overall Pareto Spread (OS).

numberOfObjectives = size(S_objs,2);
os = zeros(1,numberOfObjectives);
for k = 1:numberOfObjectives
    os(k) = abs(max(S_objs(:,k))-min(S_objs(:,k)))/abs(PB_objs(k)-PG_objs(k)); 
end

os = prod(os);

end

