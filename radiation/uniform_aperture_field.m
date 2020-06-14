function [Ex, Ey] = uniform_aperture_field(s_angle, A, B, num)

    k = 2 * pi();
    
    Ex = ones(num, num);
    Ey = zeros(num, num);
    
    phase = linspace(0, - k * A * sin(s_angle), num)';
    exp_ = exp(1i * phase);
    
    Ex = Ex .* exp_;
    Ey = Ey .* exp_;
    
end