function covered = IsEnvironmentCovered2(solution)

global gridPoints

sumGridCoveragPoints=0;
tempGridPoints=gridPoints;

for s=1:solution.numberOfSensors
    % Find the index of grid points covered by the sensor k
    % see inequality (3)
    dist=pdist2([solution.x(s) solution.y(s)],tempGridPoints);
    ind=find(dist<=solution.Rs(s));
    
    % Add the number of covered points to the sum
    sumGridCoveragPoints=sumGridCoveragPoints+length(ind);
    
    % Remove the grid points that acheived the coverage from the grid points test
    % set
    tempGridPoints(ind,:)=[];
    
    % If all the grid points acheive the coverage stop the examination process
    if isempty(tempGridPoints)
        covered = true;
        return;
    end
end
covered = false;

end