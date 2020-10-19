function omegadot_B = angular_acceleration(input_omega, omega_B, torq, param)

omega_B_syq = [0            -omega_B(3)   omega_B(2)
               omega_B(3)   0             -omega_B(1)
               -omega_B(2)  omega_B(1)    0         ];
tau = torques(input_omega, param.L, param.b, param.k);
omegadot_B = param.inv_I * (tau - omega_B_syq*param.I*omega_B);
% omegadot_B = param.inv_I * (tau - cross(omega_B, param.I * omega_B));
%inv(I) * (tau - cross(omega, I * omega)-cross(I_r*omega , omega_ziro))

end