function [input_omega,Thrust,torq] = Z_controller(s,s_D,param,~) 
%input data : 
% s = [pos, vel, ang, omega]'
% s_D = [pos, vel, acc, ang_psi, ome_psi]'
% output data :
% input_omega = [omega_1 , omega_2 , omega_3 , omega_4]'

%%%고도 자세


% Parameters of the PD controller
K_zD = 2;
K_D = [1 ; 1 ; 1];  

K_P = [1 ; 1 ; 1];

K_zP = 1.85;

% a = s_D.acc + param.A*s_D.vel/param.m;
% a = K_P.*(s_D.pos-s(1:3)) + K_D.*(s_D.vel-s(4:6));
% a = K_P.*(s_D.pos-s(1:3)) + K_D.*(s_D.vel-s(4:6)) + K_DD.*(s_D.acc-[0;0;0]);
% 
% s_D.ang(1) = asin( (a(1)*sin(s_D.ang(3)) - a(2)*cos(s_D.ang(3))) / ...
%     sqrt(a(1)^2+a(2)^2+(a(3)+param.g)^2));
% s_D.ang(2) = atan( (a(1)*cos(s_D.ang(3))+a(2)*sin(s_D.ang(3))) /...
%     (a(3)+param.g));




Thrust = param.m/(cos(s(7))*cos(s(8))) * (param.g + K_zD*(s_D.vel(3) - s(6)) + K_zP*(s_D.pos(3)-s(3)));
torq = param.I*( K_P.*(s_D.ang - s(7:9)) + K_D.*(s_D.ome - s(10:12)) );

M = [0                -param.L*param.k   0                 param.L*param.k;...
    -param.L*param.k  0                  param.L*param.k   0;...
    -param.b          param.b            -param.b          param.b;...
    param.k           param.k            param.k           param.k];

input_omega = M^(-1) *  [torq ; Thrust ];

end