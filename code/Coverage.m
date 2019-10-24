function cover = Coverage(solution)

global numberOfGridPoints sensingRange gridPoints numberOfSensors

% solution is a struct array with two fields x,y represents the positions of the sensor nodes

sumGridCoveragPoints=0;
tempGridPoints=gridPoints;

% For each sensor node
for k=1:numberOfSensors+1
    
    % If all the grid points acheive the coverage stop the examination process
    if isempty(tempGridPoints)
        break;
    end
    
    % If the node is the sink don't find its coverage points
    if solution.x(k)==500 && solution.y(k)==500
        continue
    end
    
    % Find the index of grid points covered by the sensor k
    % see inequality (3)
    dist=pdist2([solution.x(k) solution.y(k)],tempGridPoints);
    ind=find(dist<=sensingRange);
    
    % Add the number of covered points to the sum
    sumGridCoveragPoints=sumGridCoveragPoints+length(ind);
    
    % Remove the grid points that acheived the coverage from the grid points test
    % set
    tempGridPoints(ind,:)=[];
end

% The percentage noncovered points  of the ROI , see equation (2)
cover= 1-(sumGridCoveragPoints/numberOfGridPoints);

end