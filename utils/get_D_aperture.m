    %grounded ?¼ ê²½ìš° Js_x Js_yë¥? 0?œ¼ë¡? ?‘ë©? ?¨
%open aperture?¼ ê²½ìš°?Š” Js_x, Js_y?„ ?“°ë©? ?¨
%Pr êµ¬í•˜?Š” ë¶?ë¶? optimize ?•¨

function D = get_D_aperture(Ex, Ey, Hx, Hy, a, b, R, k, num)

    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);

    %E theta field
    [E_theta, E_phi] = get_E(theta, phi, Ex, Ey, Hx, Hy, a, b, R, k, num);

    %total E field
    E_total_square = abs(E_theta) .* abs(E_theta)  +  abs(E_phi) .* abs(E_phi);
    
    %total radiated power
    U = E_total_square .* sin(theta)';
    Pr = sum(sum(U));
    Pr = Pr * pi() * pi() / (num * num); % 2pi/num  * pi/2/num
    
    D = 10 * log10( 4 * pi() * E_total_square ./ Pr);

end