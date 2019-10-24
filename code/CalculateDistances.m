function distances = CalculateDistances (geometrySolution,topologySolution)

% Distances is a matriax represents the distances between the sensor nodes
distances = inf(numnodes(topologySolution),numnodes(topologySolution));

% For each edge in the topologySolution
for j = 1:numedges(topologySolution)
    
    % Find the source and the target node for the edge
    sourceNode=topologySolution.Edges.EndNodes(j,1);
    targetNode=topologySolution.Edges.EndNodes(j,2);
    
    % Find the positions of the source and the target node
    sourceNodeXPosition = geometrySolution.x(sourceNode);
    sourceNodeYPosition = geometrySolution.y(sourceNode);
    targetNodeXPosition = geometrySolution.x(targetNode);
    targetNodeYPosition = geometrySolution.y(targetNode);
    
    % Calculate the distance between the source and the target node
    distance=pdist2([sourceNodeXPosition sourceNodeYPosition],[targetNodeXPosition targetNodeYPosition]);
    distances(sourceNode,targetNode) = distance;
    distances(targetNode,sourceNode) = distance;
end

end
