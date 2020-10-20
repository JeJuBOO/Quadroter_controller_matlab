function [s_D] = diamond_pos(t)
% DIAMOND trajectory generator for a diamond

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

time_tol = 30;
dt = 0.0001;

    function [pos, vel] = get_pos_vel(t)
        if t >= time_tol
            pos = [1;0;0];
            vel = [0;0;0];
        elseif t >= 0 && t < time_tol/4
            pos = [1/4;sqrt(2);sqrt(2)];
            vel = [0;0;0];
        elseif t >= time_tol/4 && t < time_tol/2
            pos=[1/2;0;2*sqrt(2)];
            vel = [0;0;0];
        elseif t >= time_tol/2 && t < time_tol*3/4
            pos=[3/4; -sqrt(2); sqrt(2)];
            vel = [0;0;0];
        else
            pos=[1;0;0];
            vel = [0;0;0];
        end
    end
if t == 0
    pos = [0;0;0];
    vel = [0;0;0];
    acc = [0;0;0];
elseif t >= time_tol
    pos = [1;0;0];
    vel = [0;0;0];
    acc = [0;0;0];
else
    [pos, vel] = get_pos_vel(t);
    [~, vel1] = get_pos_vel(t+dt);
    acc = (vel1-vel)/dt;
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