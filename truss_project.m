%Truss Project Preliminary Design
%Input takes in C, Sx, Sy, X, Y, L

[num_joints, num_members] = size(C);

Vx = zeros(num_members, 1);
Vy = zeros(num_members, 1);
r = zeros(num_members, 1);

%For each member, find its 2 connections
for m = 1:num_members
    connected_joints = find(C(:, m) == 1);
    
    joint1 = joints(connected_joints(1), :);
    joint2 = joints(connected_joints(2), :);
    v = joint2-joint1;
    r = norm(v);

    Vx(m) = v(1)/r(m);
    Vy(m) = v(2)/r(m);
end
% r will be array containing the member's lengths
% Vx and Vy will be the unit vectors in the direction later-earlier



