%How to Call it:
L = 50;  % Lattice parameter
D = 2;  % Dimension of the lattice
lattice = zeros(repmat(L, 1, D));
N = 5:50;  % Target number of step, range of this will impact accuracy
% Number of success each step needs to collect, this will directly impact
% simulation accuracy
success_goal = 500;  
R_avg = zeros(size(N));
success_rate = zeros(size(N));
index = 0;

for i = N
    i
    index = index+1;
    [total_attempt, R] = oldSimpleRandomWalk(lattice, success_goal, i);
    success_rate(index) = success_goal/total_attempt;
    R_avg(index) = mean(R);
end