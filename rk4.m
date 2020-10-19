function state = rk4(state, input_omega,Thrust,torq, dt, param)
    k1 = quad_dyn(input_omega, state,Thrust,torq, param)*dt;
    k2 = quad_dyn(input_omega, state + 0.5*k1,Thrust,torq, param)*dt;
    k3 = quad_dyn(input_omega, state + 0.5*k2,Thrust,torq, param)*dt;
    k4 = quad_dyn(input_omega, state + k3,Thrust,torq, param)*dt;
    
    state = state + (k1 + 2.*(k2+k3) + k4)./6.0;
end