%% Simple self avoiding random walk
%  Strategy: generate a D dimension square lattice. Put a starting point at
%  the center of the lattice. The first step the strand is allow to go all
%  directions then following step it's only allowed to go.

%% Nu by simple walk

[R_avg_SW, f_SW, time_SW_temp, nu_SW_temp] = simpleWalkCall(5:80, 1000, 3);

% Nu by dimerization

[R_avg_DM, f_DM, time_DM_temp, nu_DM_temp] = dimerizationCall(5:100, 1000, 3);

% Nu by Pivot

[R_avg_PV, f_PV, time_PV_temp, nu_PV_temp] = pivotCall(5:400, 50000, 3);

%% Graph
n_SW = 5:80;
n_DM = 5:100;
n_PV = 5:400;
% Simple SAW
figure;
plot(n_SW, R_avg_SW, 'bo', 'DisplayName', 'Simulated Data');
hold on;
plot(n_SW, f_SW.a * n_SW.^f_SW.b, 'r-', 'LineWidth', 2.3, 'DisplayName', sprintf('Fitted Line: %.2f * n^{%.4f}', f_SW.a, f_SW.b));
xlabel('n');
ylabel('R_{avg}');
title('Simple SAW in d=3');
legend;
grid on;
hold off;

% Dimerization
figure;
plot(n_DM, R_avg_DM, 'bo', 'DisplayName', 'Simulated Data');
hold on;
plot(n_DM, f_DM.a * n_DM.^f_DM.b, 'r-', 'LineWidth', 2.3, 'DisplayName', sprintf('Fitted Line: %.2f * n^{%.4f}', f_DM.a, f_DM.b));
xlabel('n');
ylabel('R_{avg}');
title('Dimerization in d=3');
legend;
grid on;
hold off;

% Pivot
figure;
plot(n_PV, R_avg_PV, 'bo', 'DisplayName', 'Simulated Data');
hold on;
plot(n_PV, f_PV.a * n_PV.^f_PV.b, 'r-', 'LineWidth', 2.3, 'DisplayName', sprintf('Fitted Line: %.2f * n^{%.4f}', f_PV.a, f_PV.b));
xlabel('n');
ylabel('R_{avg}');
title('Pivot in d=3');
legend;
grid on;
hold off;

%% Nu against Sample
success_goal = [100:100:1000, 2000:1000:20000]; % Combine two intervals
d = 4;
n = 5:30;
N = n+1;

if d == 2
    nu_expectation = 0.75;
elseif d == 3
    nu_expectation = 0.59;
else
    nu_expectation = 0.5;
end

% Initialize variables
nu_SW = nan(size(success_goal)); % Use NaN for unused values
nu_DM = nan(size(success_goal));
nu_PV = nan(size(success_goal));

time_SW = nan(size(success_goal));
time_DM = nan(size(success_goal));
time_PV = nan(size(success_goal));

% Loop over success goals
for index = 1:length(success_goal)
    jj = success_goal(index);
    
    % Simple Walk only up to 1000
    if jj <= 1000
        [R_avg_SW, f_SW, time_SW_temp, nu_SW_temp] = simpleWalkCall(n, jj, d);
        time_SW(index) = sum(time_SW_temp);
        nu_SW(index) = nu_SW_temp(1, end);
    end
    
    % Dimerization only up to 3000
    if jj <= 3000
        [R_avg_DM, f_DM, time_DM_temp, nu_DM_temp] = dimerizationCall(n, jj, d);
        time_DM(index) = sum(time_DM_temp);
        nu_DM(index) = nu_DM_temp(1, end);
    end
    
    % Pivoting up to 20000
    [R_avg_PV, f_PV, time_PV_temp, nu_PV_temp] = pivotCall(n, jj, d);
    time_PV(index) = sum(time_PV_temp);
    nu_PV(index) = nu_PV_temp(1, end);
end

% Plot nu vs Success Goal
figure;
hold on;

% Add expected value line
yline(nu_expectation, 'r--', 'LineWidth', 1.5, ...
    'DisplayName', sprintf('Expected Value (\\nu = %.2f)', nu_expectation));

