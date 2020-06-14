function [Exa, Eya, Hxa, Hya] = metasurface_phase_shift(Exa, Eya, Hxa, Hya, A, B, s_angle)
    
    [num, num] = size(Exa);
    
    phase = linspace(0, - k * A * sin(s_angle), num)';
    exp_ = exp(1i * phase);
    
    Exa = Exa .* exp_;
    Eya = Eya .* exp_;
    Hxa = Hxa .* exp_;
    Hya = Hya .* exp_;
    
end