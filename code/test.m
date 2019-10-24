count = 0;
for i = 1:size(paretoFront.solutions,2)-1

    for j = 2:size(paretoFront.solutions,2)
        x=paretoFront.solutionsObjectiveValues(i,1)-paretoFront.solutionsObjectiveValues(j,1);
        y=paretoFront.solutionsObjectiveValues(i,2)-paretoFront.solutionsObjectiveValues(j,2);
        if(x*y>0)
            count=count+1;

           break
         
        end
    end
end