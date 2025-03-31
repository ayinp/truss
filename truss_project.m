Truss Project Preliminary Design
%Input takes in C, Sx, Sy, X, Y, L

[num_joints, num_members] = size(C);

v = zeros(num_members, 2);
r = zeros(num_members, 1);

%For each member, find its 2 connections
for m = 1:num_members
    connected_joints = find(C(:, m) == 1);
    
    joint1 = joints(connected_joints(1), :);
    joint2 = joints(connected_joints(2), :);
    
    v(m, :) = joint2 - joint1;
    r(m) = norm(v(m, :));
end
% v will be vector containing the member's locations
% r will be array containing the member's lengths



