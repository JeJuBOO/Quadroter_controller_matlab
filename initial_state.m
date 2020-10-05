function [ s ] = initial_state( start, yaw )
%INIT_STATE Initialize 12 x 1 state vector

s     = zeros(12,1);

s(1)  = start(1); %x
s(2)  = start(2); %y
s(3)  = start(3); %z
s(4)  = 0;        %x_dot
s(5)  = 0;        %y_dot
s(6)  = 0;        %z_dot
s(7)  = deg2rad(10);       %phi
s(8)  = deg2rad(10);       %theta
s(9)  = deg2rad(10);       %psi
s(10) = 0;        %phi_dot
s(11) = 0;        %theta_dot
s(12) = 0;        %psi_dot

end