%Truss Project Preliminary Design
%Input takes in C, Sx, Sy, X, Y, L

filename = 'practice_problem.mat';
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

for i = 1:num_members
    for j = 1:num_joints

    end
end
% r will be array containing the member's lengths
% Vx and Vy will be the unit vectors in the direction later-earlier



