clear
close all
% time, in seconds1`io
start_time = 0;
end_time = 12;
dt = 0.0001;
times = start_time:dt:end_time;
addpath('trajectories')

% trajectory generator

trajectory = @diamond;

%start state
start_D = trajectory(0);
state_0 = initial_state(start_D.pos,0); 
state = state_0;
% state_D = desired_state();

param = Parameter();
s_save = zeros(12,1);
input_omega_save = zeros(4,1);


iter = 0;
for t = times
    iter = iter + 1;
    
    state_D = trajectory(t);
    
    input_omega = controller(state,state_D,param);
    
  
    state = rk4(state, input_omega, dt, param);
    
    
    s_save(:,iter) = state;
    input_omega_save(:,iter) = sqrt(input_omega);

end
N = numel(times);

figure(1)
subplot(3,1,1);
plot(times,input_omega_save(1,:),times,input_omega_save(2,:),times,input_omega_save(3,:),times,input_omega_save(4,:))
title('\fontsize{15}Control omega ��_{i}')
xlabel('Time t(s)')
ylabel('Control omega ��_{i} (rad/s)')
legend('��_{1}','��_{2}','��_{3}','��_{4}')
grid on

subplot(3,1,2);
plot(times,rad2deg(s_save(7,:)), times,rad2deg(s_save(8,:)), times,rad2deg(s_save(9,:)))
title('\fontsize{15}Angles ��,��,��')
xlabel('Time t(s)')
ylabel('Angles')
legend('��','��','��')
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