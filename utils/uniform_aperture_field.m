function [Ex, Ey] = uniform_aperture_field(phi, a, b, k, num)

    Ex = zeros(num, num);
    Ey = ones(num, num);
    
    phase = linspace(0, k * a * sin(phi), num);
    exp_ = exp(1i * phase)';
    
    Ex = Ex .* exp_;
    Ey = Ey .* exp_;
    
end