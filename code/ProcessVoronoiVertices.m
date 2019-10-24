function [newVertX,newVertY] = ProcessVoronoiVertices(vertX,vertY,minLim,maxLim)

% minLim is the minimum value of x and y coordinates
% maxLim is the maximum value of x and y coordinates

vert = [vertX;vertY];

% Remove lines which are completely out of the field
con1 = vertX>maxLim;
con2 = vertX<minLim;
con3 = vertY>maxLim;
con4 = vertY<minLim;
vert(:,sum(con1)==2 | sum(con2)==2 | sum(con3)==2 | sum(con4)==2)=[];

% Repaire remaining lines
for k = 1:size(vert,2)
    vert(:,k) = ProcessLine(vert(:,k),minLim,maxLim);
end

% Return the new values
newVertX = vert(1:2,:);
newVertY = vert(3:4,:);

end

function lin = ProcessLine(lin,minLim,maxLim)

if isempty(find(lin<minLim | lin>maxLim,1))
    % The line does not need repairing
    return;
end

pointA = [lin(1) lin(3)];    % The first point
pointB = [lin(2) lin(4)];    % The second point
slope = (pointA(2)-pointB(2))/(pointA(1)-pointB(1));    % The slope of line segment
const = pointA(2)-slope*pointA(1);                      % The constant of line segment

% Process points out of the field
pointA = ProcessPoint(pointA,slope,const,minLim,maxLim);
pointB = ProcessPoint(pointB,slope,const,minLim,maxLim);

% Return the line segment after repairing
lin = [pointA(1) ; pointB(1) ; pointA(2) ; pointB(2)];

end

% function point = ProcessPoint(point,slope,const,minLim,maxLim)
%
% if point(1)>maxLim
%     point(1) = maxLim;
%     point(2) = slope*point(1)+const;
%     point = ProcessPoint(point,slope,const,minLim,maxLim);
%
% elseif point(2)>maxLim
%     point(2) = maxLim;
%     point(1) = (point(2)-const)/slope;
%     point = ProcessPoint(point,slope,const,minLim,maxLim);
%
% elseif point(1)<minLim
%     point(1) = minLim;
%     point(2) = slope*point(1)+const;
%     point = ProcessPoint(point,slope,const,minLim,maxLim);
%
% elseif point(2)<minLim
%     point(2) = minLim;
%     point(1) = (point(2)-const)/slope;
%     point = ProcessPoint(point,slope,const,minLim,maxLim);
%
% else
%     return;
% end
% end
function point = ProcessPoint(point,slope,const,minLim,maxLim)

if point(1)>maxLim
    if point(2)>maxLim
        % Both of them bigger than maxLim
        if isinf(slope) || slope==0
            % Line parrallel to x-axis or y-axis case
            point(1) = maxLim;
            point(2) = maxLim;
        else
            point(1) = maxLim;
            point(2) = slope*maxLim+const;
            if point(2)>maxLim
                % y-coordinate still out of field
                point(2) = maxLim;
                point(1) = (maxLim-const)/slope;
            end
        end
        
    elseif point(2)<minLim
        if isinf(slope) || slope==0
            % Line parrallel to x-axis or y-axis case
            point(1) = maxLim;
            point(2) = minLim;
        else
            point(1) = maxLim;
            point(2) = slope*maxLim+const;
            if point(2)<minLim
                % y-coordinate still out of field
                point(2) = minLim;
                point(1) = (minLim-const)/slope;
            end
        end
        
    else
        point(1) = maxLim;
        point(2) = slope*maxLim+const;
    end
    
elseif point(1)<minLim
    if point(2)>maxLim
        if isinf(slope) || slope==0
            % Line parrallel to x-axis or y-axis case
            point(1) = minLim;
            point(2) = maxLim;
        else
            point(1) = minLim;
            point(2) = slope*minLim+const;
            if point(2)>maxLim
                % y-coordinate still out of field
                point(2) = maxLim;
                point(1) = (maxLim-const)/slope;
            end
        end
        
    elseif point(2)<minLim
        % Both of them less than minLim
        if isinf(slope) || slope==0
            % Line parrallel to x-axis or y-axis case
            point(1) = minLim;
            point(2) = minLim;
        else
            point(1) = minLim;
            point(2) = slope*minLim+const;
            if point(2)<minLim
                % y-coordinate still out of field
                point(2) = minLim;
                point(1) = (minLim-const)/slope;
            end
        end
        
    else
        point(1) = minLim;
        point(2) = slope*minLim+const;
    end
    
elseif point(2)>maxLim
    if isinf(slope)
        % Line parrallel to y-axis case
        point(2) = maxLim;
    else
        point(2) = maxLim;
        point(1) = (maxLim-const)/slope;
        
    end
    
elseif point(2)<minLim
    if isinf(slope)
        % Line parrallel to y-axis case
        point(2) = minLim;
    else
        point(2) = minLim;
        point(1) = (minLim-const)/slope;
    end
    
end

end
