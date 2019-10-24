function [connected,RciMin] = ComputeMinimumRci(solution,Rcmax)

% Compute the adjacency matrix
adjacencyMatrix = AdjacencyMatrix(solution,Rcmax);

% Check the connectivity of the graph
connected = IsGraphConnected1(adjacencyMatrix);

if connected
    % +1 because the sink node is added to x and y coordinates
    toBeSearchedNode = solution.numberOfSensors+1;
    searchedNodes = toBeSearchedNode;
    dists = pdist2([solution.x(toBeSearchedNode) solution.y(toBeSearchedNode)],...
        [solution.x solution.y]);
    ind = find(dists<Rcmax);
    ind(ind == toBeSearchedNode) = [];
    
    chosenNodes = [toBeSearchedNode ind];
    chosenNodesDists = dists(ind);
    toBeSearchedNode = chosenNodes(1+randi(length(chosenNodes)-1));
    while ~isempty(toBeSearchedNode)
        
        searchedNodes = [searchedNodes toBeSearchedNode];
        
        dists = pdist2([solution.x(toBeSearchedNode) solution.y(toBeSearchedNode)],...
            [solution.x solution.y]);
        ind = find(dists<Rcmax);
        ind(ind == toBeSearchedNode) = [];
        ind(ismember(ind,chosenNodes)) = [];
        
        chosenNodes = [chosenNodes ind];
        chosenNodesDists = [chosenNodesDists dists(ind)];
        
        tempArray = chosenNodes;
        tempArray(ismember(tempArray,searchedNodes)) = [];
        try
            toBeSearchedNode = tempArray(randi(length(tempArray)));
        catch
            toBeSearchedNode = [];
        end
        
    end
    chosenNodes(1) = [];
    [~,indices] = sort(chosenNodes);
    RciMin = ceil(chosenNodesDists(indices));
    if length(RciMin)~=solution.numberOfSensors
        RciMin = [];
        connected = false;
    end
else
    % The graph is not connected
    RciMin = [];
end

end