% Plot nu for each method
plot(success_goal, nu_SW, '-', 'DisplayName', 'Simple Walk', 'LineWidth', 1.5);
plot(success_goal, nu_DM, '-', 'DisplayName', 'Dimerization', 'LineWidth', 1.5);
plot(success_goal, nu_PV, '-', 'DisplayName', 'Pivoting Method', 'LineWidth', 1.5);

% Customize the plot
xlabel('Number of accepted walks');
ylabel('\nu (Critical Exponent)');
title('Critical Exponent (\nu) vs Number of accepted walks');
legend('show');
grid on;

hold off;

% Plot Computation Time vs Success Goal
figure;
hold on;

% Plot computation time for each method
plot(success_goal, time_SW, '-', 'DisplayName', 'Simple Walk', 'LineWidth', 1.5);
plot(success_goal, time_DM, '-', 'DisplayName', 'Dimerization', 'LineWidth', 1.5);
plot(success_goal, time_PV, '-', 'DisplayName', 'Pivoting Method', 'LineWidth', 1.5);

% Customize the plot
xlabel('Number of accepted walks');
ylabel('Computation Time (s)');
title('Computation Time vs Number of accepted walks');
legend('show');
grid on;

hold off;


%% This one don't make much sense since more step of course get you more accurate results
% The time comparison does make sense tho
d = 4;
n = 5:400;
N = n+1;
success_goal = 1000; 

if d == 2
    nu_expectation = 0.75;
elseif d == 3
    nu_expectation = 0.59;
else
    nu_expectation = 0.5;
end

% simple walk
[R_avg_SW, f_SW, time_SW, nu_SW] = simpleWalkCall(n(n<61), success_goal, d);

% dimerization
[R_avg_DM, f_DM, time_DM, nu_DM] = dimerizationCall(n(n<91), success_goal, d);

% pivoting method
[R_avg_PV, f_PV, time_PV, nu_PV] = pivotCall(n, success_goal, d);

% plot results
% Define limits for each method
n_simpleWalk = n(3:size(nu_SW, 2)); % Simple Walk ends at 50 steps
nu_SW_trimmed = nu_SW(1, 3:end); % First row contains the nu values

n_dimerization = n(3:size(nu_DM, 2)); % Dimerization ends at 70 steps
nu_DM_trimmed = nu_DM(1, 3:end); % First row contains the nu values

n_pivot = n(3:end); % Pivoting goes to the full range
nu_PV_trimmed = nu_PV(1, 3:end); % First row contains the nu values

% Plot the data
figure;
hold on;

% Plot each method with colored lines only
plot(n_simpleWalk, nu_SW_trimmed, '-', 'DisplayName', 'Simple Walk', 'LineWidth', 1.5);
plot(n_dimerization, nu_DM_trimmed, '-', 'DisplayName', 'Dimerization', 'LineWidth', 1.5);
plot(n_pivot, nu_PV_trimmed, '-', 'DisplayName', 'Pivoting Method', 'LineWidth', 1.5);

% Add a horizontal line at y = 0.75
yline(nu_expectation, 'r--', 'LineWidth', 1.5, ...
    'DisplayName', sprintf('Expected Value (\\nu = %.2f)', nu_expectation));

% Customize the plot
xlabel('Number of Steps (n)');
ylabel('\nu (Critical Exponent)');
title('Critical Exponent (\nu) vs Number of Steps (n)');
legend('show');
grid on;

hold off;

n_simpleWalk = n(1:size(time_SW,2));
n_dimerization = n(1:size(nu_DM, 2));
n_pivot = n(1:end);

figure;
hold on;

% Plot each method with colored lines only
plot(n_simpleWalk, time_SW, '-', 'DisplayName', 'Simple Walk', 'LineWidth', 1.5);
plot(n_dimerization, time_DM, '-', 'DisplayName', 'Dimerization', 'LineWidth', 1.5);
plot(n_pivot, time_PV, '-', 'DisplayName', 'Pivoting Method', 'LineWidth', 1.5);

% Customize the plot
xlabel('Number of Steps (n)');
ylabel('Computation Time (s)');
title('Computation Time vs Number of Steps (n)');
legend('show');
grid on;

hold off;

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