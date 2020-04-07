Exa_xy = input('Ex_xy = 1 if exist, otherwise 0 : ');
%Eya_xy = input('Ey_xy = 1 if exist, otherwise 0 : ');
%Eya_yz = input('Ey_yz = 1 if exist, otherwise 0 : ');
%Eza_yz = input('Ez_yz = 1 if exist, otherwise 0 : ');
%Eza_zx = input('Ez_zx = 1 if exist, otherwise 0 : ');
%Exa_zx = input('Ex_zx = 1 if exist, otherwise 0 : ');

mode_xy = input('uniform : 0, TE10 : 1, TE11 : 2, TE02 : 3, TE12 : 4 ');
%mode_yz = input('is yz TE10 = 1 if yes, otherwise 0 : ');
%mode_zx = input('is zx TE10 = 1 if yes, otherwise 0 : ');

a_range = input('range of aperture length x : ');
b_range = input('range of aperture length y : ');
%c_range = input('range of aperture length z : ');
lamda = input('enter wavelength: ');
%num = input('order of your square matrix for aperture field: ');
num=32;
%[Ex_xy, Direct] = getdata_DL(Exa_xy, Eya_xy = , Eya_yz, Eza_yz, Eza_zx, Exa_zx, ...
%                    mode_xy, mode_yz, mode_zx, ...
%                    a_range, b_range, c_range, lamda, num);
[ data, labels_E, labels_ab, labels_mode, labels_phase ]...
 = DL_generate_traindata(Exa_xy, 0 , 0, 0, 0, 0, mode_xy, 0, 0, a_range, b_range, 1, lamda, num);


filename = 'C:\Users\User\Documents\MATLAB\DL_data\train_data.xlsx';
writematrix(data, filename, 'Sheet', 1);
writematrix(labels_ab, filename, 'Sheet', 2);
writematrix(labels_mode, filename, 'Sheet', 3);
writematrix(labels_phase, filename, 'Sheet', 4);
writematrix(labels_E, filename, 'Sheet', 5);
