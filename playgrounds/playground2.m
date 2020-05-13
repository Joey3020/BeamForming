
num = 64;
E = half_dipole_space(num);
E_total_square = E .* E;
blue = [0.0, 0.0, 1.0];

theta = linspace(0, pi()/2, num);

%total radiated power
U = E_total_square .* sin(theta)';
Pr = sum(sum(U));
Pr = Pr * pi() * pi() / (num * num) * 2;

D = 4 * pi() * E_total_square ./ Pr;
maxD = max(max(D));
plot_D(D, blue);