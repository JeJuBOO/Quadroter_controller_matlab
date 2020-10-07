function [input_omega,Thrust,torq] = PID_controller(s,s_D,param,dt) 
%input data : 
% s = [pos, vel, ang, omega_b]'
% s_D = [pos, vel, acc, ang_psi, ome_psi]'
% output data :
% input_omega = [omega_1 , omega_2 , omega_3 , omega_4]'



% Parameters of the PD controller
K_P_pos = [1 ; 1 ; 1];
K_P_ang = [20 ; 20 ; 10];

K_I_pos = [0.5 ; 0.5 ; 0.5];
K_I_ang = [1 ; 1 ; 10];

K_D_pos = [5 ; 5 ; 5];
K_D_ang = [10 ; 10 ; 20];  


%error 
e_pos = s_D.pos-s(1:3);
e_vel = s_D.vel-s(4:6);

P_int = control_rk4(e_pos, dt);

% position PID Control
d = K_P_pos.*e_pos + K_I_pos.*P_int + K_D_pos.*e_vel;



ang_phi_D = asin( (d(1)*sin(s_D.ang_psi) - d(2)*cos(s_D.ang_psi)) / ...
     sqrt(d(1)^2 + d(2)^2+(d(3)+param.g)^2));
ang_the_D = atan( (d(1)*cos(s_D.ang_psi) + d(2)*sin(s_D.ang_psi)) /...
    (d(3)+param.g));

s_D.ang = [ang_phi_D ; ang_the_D ; s_D.ang_psi];
s_D.ome = [0 ; 0 ; s_D.ome_psi];

e_ang = s_D.ang-s(7:9);
e_ome = s_D.ome-s(10:12);

A_int = control_rk4(e_ang, dt);

S_x=sin(ang_phi_D);  S_y=sin(ang_the_D);  S_z=sin(s_D.ang_psi);
C_x=cos(ang_phi_D);  C_y=cos(ang_the_D);  C_z=cos(s_D.ang_psi);

Thrust = param.m*(d(1)*(S_y*C_z*C_x+S_z*S_x)+d(2)*(S_y*S_z*C_x-C_z*S_x)+(d(3)+param.g)*C_y*C_x);
torq = param.I*( K_P_ang.*(e_ang) + K_I_ang.*A_int + K_D_ang.*(e_ome));


M = [0                -param.L*param.k   0                 param.L*param.k;...
    -param.L*param.k  0                  param.L*param.k   0;...
    -param.b          param.b            -param.b          param.b;...
    param.k           param.k            param.k           param.k];

input_omega = M^(-1) * [torq ; Thrust ];

end