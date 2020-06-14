    %grounded ?¼ ê²½ìš° Js_x Js_yë¥? 0?œ¼ë¡? ?‘ë©? ?¨
%open aperture?¼ ê²½ìš°?Š” Js_x, Js_y?„ ?“°ë©? ?¨
%Pr êµ¬í•˜?Š” ë¶?ë¶? optimize ?•¨

function D = get_D_aperture(Ex, Ey, Hx, Hy, a, b, R, k, num)
    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);

    %E theta field
    [E_theta, E_phi] = get_E(theta, phi, Ex, Ey, Hx, Hy, a, b, R, k, num);
    D = get_D_space(E_theta, E_phi, num);
end