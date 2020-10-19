function [ control_int ] = control_rk4(Element, dt)
    k1 = Element*dt;
    k2 = Element + 0.5*k1*dt;
    k3 = Element + 0.5*k2*dt;
    k4 = Element + k3*dt;
    
    control_int = Element + (k1 + 2.*(k2+k3) + k4).*dt/6.0;
end