function [total_attemp, R] = oldSimpleRandomWalk(lattice, success_goal, N)
    start_position = num2cell(floor(size(lattice)/2));
    scale = size(lattice);
    d = ndims(lattice);
    startSet = [-d:-1, 1:d];
    
    success_count = 0;
    total_attemp = 0;
    R = zeros(success_goal,1);
    i = 0;
    
    while success_count < success_goal
        total_attemp = total_attemp+1;
        lattice = zeros(scale);
        
        current_position = start_position;
        next_position = current_position;
        lattice(current_position{:}) = 1;  % initialize the walk at the center of the lattice
        
        % In this code, random number generate from -d to d, positive
        % number means +1 in the d axis and negative number means -1 in the
        % d axis.
        current_direction = 0;
        flag = true;
        step = 0;
        while flag
            currentSet = startSet(startSet ~= -current_direction);
            current_direction = currentSet(randi(length(currentSet)));
            
            next_position{abs(current_direction)} = current_position{abs(current_direction)} + sign(current_direction);
            if all(cell2mat(next_position) > 0) && all(cell2mat(next_position) <= size(lattice))
                if (lattice(next_position{:}) == 0) && (step < N)
                    current_position = next_position;
                    lattice(current_position{:}) = 1;
                    step = step+1;
                else
                    flag = false;
                end
            else
                flag = false;
            end
        end
        if step == N
            i = i+1;
            success_count = success_count+1;
            endtoend = cell2mat(current_position)-cell2mat(start_position);
            R(i) = sqrt(sum(endtoend.^2));
        end
    end
end

