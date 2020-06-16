profile on

a = 1;
b = 1;
phase = pi() / 4;

R = 10;
k = 2 * pi();
n0 = 120* pi();
num = 64;

a_test = 2;
b_test = 3;
[Exa, Eya] = uniform_aperture_field(phase, a_test, b_test, k, num);
D = get_D_aperture(Exa, Eya, -Eya / n0, Exa / n0, a_test, b_test, R, k, num);

[d_opt, A_opt, B_opt] = linesearch(D, a, b, phase, R, k, num);

profileStruct = profile('info');
[flopTotal,Details]  = FLOPS('linesearch','linesearchMAT',profileStruct);