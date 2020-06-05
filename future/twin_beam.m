

%generation of twin beams

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
%ratio = 하나의 픽셀을 두개로 나눴을때, 각각에 들어가는 전기장 비율
%twin beam을 형성하기는 했으나, 이 ratio parameter을 정하는 것 외에는 아직 
%beam의 사이즈를 결정하는 방법을 찾지는 못함.
ratio = 0.5;

theta_x = pi()/8;
phase_x = linspace(0, k * a * sin(theta_x), num);
theta_y = pi()/8;
phase_y = linspace(0, k * b * sin(theta_y), num);

exp_x = exp(1i * phase_x)';
exp_y = exp(1i * phase_y);
exp_ = exp_x * exp_y;

Exa = ratio * Exa .* exp_x + (1 - ratio) * Exa .* exp_y;
Eya = ratio * Eya .* exp_x + (1 - ratio) * Eya .* exp_y;

[E_theta, E_phi] = get_E(theta, phi, Exa, Eya, -Eya/n0, Exa/n0, a, b, R, k, num);
D = get_D_space(E_theta, E_phi, num);
plot_D(D, [1.0, 0.0, 0.0]);

max_D = max(max(D));
