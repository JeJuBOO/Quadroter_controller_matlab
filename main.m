clear
close all
% time, in seconds1`io
start_time = 0;
end_time = 30;
dt = 0.01;
times = start_time:dt:end_time;
addpath('trajectories')
addpath('utill')

% trajectory generator

trajectory = @Stabilisation;

%start state
start_D = trajectory(0);
state_0 = initial_state(start_D.pos,start_D.ang_psi);
state = state_0;
% state_D = desired_state();
param = Parameter();
traj_save = zeros(3,1);
s_save = zeros(12,1);
input_omega_save = zeros(4,1);
acc = state(4:6);


iter = 0;
for t = times
    iter = iter + 1;
    
    state_D = trajectory(t);
    
    [input_omega,Thrust,torq] = PID_controller(state,state_D,param,dt,acc);
    
    % state = [position_N;vel_N;ang_N;omega_B];
    state = rk4(state, input_omega,Thrust,torq, dt, param);
    
    acc = acceleration(input_omega, state(7:9), state(4:6), Thrust, param);
    
    traj_save(:,iter) = state_D.pos;
    s_save(:,iter) = state;
    input_omega_save(:,iter) = sqrt(input_omega);
    
end
N = numel(times);
% 
% figure()
% plot(times,input_omega_save(1,:),times,input_omega_save(2,:),times,input_omega_save(3,:),times,input_omega_save(4,:))
% % title('\fontsize{15}Control input ��_{i}'),xlabel('Time t(s)'),ylabel('Control omega ��_{i} (rad/s)'),legend('��_{1}','��_{2}','��_{3}','��_{4}')
% grid on
% 
% figure()
% subplot(3,1,1)
% plot(times,rad2deg(s_save(7,:)))
% % title('\fontsize{15}Angles ��,��,��'), xlabel('Time t(s)'), ylabel('Angles'), legend('��','��','��')
% grid on
% subplot(3,1,2)
% plot(times,rad2deg(s_save(8,:)))
% % title('\fontsize{15}Angles ��,��,��'), xlabel('Time t(s)'), ylabel('Angles'), legend('��','��','��')
% grid on
% subplot(3,1,3)
% plot(times,rad2deg(s_save(9,:)))
% % title('\fontsize{15}Angles ��,��,��'), xlabel('Time t(s)'), ylabel('Angles'), legend('��','��','��')
% grid on


figure()
subplot(3,1,1)
plot(times,s_save(1,:))
hold on
plot(times,traj_save(1,:))
% title('\fontsize{15}Positions x,y,z'), xlabel('Time t (s)'), ylabel('Position (m)'),legend('x','y','z')
grid on
subplot(3,1,2)
plot(times,s_save(2,:))
hold on
plot(times,traj_save(2,:))
% title('\fontsize{15}Positions x,y,z'), xlabel('Time t (s)'), ylabel('Position (m)'), legend('x','y','z')
grid on
subplot(3,1,3)
plot(times,s_save(3,:))
hold on
plot(times,traj_save(3,:))
% title('\fontsize{15}Positions x,y,z'), xlabel('Time t (s)'), ylabel('Position (m)'), legend('x','y','z')
grid on

% figure()
% plot3(s_save(1,:),s_save(2,:),s_save(3,:))
% hold on
% plot3(traj_save(1,:),traj_save(2,:),traj_save(3,:),":r")
% title('\fontsize{15}Positions x,y,z')
% grid on

hold off


