function tau = torques(input_omega, L, b, k)
% Inputs are values for ¥øi
tau = [L * k * (-input_omega(2)^2 + input_omega(4)^2)
       L * k * (-input_omega(1)^2 + input_omega(3)^2)
       b * (-input_omega(1)^2 + input_omega(2)^2 - input_omega(3)^2 + input_omega(4)^2)];
end