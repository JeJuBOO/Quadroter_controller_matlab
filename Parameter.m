function param = Parameter()

m = 0.468;  % weight (kg)
g = 9.81;   % gravitational constant (m/s^2)
L = 0.225; % distance between the rotor and the center of mass of the quadcopter
k = 2.980e-6; %lift constant
b = 1.140e-7; 
I_m = 3.357e-5; %inertia moment of the rotor 
I = [4.856e-3,        0,         0;  % inertial tensor in m^2 kg
     0,        4.856e-3,         0;
     0,               0,  8.801e-3];
A = [0.25,        0,         0;  %  drag force coefficients for velocities of inertial frame
     0,        0.25,         0;
     0,           0,      0.25];

param.m = m;
param.g = g;
param.L = L;
param.k = k;
param.b = b;
param.I_m = I_m;
param.I    = I;
param.inv_I = inv(I);
param.A = A;

end