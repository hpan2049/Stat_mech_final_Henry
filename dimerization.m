function [SAW, total_attempt] = dimerization(N, d)
    N = N/2;
    threshold_n = 30;
    total_attempt = 0;
    if N <= threshold_n
        flag = false;
        while ~flag
            [position1, attempt1] = oneRandomWalkNoLattice(ceil(N), d);
            [position2, attempt2] = oneRandomWalkNoLattice(floor(N+1), d);
            total_attempt = total_attempt+attempt1+attempt2;
            [SAW, flag] = connectDimer(position1, position2);
        end
    end
    if N > threshold_n
        flag = false;
        while ~flag
            [SAW1, attempt1] = dimerization(ceil(N), d);
            [SAW2, attempt2] = dimerization(floor(N+1), d);
            total_attempt = total_attempt+attempt1+attempt2;
            [SAW, flag] = connectDimer(SAW1, SAW2);
        end
    end
end

