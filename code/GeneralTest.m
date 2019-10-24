function GeneralTest(solution)

global RcValues RsValues

covered1 = true;%IsEnvironmentCovered1(solution,0,1000);
covered2 = IsEnvironmentCovered2(solution);
covered3 = IsEnvironmentCovered3(solution);

if ~covered1 || ~covered2 || ~covered3
    d = 1;
end

adjacencyMatrix = AdjacencyMatrix(solution,RcValues(end));
connected = IsGraphConnected1(adjacencyMatrix);
if ~connected
    d = 1;
end

if any(solution.Rc>RcValues(end))
    d = 1;
end

if any(solution.Rs>RsValues(end))
    d = 1;
end

if any((solution.x-ceil(solution.x))~=0 | (solution.x-floor(solution.x))~=0)
    d = 1;
end

if any((solution.y-ceil(solution.y))~=0 | (solution.y-floor(solution.y))~=0)
    d = 1;
end

if any((solution.Rs-ceil(solution.Rs))~=0 | (solution.Rs-floor(solution.Rs))~=0)
    d = 1;
end

if any((solution.Rc-ceil(solution.Rc))~=0 | (solution.Rc-floor(solution.Rc))~=0)
    d = 1;
end

end