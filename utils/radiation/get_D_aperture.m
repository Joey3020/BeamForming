    %grounded ?�� 경우 Js_x Js_y�? 0?���? ?���? ?��
%open aperture?�� 경우?�� Js_x, Js_y?�� ?���? ?��
%Pr 구하?�� �?�? optimize ?��

function D = get_D_aperture(Ex, Ey, Hx, Hy, a, b, R, k, num)
    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);

    %E theta field
    [E_theta, E_phi] = get_E(theta, phi, Ex, Ey, Hx, Hy, a, b, R, k, num);
    D = get_D_space(E_theta, E_phi, num);
end