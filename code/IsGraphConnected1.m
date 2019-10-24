function connected = IsGraphConnected1(adjacencyMatrix)
% AdjacencyMatrix is a square matrix represents the adjacency matrix
% Refer to Thereom of graph connectivity

s=zeros(size(adjacencyMatrix));
multiples=eye(size(adjacencyMatrix));
for k=1:length(adjacencyMatrix)-1
    multiples=multiples*adjacencyMatrix;
    s=s+multiples;
end

if isempty(find(s==0,1))
    connected=true;
else
    connected=false;
end
end