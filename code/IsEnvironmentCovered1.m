function covered = IsEnvironmentCovered1(solution,minLim,maxLim)

solution.x(end) = [];
solution.y(end) = [];

[vertX,vertY] = voronoi(solution.x,solution.y);           % [vertX,vertY] coordinates of Voronoi vertices
[newVertX,newVertY] = ProcessVoronoiVertices(vertX,vertY,minLim,maxLim);
voronoiCellsDistances = DetermineVoronoiCellsDistances(newVertX,newVertY,[solution.x solution.y],...
    solution.numberOfSensors,maxLim);

RsiMin = zeros(1,solution.numberOfSensors);
for s = 1:solution.numberOfSensors
    RsiMin(s) = max(voronoiCellsDistances{s});
    if RsiMin(s)>solution.Rs(s)
        covered = false;
        return;
    end
end
covered = true;
end