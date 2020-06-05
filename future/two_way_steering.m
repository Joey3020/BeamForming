

%stearing the beam to the x,y axis simultaneously

num = 64;
lambda = 1;
k = 2 * pi() / lambda;
n0 = 120 * pi();
R = 20;

theta = linspace(0, pi()/2, num);
phi = linspace(0, 2 * pi(), num);

Exa = ones(num, num);
Eya = zeros(num, num);

a = 3;
b = 3;

theta_x = pi()/8;
phase_x = linspace(0, k * a * sin(theta_x), num);
theta_y = pi()/8;
phase_y = linspace(0, k * b * sin(theta_y), num);

exp_ = exp(1i * phase_x)' * exp(1i * phase_y);
Exa = Exa .* exp_;
Eya = Eya .* exp_;


[E_theta, E_phi] = get_E(theta, phi, Exa, Eya, -Eya/n0, Exa/n0, a, b, R, k, num);
D = get_D_space(E_theta, E_phi, num);
plot_D(D, [1.0, 0.0, 0.0]);

max_D = max(max(D));