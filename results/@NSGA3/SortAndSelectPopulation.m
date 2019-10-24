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

function [nsga3] = SortAndSelectPopulation(nsga3)

    [nsga3.pop, nsga3.params] = NormalizePopulation(nsga3.pop, nsga3.params);

    [nsga3.pop, nsga3.F] = NonDominatedSorting(nsga3.pop);
    
    nPop = nsga3.params.nPop;
    if numel(nsga3.pop) == nPop
        return;
    end
    
    [nsga3.pop, d, rho] = AssociateToReferencePoint(nsga3.pop, nsga3.params);
    
    newnsga3.pop = [];
    for l=1:numel(nsga3.F)
        if numel(newnsga3.pop) + numel(nsga3.F{l}) > nPop
            Lastnsga3.Front = nsga3.F{l};
            break;
        end
        
        newnsga3.pop = [newnsga3.pop; nsga3.pop(nsga3.F{l})];   %%#ok
    end
    
    while true
        
        [~, j] = min(rho);
        
        Associtednsga3.FromLastnsga3.Front = [];
        for i = Lastnsga3.Front
            if nsga3.pop(i).AssociatedRef == j
                Associtednsga3.FromLastnsga3.Front = [Associtednsga3.FromLastnsga3.Front i]; %#ok
            end
        end
        
        if isempty(Associtednsga3.FromLastnsga3.Front)
            rho(j) = inf;
            continue;
        end
        
        if rho(j) == 0
            ddj = d(Associtednsga3.FromLastnsga3.Front, j);
            [~, new_member_ind] = min(ddj);
        else
            new_member_ind = randi(numel(Associtednsga3.FromLastnsga3.Front));
        end
        
        MemberToAdd = Associtednsga3.FromLastnsga3.Front(new_member_ind);
        
        Lastnsga3.Front(Lastnsga3.Front == MemberToAdd) = [];
        
        newnsga3.pop = [newnsga3.pop; nsga3.pop(MemberToAdd)]; %#ok
        
        rho(j) = rho(j) + 1;
        
        if numel(newnsga3.pop) >= nPop
            break;
        end
        
    end
    
    [nsga3.pop, nsga3.F] = NonDominatedSorting(newnsga3.pop);
    
end
