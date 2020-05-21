function [Ex_xy, Ey_xy] = uniform_aperture_field(phi, a, b, k, num)

    Ex_magnitude_xy = ones(num, num);
    Ey_magnitude_xy = zeros(num, num);

    Phase_angle_xy = zeros(num, num);
    
    phase = - k * a / num * phi;
    
    for i = 1 : num
        for j = 1 : num
            Phase_angle_xy(i,j) = i * phase ;
        end
    end
    
    Phase_exponential_xy = exp(1i*Phase_angle_xy);
    Ex_xy = Ex_magnitude_xy.*Phase_exponential_xy;
    Ey_xy = Ey_magnitude_xy.*Phase_exponential_xy;
    
end