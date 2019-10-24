function covered = IsEnvironmentCovered3(solution)

global gridPoints numberOfGridPoints

% Compute the distance between the grid points and the sensors
dists = pdist2(gridPoints,[solution.x(1:end-1) solution.y(1:end-1)]);

% Check which sensors cover the grid points
summation = sum(dists<=repmat(solution.Rs,numberOfGridPoints,1),2);

if isempty(find(summation==0,1))
    % All of the points are covered
    covered = true;
else
    % Some of the points are not covered
    covered = false;
end

end