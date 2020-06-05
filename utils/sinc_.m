function out = sinc_(x)
    if abs(x) < 1e-12
        out = 1;
    else
        out = sin(x) / x;
    end
end