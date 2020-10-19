function omega_B = omega_N2B(omega_N, ang_N)
omega_B = [1               0                -sin(ang_N(2));
         0   cos(ang_N(1))   cos(ang_N(2))*sin(ang_N(1));
         0  -sin(ang_N(1))   cos(ang_N(2))*cos(ang_N(1))]*omega_N;

end