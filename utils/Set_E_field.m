function [Ex_xy, Ey_xy] = Set_E_field(mode_xy, phi, a, b, num)

if mode_xy == 0
    Ex_magnitude_xy = ones(num);
    Ey_magnitude_xy = zeros(num);
elseif mode_xy == 1
    q=0 : b/(num-1) : b;
    Ex_magnitude_xy = sin(pi()/b*(q-b/2))'.*ones(num); 
    Ey_magnitude_xy = zeros(num);
elseif mode_xy == 2
    q=0 : a/(num-1) : a;
    r=0 : b/(num-1) : b;
    Ex_magnitude_xy = 1/b * cos(pi()/a*(q-a/2))'.*sin(pi()/b*(r-b/2))'.*ones(num);
    Ey_magnitude_xy = (-1) * 1/a * sin(pi()/a*(q-a/2))'.*cos(pi()/b*(r-b/2))'.*ones(num);
elseif mode_xy == 3
    q=0 : b/(num-1) : b;
    Ex_magnitude_xy = sin(2*pi()/b*(q-b/2))'.*ones(num); 
    Ey_magnitude_xy = zeros(num);
else
    q=0 : a/(num-1) : a;
    r=0 : b/(num-1) : b;
    Ex_magnitude_xy = 2/b * cos(pi()/a*(q-a/2))'.*sin(2*pi()/b*(r-b/2))'.*ones(num);
    Ey_magnitude_xy = (-1) * 1/a * sin(pi()/a*(q-a/2))'.*cos(2*pi()/b*(r-b/2))'.*ones(num);
end


Phase_angle_xy = zeros(num);

for i = 1 : num
    for j = 1 : num
        Phase_angle_xy(i,j) = i * phi ;
    end
end
Phase_angle_xy=reshape(Phase_angle_xy,num,num)';

Phase_exponential_xy = exp(1i*Phase_angle_xy);
Ex_xy = Ex_magnitude_xy.*Phase_exponential_xy;
Ey_xy = Ey_magnitude_xy.*Phase_exponential_xy;
end

