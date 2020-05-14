function [data, labels] = generate_train_data_point(A, B, a, b, d, theta_max, R, k, num)

    data = double.empty();
    labels = [a, b, d, theta_max];

    for i = 0:1:3
        phase = theta_max / 3 * i;
        [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture2(A, B, a, b, d, phase, k, num);
        D = get_D_aperture(Exa, Eya, Hxa, Hya, a, b, R, k, num);
        plot_D(D, [0.0, 1.0, 0.0]);

        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end