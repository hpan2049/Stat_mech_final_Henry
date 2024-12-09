function [R_avg, f, time, nu] = dimerizationCall(n, success_goal, d)
    N = n+1;
    R_avg = zeros(size(N));
    time = zeros(size(N));
    nu = zeros(3, size(N,2));
    index = 0;
    for i = N
        disp(i);
        tic;
        index = index+1;
        R = zeros(1, success_goal);
        for j = 1:success_goal
            [positions] = dimerization(i, d);
            R(j) = sqrt(sum((positions(end,:)-positions(1,:)).^2));
            
            % Plot the chain positions directly
            figure;
            plot(positions(:, 1), positions(:, 2), '-o', 'LineWidth', 1.5, 'MarkerSize', 1.8);
            xlabel('x');
            ylabel('y');
            title(sprintf('Single Polymer Chain for n=%d, d=%d', n, d));
        end
        time(index) = toc;
        R_avg(index) = mean(R);
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