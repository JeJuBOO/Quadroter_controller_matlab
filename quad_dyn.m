function [ state_dot ] = quad_dyn( input_omega, state, param)

% s = [position_N;vel_N;ang_N;omega_B];
vel_N = state(4:6); ang_N = state(7:9); omega_B = state(10:12); 

acc_N = acceleration(input_omega, ang_N, vel_N, param);

omega_N = omega_B2N(omega_B,ang_N);

omegadot_B = angular_acceleration(input_omega, omega_B, param);

state_dot = [vel_N; acc_N; omega_N ; omegadot_B];
end