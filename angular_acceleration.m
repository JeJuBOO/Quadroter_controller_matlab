function omegadot_B = angular_acceleration(input_omega, omega_B, param)
tau = torques(input_omega, param.L, param.b, param.k);
omegadot_B = param.I \ (tau - cross(omega_B, param.I * omega_B));
%inv(I) * (tau - cross(omega, I * omega)-cross(I_r*omega , omega_ziro))

end