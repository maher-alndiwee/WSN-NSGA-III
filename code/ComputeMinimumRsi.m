function [covered,RsiMin,newVertX,newVertY] = ComputeMinimumRsi(solution,minLim,maxLim,Rsmax)

% Remove the sink from the solution (sink does not sense the environment)
solution.x(end) = [];
solution.y(end) = [];

% Determine the nodes of voronoi diagram
[vertX,vertY] = voronoi(solution.x,solution.y);           % [vertX,vertY] coordinates of Voronoi vertices

% Process the diagram (remove lines that are outside the environment
% boundaries and fix the position of some nodes)
[newVertX,newVertY] = ProcessVoronoiVertices(vertX,vertY,minLim,maxLim);

% Compute the required sensing range for each sensor
voronoiCellsDistances = DetermineVoronoiCellsDistances(newVertX,newVertY,[solution.x solution.y],...
    solution.numberOfSensors,maxLim);

RsiMin = zeros(1,solution.numberOfSensors);
for s = 1:solution.numberOfSensors
    RsiMin(s) = max(voronoiCellsDistances{s});
    if RsiMin(s)>Rsmax
        % The required range is bigger than the allowed value
        covered = false;
        return;
    end
end
RsiMin = ceil(RsiMin);
covered = true;


end