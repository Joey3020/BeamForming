function out = pos_filter(x)
    mask = x>=0;
    out = x .* mask;
end