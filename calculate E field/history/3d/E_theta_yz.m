function y = E_theta_yz(angle_azithumal, angle_horizontal, Js_y, Js_z, Ms_y, Ms_z,b,c,k,Num)

N_azithumal =0;
L_horizontal=0;

for m = 1:1:Num
    for n = 1:1:Num
        N_azithumal = N_azithumal + (Js_y(m,n)*cos(angle_azithumal).'*sin(angle_horizontal)-Js_z(m,n)*sin(angle_azithumal)').*exp(1i*k*((m-Num/2)/Num*b*sin(angle_azithumal).'*sin(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(b/Num)*(c/Num);
        L_horizontal =L_horizontal + (Ms_y(m,n)*cos(angle_horizontal)).*exp(1i*k*((m-Num/2)/Num*b*sin(angle_azithumal).'*sin(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(b/Num)*(c/Num) ;
    end
end

y=L_horizontal+N_azithumal*(120*pi());

end