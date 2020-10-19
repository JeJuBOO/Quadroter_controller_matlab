function omega_N = omega_B2N(omega_B, ang_N)
S_x=sin(ang_N(1));  T_y=tan(ang_N(2));  
C_x=cos(ang_N(1));  C_y=cos(ang_N(2));  

omega_N = [1  S_x*T_y      C_x*T_y;
           0  C_x          -S_x;
           0  S_x/C_y      C_x/C_y]*omega_B;
end