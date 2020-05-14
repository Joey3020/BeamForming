
num = 64;
green = [0.0, 1.0, 0.0];

A = 25;
B = 25;

lambda = 1;
k = 2 * pi() / lambda;
R = 10;

for a = 3:1:5
    for b = 3:1:5
        for d = 3:1:5
            for i = 1:1:5
                phase = pi() / 4 / i;
                [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture2(A, B, a, b, d, phase, k, num);
                D = get_D_aperture(Exa, Eya, Hxa, Hya, A, B, R, k, num);
                fig = figure((a-3) * 27 + (b-3) * 9 + (d - 3)* 3 + i);
                plot_D(D, green);
                hold off
            end
        end
    end
end