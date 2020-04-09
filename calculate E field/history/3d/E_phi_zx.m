function y = E_phi_zx(angle_azithumal, angle_horizontal, Js_z, Js_x, Ms_z, Ms_x,c,a,k,Num)

N_horizontal=0;
L_azithumal=0;

for m = 1:1:Num
    for n = 1:1:Num
        N_horizontal =N_horizontal + ((-1)*Js_x(m,n)*sin(angle_horizontal)).*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(a/Num)*(c/Num) ;
        L_azithumal =L_azithumal + (Ms_x(m,n)*cos(angle_azithumal).'*cos(angle_horizontal) - Ms_z(m,n)*sin(angle_azithumal)').*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*c*cos(angle_azithumal)'))*(a/Num)*(c/Num);
    end
end

y=(-1)*L_azithumal + N_horizontal*(120*pi());

end