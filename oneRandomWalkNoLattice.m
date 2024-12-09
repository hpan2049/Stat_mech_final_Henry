function [positions, attempt] = oneRandomWalkNoLattice(N, d)
    startSet = [-d:-1, 1:d];
    positions = zeros(N, d);
    attempt = 0;
    while all(positions(end, :) == 0)
        positions = zeros(N, d);
        current_position = zeros(1, d);
        next_position = current_position;
        positions(1,:) = current_position;
        current_direction = 0;
        flag = true;
        step = 1;
        attempt = attempt+1;
        while flag
            currentSet = startSet(startSet ~= -current_direction);
            current_direction = currentSet(randi(length(currentSet)));

            next_position(abs(current_direction)) = ...
                current_position(abs(current_direction)) + sign(current_direction);
            if (sum(ismember(next_position, positions, 'row')) == 0) && (step < N)
                step = step+1;
                current_position = next_position;
                positions(step,:) = current_position;
            else
                flag = false;
            end
        end
    end
end