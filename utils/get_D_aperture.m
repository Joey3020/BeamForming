%grounded 일 경우 Js_x Js_y를 0으로 두면 됨
%open aperture일 경우는 Js_x, Js_y도 쓰면 됨
%Pr 구하는 부분 optimize 함

function D = get_D_aperture(Ex, Ey, Hx, Hy, a, b, k, num)

    %Equivalent of aperture
    %open aperture
    Ms_x = Ey;
    Ms_y = - Ex; 
    Js_x = - Hy;
    Js_y = Hx;

    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);

    %E theta field
    [E_theta, E_phi] = get_E(theta, phi, Js_x, Js_y, Ms_x, Ms_y, a, b, k, num);

    %total E field
    E_total_square = abs(E_theta) .* abs(E_theta)  +  abs(E_phi) .* abs(E_phi);
    
    
    %total radiated power
    U = E_total_square .* sin(theta)';
    Pr = sum(sum(U));
    Pr = Pr * pi() * pi() / (num * num); % 2pi/num  * pi/2/num
    
    D = 10 * log10( 4 * pi() * E_total_square ./ Pr);

end