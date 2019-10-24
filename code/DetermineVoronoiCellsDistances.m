function [voronoiCellsDistances,uniquePoints] = DetermineVoronoiCellsDistances(vertX,vertY,sensorPosition,numberOfSensors,...
    regionOfInterest)

% Add the four corners in the field
vertX = [vertX(:);0;0;regionOfInterest;regionOfInterest];
vertY = [vertY(:);0;regionOfInterest;0;regionOfInterest];
uniquePoints = unique([vertX vertY],'rows','stable');

vertX = uniquePoints(:,1);
vertY = uniquePoints(:,2);

voronoiCellsDistances = cell(numberOfSensors,1);  % Cell array contains Voronoi vertices corresponding to each sensor
for v = 1:length(vertX)
    dist = pdist2([vertX(v) vertY(v)],[sensorPosition(:,1) sensorPosition(:,2)]);
    ind = find(dist>=min(dist) & dist<min(dist)+0.1);   % Take small differences into account
    for s = 1:length(ind)
        
        voronoiCellsDistances{ind(s),1} = [voronoiCellsDistances{ind(s),1} dist(ind(s))];
%         voronoiCellsDistances{ind(s),2} = [voronoiCellsDistances{ind(s),2} v];
        
    end
end

end