function E_p = E_phi(theta, phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,num)

    N_horizontal=0;
    L_azithumal=0;

    for m = 1:1:num
        for n = 1:1:num
            N_horizontal = N_horizontal + ( - Js_x(m,n) * sin(phi) + Js_y(m,n) * cos(phi)).*...
                            exp(1i*k*( (m - num/2)/num * a * sin(theta)' .* cos(phi) + (n - num/2)/num * b * sin(theta)'.*sin(phi)))...
                            * (a/num) * (b/num) ;
            L_azithumal = L_azithumal + ( Ms_x(m,n) * cos(theta)' .* cos(phi) + Ms_y(m,n)*cos(theta).'*sin(phi)).*...
                            exp(1i*k*( (m - num/2)/num * a * sin(theta)' .* cos(phi) + (n - num/2)/num * b * sin(theta)'.*sin(phi)))...
                            *(a/num)*(b/num);
        end
    end

    E_p=(-1)*L_azithumal + N_horizontal*(120*pi());

end