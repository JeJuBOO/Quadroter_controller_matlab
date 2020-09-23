function T = thrust(input_omega, k)
% Inputs are values for ¥øi

T = [0; 0; k * sum(input_omega)];
end