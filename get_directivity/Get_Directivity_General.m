%grounded 일 경우 Js_x Js_y를 0으로 두면 됨
%open aperture일 경우는 Js_x, Js_y도 쓰면 됨
%Pr 구하는 부분 optimize 함

function D = Get_Directivity_General(Ex, Ey, Hx, Hy, a, b, lamda, num)

    %Equivalent of aperture
    %open aperture
    Ms_x = Ey;
    Ms_y = (-1)*Ex; 
    Js_x = - Hy;
    Js_y = Hx;

    k = 2*pi() / lamda;

    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);

    %E theta field
    E_t = E_theta(theta, phi, Js_x, Js_y, Ms_x, Ms_y, a, b, k, num);

    %E phi field ( H field * 120pi())
    E_p = E_phi(theta, phi, Js_x, Js_y, Ms_x, Ms_y, a, b, k, num);

    %total E field
    E_total = sqrt(abs(E_t) .* abs(E_t)  +  abs(E_p) .* abs(E_p));
    
    
    %total radiated power
    U = E_total .* E_total .* sin(theta)';
    Pr = sum(sum(U));
    Pr = Pr * pi() * pi() / (num * num); % 2pi/num  * pi/2/num
    
    %fprintf('max E : %f\n', max(max(E_total .* E_total / (a*b))));
    %fprintf('Pr : %f\n', Pr);
    
    %Directivity
    D = 10 * log10( 4 * pi() * E_total.*E_total./Pr);

end