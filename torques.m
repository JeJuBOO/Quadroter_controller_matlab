function tau = torques(input_omega, L, b, k)
% Inputs are values for ¥øi
tau = [L * k * (-input_omega(2) + input_omega(4))
       L * k * (-input_omega(1) + input_omega(3))
       b * (-input_omega(1) + input_omega(2) - input_omega(3) + input_omega(4))];

end