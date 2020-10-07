ti= 0:0.0001:2;
x=zeros(1,length(ti));
i=0;
for t= ti
    i=i+1;
    x(i) = Jounce_pos(t);
end
plot(ti,x)


 function pos = Jounce_pos(t)
        a=1; b=0.5;
       if t >= 0 && t <= b
           pos = a*sin(pi*t/b);
       elseif t >= b && t <= 3*b
           pos = -a*sin(pi*t/(2*b)-pi/2);
       else
           pos = a*sin(pi*t/b-3*pi);
       end
    end
