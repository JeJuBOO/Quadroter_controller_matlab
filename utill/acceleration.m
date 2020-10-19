function acc_N = acceleration(input_omega, ang_N, vel_N, Thrust, param)

gravity = [0; 0; -param.g];
R = rotation(ang_N);
T = R * thrust(input_omega, param.k);
% T = R * Thrust*[0;0;1];
Fd = param.A * vel_N;
acc_N = gravity + (1 / param.m)*T - Fd;

end