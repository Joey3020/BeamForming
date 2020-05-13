function Y = modify_phase(X, phase_label, num)
    phase = zeros(num);
    for i = 1:1:num
        for j = 1:1:num
            phase(i, j) = phase_label * i;
        end
    end
    Y = abs(X) .* exp(1i * phase);
end