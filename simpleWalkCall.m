function [R_avg, f, time, nu] = simpleWalkCall(n, success_goal, d)
    N = n+1;
    R_avg = zeros(size(N));
    time = zeros(size(N));
    nu = zeros(3, size(N,2));
    index = 0;
    for i = N
        tic;
        disp(i);
        index = index+1;
        R = zeros(1, success_goal);
        for j = 1:success_goal
            [positions] = oneRandomWalkNoLattice(i, d);
            R(j) = sqrt(sum((positions(end,:)-positions(1,:)).^2));
        end
        R_avg(index) = mean(R);
        time(index) = toc;
        % Disable the following after acquiring step 1
        if index > 2
            f = fit(n(1:index)', R_avg(1:index)', 'a*x^b', 'StartPoint', [1, 0.5]);
            conf = confint(f);
            nu(1, index) = f.b;
            nu(2, index) = conf(1,2);
            nu(3, index) = conf(2,2);
        end
    end
    f = fit(n', R_avg', 'a*x^b', 'StartPoint', [1, 0.5]);
end