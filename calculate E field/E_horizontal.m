function y = E_horizontal(angle_azithumal, angle_horizontal, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)

N_horizontal=0;
L_azithumal=0;

for m = 1:1:Num
    for n = 1:1:Num
        N_horizontal =N_horizontal + (Js_x(m,n)*(-1)*sin(angle_horizontal)+Js_y(m,n)*cos(angle_horizontal)).*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*b*sin(angle_azithumal).'*sin(angle_horizontal)))*(a/Num)*(b/Num) ;
        L_azithumal =L_azithumal + (Ms_x(m,n)*cos(angle_azithumal).'*cos(angle_horizontal)+Ms_y(m,n)*cos(angle_azithumal).'*sin(angle_horizontal)).*exp(1i*k*((m-Num/2)/Num*a*sin(angle_azithumal).'*cos(angle_horizontal)+(n-Num/2)/Num*b*sin(angle_azithumal).'*sin(angle_horizontal)))*(a/Num)*(b/Num);
    end
end

y=(-1)*L_azithumal + N_horizontal*(120*pi());

end