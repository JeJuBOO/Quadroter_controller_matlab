function [s_D] = state_D(s_D,param)
d = s_D.acc + param.A*s_D.vel/param.m;
ang_phi_D = asin( (d(1)*sin(s_D.ang_psi) - d(2)*cos(s_D.ang_psi)) / ...
                   d(1)^2+d(2)^2+(d(3)+param.g)^2);
ang_the_D = atan( (d(1)*cos(s_D.ang_psi)+d(2)*sin(s_D.ang_psi)) /...
                  (d(3)+param.g));
s_D.ang = [ang_phi_D ; ang_the_D ; s_D.ang_psi];
s_D.ome = [0 ; 0 ; s_D.ome_psi];

end                    