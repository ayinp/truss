%Truss Project Preliminary Design
%Input takes in C, Sx, Sy, X, Y, L

filename = input('What is the name of your input file (use quotes)? ')
%filename = 'practice_problem.mat';
load(filename)

[num_joints, num_members] = size(C);


Vx = zeros(1, num_members);
Vy = zeros(1, num_members);
r = zeros(1, num_members);

%For each member, find its 2 connections
for m = 1:num_members
    connected_joints = find(C(:, m) == 1);

    x1 = X(connected_joints(1));
    y1 = Y(connected_joints(1));
    x2 = X(connected_joints(2));
    y2 = Y(connected_joints(2));
    v = [x2 - x1; y2 - y1];
    r (1,m) = norm(v);
    Vx(1,m) = v(1)/r(1,m);
    Vy(1,m) = v(2)/r(1,m);
end

Cx = C(:,:);
Cy = C(:,:);
for j = 1:num_members
    oneFound = false;
    for i = 1:num_joints
        if(C(i,j)==1 && oneFound == false)
            Cx(i,j) = Cx(i,j) * Vx(j);
            Cy(i,j) = Cy(i,j) * Vy(j);
            oneFound = true;
        elseif(C(i,j)==1)
            Cx(i,j) = Cx(i,j) * -Vx(j);
            Cy(i,j) = Cy(i,j) * -Vy(j);
        end
    end
end

A = [Cx, Sx; Cy, Sy];

T = A \ L;

Rm = T(1:num_members) / max(L);
Pcrit = 2390.012 * (r .^ -1.811); %Pcrit represents the Buckling Strength

Wfail = inf(num_members, 1);  

for m = 1:num_members
    if Rm(m) < 0
        Wfail(m) = -Pcrit(m) / Rm(m);
    end
end

[Wmax, crit_member] = min(Wfail);

Uf = 1.35;
Fmax = Pcrit(crit_member);
Uw = (Uf/Fmax)*Wmax;


fprintf('%% EK301, Section A3, Group 32, Derek L., Michelle Y., Ayin P., %s\n', datetime('today','Format','MM/dd/yyyy')); 
fprintf('Load: %.2f oz\nMember forces in oz\n', norm(L)) 
for(i = 1:num_members)
    if(T(i) < 0)
        fprintf('m%d: %.3f (%c)\n', i, -T(i), 'C') 
    else
        fprintf('m%d: %.3f (%c)\n', i, T(i), 'T')
    end 
end
fprintf('Reaction forces in oz:\nSx1: %.2f\nSy1: %.2f\nSy2: %.2f\n', T(end-2), T(end-1), T(end))
cost = 10*num_joints + 1*(sum(r));
fprintf('Cost of truss: $%.2f\n', cost)
fprintf('Theoretical max load/cost ratio in oz/$: %.4f oz/$\n', Wmax/cost) %% need to change

fprintf('Critical member: %d\n', crit_member);
fprintf('Uncertainty in buckling force: +-1.35 oz\n')
fprintf('Max load before buckling: %.2f oz\n', Wmax)
fprintf('Uncertainty in max load: +-%.2f oz\n', Uw)