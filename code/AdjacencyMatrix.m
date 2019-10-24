function adjacencyMatrix = AdjacencyMatrix(solution,Rcmax)

% solution is a struct array with two fields x,y represents the positions of
% the sensor nodes

adjacencyMatrix = zeros(length(solution.x),length(solution.x));

% Check weather nodes are connected due to connectivity inequality
for i=1:length(solution.x)
    adjacencyMatrix(i,pdist2([solution.x(i) solution.y(i)],[solution.x solution.y])<=Rcmax) = 1;
end

% Remove ones from the the main diagonal
adjacencyMatrix = adjacencyMatrix-eye(length(solution.x),length(solution.x));

end