function y = E_theta_zx(angle_azithumal, angle_horizontal, Js_z, Js_x, Ms_z, Ms_x,c,a,k,Num)

N_azithumal =0;
L_horizontal=0;

for m = 1:1:Num
    for n = 1:1:Num
        N_azithumal = N_azithumal + (Js_x(m,n)*cos(angle_azithumal).'*cos(angle_horizontal)-Js_z(m,n)*sin(angle_azithumal)').*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(a/Num)*(c/Num);
        L_horizontal =L_horizontal + ((-1)*Ms_x(m,n)*sin(angle_horizontal)).*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(a/Num)*(c/Num);
    end
end

y=L_horizontal+N_azithumal*(120*pi());

end