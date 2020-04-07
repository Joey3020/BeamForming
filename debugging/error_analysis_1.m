
Exa_xy = input('Ex_xy = 1 if exist, otherwise 0 : ');
Eya_xy = input('Ey_xy = 1 if exist, otherwise 0 : ');
Eya_yz = input('Ey_yz = 1 if exist, otherwise 0 : ');
Eza_yz = input('Ez_yz = 1 if exist, otherwise 0 : ');
Eza_zx = input('Ez_zx = 1 if exist, otherwise 0 : ');
Exa_zx = input('Ex_zx = 1 if exist, otherwise 0 : ');

mode_xy = input('is xy TE10 = 1 if yes, otherwise 0 : ');
mode_yz = input('is yz TE10 = 1 if yes, otherwise 0 : ');
mode_zx = input('is zx TE10 = 1 if yes, otherwise 0 : ');

a_range = input('range of aperture length x : ');
b_range = input('range of aperture length y : ');
c_range = input('range of aperture length z : ');
lamda = input('enter wavelength: ');
num = input('order of your square matrix for aperture field: ');

[ Dmax, Dmax_reverse, Dmax_error, Dmax_relative_error, Direct, Direct_reverse] ...
         = debugger_1(Exa_xy, Eya_xy, Eya_yz, Eza_yz, Eza_zx, Exa_zx, ...
                      mode_xy, mode_yz, mode_zx, ...
                      a_range, b_range, c_range, lamda, num);