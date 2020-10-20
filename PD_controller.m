function [input_omega,Thrust,torq] = PD_controller(s,s_D,param,~,~) 
%input data : 
% s = [pos, vel, ang, omega_b]'
% s_D = [pos, vel, acc, ang_psi, ome_psi]'
% output data :
% input_omega = [omega_1 , omega_2 , omega_3 , omega_4]'
s_D.ang = ones(3,1);
torq = zeros(3,1); d = zeros(3,1);
s(10:12)=omega_B2N(s(10:12),s(7:9));

% Parameters of the PD controller
K_P_pos = [3.9 ; 3.3; 3.8];
K_P_ang =[50 ; 50 ; 60];

K_D_pos = [3.1; 2.2; 3.6];
K_D_ang = [10 ; 10 ; 30];  

d(1) = K_P_pos(1).*(s_D.pos(1)-s(1)) + K_D_pos(1).*(s_D.vel(1)-s(4));

d(2) = K_P_pos(2).*(s_D.pos(2)-s(2)) + K_D_pos(2).*(s_D.vel(2)-s(5));

d(3) = K_P_pos(3).*(s_D.pos(3)-s(3)) + K_D_pos(3).*(s_D.vel(3)-s(6));

s_D.ang(1) = asin( (d(1)*sin(s_D.ang_psi) - d(2)*cos(s_D.ang_psi)) / ...
     sqrt(d(1)^2 + d(2)^2+(d(3)+param.g)^2));
s_D.ang(2)= atan( (d(1)*cos(s_D.ang_psi) + d(2)*sin(s_D.ang_psi)) /...
      (d(3)+param.g));
s_D.ang(3) = s_D.ang_psi;
s_D.ome = [0;0;s_D.ome_psi];

S_x=sin(s_D.ang(1));  S_y=sin(s_D.ang(2));  S_z=sin(s_D.ang(3));
C_x=cos(s_D.ang(1));  C_y=cos(s_D.ang(2));  C_z=cos(s_D.ang(3));

Thrust = param.m*(d(1)*(S_y*C_z*C_x+S_z*S_x)+d(2)*(S_y*S_z*C_x-C_z*S_x)+(d(3)+param.g)*C_y*C_x);
torq(1) = param.I(1,1)*( K_P_ang(1).*(s_D.ang(1) - s(7)) + K_D_ang(1).*(s_D.ome(1) - s(10)));
torq(2) = param.I(2,2)*( K_P_ang(2).*(s_D.ang(2) - s(8)) + K_D_ang(2).*(s_D.ome(2) - s(11)));
torq(3) = param.I(3,3)*( K_P_ang(3).*(s_D.ang(3) - s(9)) + K_D_ang(3).*(s_D.ome(3) - s(12)));


input_omega = [Thrust/(4*param.k)-torq(2)/(2*param.k*param.L)-torq(3)/(4*param.b)
               Thrust/(4*param.k)-torq(1)/(2*param.k*param.L)+torq(3)/(4*param.b)
               Thrust/(4*param.k)+torq(2)/(2*param.k*param.L)-torq(3)/(4*param.b)
               Thrust/(4*param.k)+torq(1)/(2*param.k*param.L)+torq(3)/(4*param.b)];
           
% M = [0                -param.L*param.k   0                 param.L*param.k;...
%     -param.L*param.k  0                  param.L*param.k   0;...
%     -param.b          param.b            -param.b          param.b;...
%     param.k           param.k            param.k           param.k];
% 
% input_omega = M \ [torq ; Thrust ];

end