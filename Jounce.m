function [s_D] = Jounce(t)
% Jounce trajectory generator for a diamond

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

time_tol = 2;
dt = 0.0001;

    function pos = Jounce_pos(t)
        a=1; b=0.5;
       if t >= 0 && t <= b
           pos = [0; 0; a*sin(pi*t/b)];
       elseif t >= b && t <= 3*b
           pos = [0; 0; -a*sin(pi*t/b-pi)];
       else
           pos = [0; 0; a*sin(pi*t/b-3*pi)];
       end
    end

        

if t >= time_tol
    pos = [0;0;1];
    vel = [0;0;0];
    acc = [0;0;0];
else
    pos = Jounce_pos(t);
    pos_dt = Jounce_pos(t+dt);
    pos_2dt = Jounce_pos(t+(2*dt));
    vel = (pos_dt-pos)/dt;
    vel_dt = (pos_2dt-pos_dt)/dt;
    acc = (vel_dt-vel)/dt;
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