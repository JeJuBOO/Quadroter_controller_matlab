clear
close all
% time, in seconds1`io
start_time = 0;
end_time = 12;
dt = 0.0001;
times = start_time:dt:end_time;
addpath('trajectories')
addpath('utill')

% trajectory generator

trajectory = @diamond;

%start state
start_D = trajectory(0);
state_0 = initial_state(start_D.pos,0); 
state = state_0;
% state_D = desired_state();
s_acc = start_D.acc;
param = Parameter();
traj_save = zeros(3,1);
s_save = zeros(12,1);
input_omega_save = zeros(4,1);


iter = 0;
for t = times
    iter = iter + 1;
    
    state_D = trajectory(t);
    
    [input_omega,Thrust,torq] = controller(state,state_D,param,dt);
   
    % state = [position_N;vel_N;ang_N;omega_B];
    state = rk4(state, input_omega,Thrust,torq, dt, param);
    
    
    traj_save(:,iter) = state_D.pos;
    s_save(:,iter) = state;
    input_omega_save(:,iter) = sqrt(input_omega);

end
N = numel(times);

figure(1)
subplot(3,1,1);
plot(times,input_omega_save(1,:),times,input_omega_save(2,:),times,input_omega_save(3,:),times,input_omega_save(4,:))
title('\fontsize{15}Control omega 企_{i}')
xlabel('Time t(s)')
ylabel('Control omega 企_{i} (rad/s)')
legend('企_{1}','企_{2}','企_{3}','企_{4}')
grid on

subplot(3,1,2);
plot(times,rad2deg(s_save(7,:)), times,rad2deg(s_save(8,:)), times,rad2deg(s_save(9,:)))
title('\fontsize{15}Angles 仰,亥,份')
xlabel('Time t(s)')
ylabel('Angles')
legend('仰','亥','份')
grid on

subplot(3,1,3);
plot(times,s_save(1,:), times,s_save(2,:), times,s_save(3,:))
title('\fontsize{15}Positions x,y,z')
xlabel('Time t (s)')
ylabel('Position (m)')
legend('x','y','z')
grid on

figure(2)
plot3(s_save(1,:),s_save(2,:),s_save(3,:))
hold on
plot3(traj_save(1,:),traj_save(2,:),traj_save(3,:),":r")
title('\fontsize{15}Positions x,y,z')

hold off


