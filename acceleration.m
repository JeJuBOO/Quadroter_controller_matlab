function a = acceleration(input_omega, angles, xdot, param)

gravity = [0; 0; -param.g];
R = rotation(angles);
T = R * thrust(input_omega, param.k);
Fd = -param.A * xdot;
a = gravity + 1 / param.m * T + Fd;

end