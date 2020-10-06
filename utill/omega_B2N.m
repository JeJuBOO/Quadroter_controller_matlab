function omega_N = omega_B2N(omega_B, ang_N)
omega_N = [1  sin(ang_N(1))*tan(ang_N(2)) cos(ang_N(1))*tan(ang_N(2));
           0  cos(ang_N(1))                            -sin(ang_N(1));
           0  sin(ang_N(1))/cos(ang_N(2)) cos(ang_N(1))/cos(ang_N(2))]*omega_B;
end