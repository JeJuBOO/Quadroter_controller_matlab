function state = rk4(state, input_omega, dt, param)
    k1 = quad_dyn(input_omega, state, param)*dt;
    k2 = quad_dyn(input_omega, state + 0.5*k1, param)*dt;
    k3 = quad_dyn(input_omega, state + 0.5*k2, param)*dt;
    k4 = quad_dyn(input_omega, state + k3, param)*dt;
    
    state = state + (k1 + 2.*(k2+k3) + k4)./6.0;
end