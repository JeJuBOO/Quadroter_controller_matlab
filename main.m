clear
% time, in seconds
start_time = 0;
end_time = 2;
dt = 0.0001;
times = start_time:dt:end_time;

position_N = [0; 0; 0];
vel_N = zeros(3, 1);
ang_N = zeros(3, 1);
omega_N = zeros(3, 1);

state = [position_N;ang_N;vel_N;omega_N];

param = Parameter();
s_D = [0 0 10 0 0 10 0 0 0 0 0 0];
for t = times

[input_omega,Thrust,torq] = controller(s_D,state,param);

% Take input from our controller.°¢¼Óµµ
i = input_omega;

omega_B = omega_N2B(omega_N, ang_N);

% Compute linear and angular accelerations.
a = acceleration(i, ang_N, vel_N, param.m, param.g, param.k, param.b);
omegadot_B = angular_acceleration(i, omega_B, param.I, param.L, param.b, param.k);

omega_B = omega_B + dt * omegadot_B;
omega_N = omega_B2N(omega_B, ang_N);
ang_N = ang_N + dt * omega_N;
vel_N = vel_N + dt * a;
position_N = position_N + dt * vel_N;

end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    