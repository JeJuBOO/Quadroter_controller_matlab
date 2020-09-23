function [ state_dot ] = quad_dyn( input_omega, state, param)

% s = [position_N;vel_N;ang_N;omega_N];
vel_N = state(4:6); ang_N = state(7:9); omega_N = state(10:12); 

a = acceleration(input_omega, ang_N, vel_N, param);

omega_B = omega_N2B(omega_N, ang_N);
omegadot_B = angular_acceleration(input_omega, omega_B, param);
omegadot_N = trans_ang_acc(state,omegadot_B,omega_B);

state_dot = [vel_N; a; omega_N ; omegadot_N];
