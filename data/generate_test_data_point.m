function [data, label] = generate_test_data_point(a, b, phase_max, R, k, num)
    
    data = double.empty();
    label = [a, b, phase_max];
    n0 = 120 * pi();
    
    for i = 0:1:3
        phase = phase_max / 3 * i;
        [Exa, Eya] = uniform_aperture_field(phase, a, b, k, num);
        D = get_D_aperture(Exa, Eya, -Eya / n0, Exa / n0, a, b, R, k, num);
        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end