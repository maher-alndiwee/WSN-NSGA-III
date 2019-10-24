% 
% Copyright (c) 2016, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
% 
% Project Code: YPEA126
% Project Title: Non-dominated Sorting Genetic Algorithm III (NSGA-III)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Implemented by: S. Mostapha Kalami Heris, PhD (member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
% 
% Base Reference Paper:
% K. Deb and H. Jain, "An Evolutionary Many-Objective Optimization Algorithm 
% Using Reference-Point-Based Nondominated Sorting Approach, Part I: Solving
% Problems With Box Constraints,"
% in IEEE Transactions on Evolutionary Computation,
% vol. 18, no. 4, pp. 577-601, Aug. 2014.
% 
% Reference Papaer URL: http://doi.org/10.1109/TEVC.2013.2281535
% 

function [pop, params] = NormalizePopulation(pop, params)

    params.zmin = UpdateIdealPoint(pop, params.zmin);
    
    fp = [pop.Cost] - repmat(params.zmin, 1, numel(pop));
    
    params = PerformScalarizing(fp, params);
    
    a = FindHyperplaneIntercepts(params.zmax);
    
    for i = 1:numel(pop)
        pop(i).NormalizedCost = fp(:,i)./a;
    end
    
end

function a = FindHyperplaneIntercepts(zmax)

    w = ones(1, size(zmax,2))/zmax;
    
    a = (1./w)';

end