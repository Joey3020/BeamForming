function E_t = E_theta(theta, phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,num)

N_theta =0;
L_phi=0;

for m = 1:1:num
    for n = 1:1:num
        N_theta = N_theta + (Js_x(m,n) .* cos(theta)' .* cos(phi) + Js_y(m,n) .* cos(theta)' .* sin(phi)).*...
                  exp(1i*k*( (m - num/2)/num * a * sin(theta)' .* cos(phi) + (n - num/2)/num * b * sin(theta)' .* sin(phi))) * (a/num) * (b/num);
        L_phi = L_phi + ( - Ms_x(m,n) .* sin(phi) + Ms_y(m,n) .* cos(phi)).*...
                exp(1i*k*( (m - num/2)/num * a * sin(theta)' .* cos(phi) + (n - num/2)/num * b * sin(theta)'.*sin(phi))) * (a/num) * (b/num) ;
    end
end

E_t = L_phi + N_theta*(120*pi());

end