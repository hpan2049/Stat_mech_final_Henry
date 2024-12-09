%% Simple self avoiding random walk
%  Strategy: generate a D dimension square lattice. Put a starting point at
%  the center of the lattice. The first step the strand is allow to go all
%  directions then following step it's only allowed to go.

%% Set up the lattice and parameters
d = 3;  % Dimension of the lattice

n = 5:400;  % Target number of step, range of this will impact accuracy
N = n+1; % number of site is one more than number of steps
% Number of success each step needs to collect, this will directly impact
% simulation accuracy
success_goal = 1000;  
R_avg = zeros(size(N));
success_rate = zeros(size(N));
index = 0;

%% New simple walk
[R_avg_new, f, time] = simpleWalkCall(n, success_goal, d);

%% simple walk
index = 0;
for i = N
    i
    index = index+1;
    total_attempt = 0;
    R = zeros(1, success_goal);
    for j = 1:success_goal
        [positions, attempt] = oneRandomWalkNoLattice(i, d);
        total_attempt = total_attempt+attempt;
        R(j) = sqrt(sum((positions(end,:)-positions(1,:)).^2));
    end
    success_rate(index) = success_goal/total_attempt;
    R_avg(index) = mean(R);
end

%% dimerization
index = 0;
for i = N
    i
    index = index+1;
    total_attempt = 0;
    R = zeros(1, success_goal);
    for j = 1:success_goal
        [positions, attempt] = dimerization(i, d);
        total_attempt = total_attempt+attempt;
        R(j) = sqrt(sum((positions(end,:)-positions(1,:)).^2));
    end
    success_rate(index) = success_goal/total_attempt;
    R_avg(index) = mean(R);
end

%% pivoting method
index = 0;
for i = N
    i
    index = index+1;
    [R, total_attempt] = pivot(i, d, success_goal);
    success_rate(index) = success_goal/total_attempt;
    R_avg(index) = mean(R);
end

%% pivoting with graphic
index = 0;
figure;
hold on;
axis equal;
grid on;
title('2D Self-Avoiding Walk (SAW)');
xlabel('X');
ylabel('Y');
set(gca, 'XColor', 'k', 'YColor', 'k', 'Color', [0.9 0.9 0.9]);
for i = N
    i
    index = index+1;
    [R, total_attempt] = pivotTest(i, d, success_goal);
    success_rate(index) = success_goal/total_attempt;
    R_avg(index) = mean(R);
end


%% Data analysis and plot
f = fit(n', R_avg', 'a*x^b', 'StartPoint', [1, 0.5]); % Initial guess [a, nu]
a = f.a
nu = f.b

% Plot R_avg against N
figure;
plot(n, R_avg, 'bo');
hold on;
plot(n, f.a*n.^f.b, 'r-', 'LineWidth', 2.3); % Fitted curve
xlabel('N');
ylabel('R_{avg}');
title('Average End-to-End Distance Squared (R_{avg}) vs. N');
legend('Original Data', 'Fitted Curve', 'Location', 'nw');

% Plot total_attempts * (1/success_goal) against N
figure;
plot(n, success_rate, '-o');
xlabel('N');
ylabel('Success rate');
title('Success rate vs. N');