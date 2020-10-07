function [s_D] = Stabilisation(t)
% Hover trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

if t <= 0
    pos = [0;0;0];
    vel = [0;0;0];
    acc = [0;0;0];
else
    pos = [10;10;10];
    vel = [0;0;0];
    acc = [0;0;0];
end

yaw = 0;
yawdot = 0;
% =================== Your code ends here ===================


s_D.pos = pos(:);
s_D.vel = vel(:);
s_D.acc = acc(:);
s_D.ang_psi = yaw;
s_D.ome_psi = yawdot;

end