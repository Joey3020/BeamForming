function [E_theta, E_phi] = show_E_field(Exa, Eya ,a,b,k,num)

Ms_x = Eya;
Ms_y = (-1)*Exa;
Js_x = (-1)*Exa./(120*pi());
Js_y = (-1)*Eya./(120*pi());

phi = 0:2*pi()/(num-1):2*pi();
theta = 0:pi()/2/(num-1):pi()/2;

E_theta = E_theta_xy(theta, phi, Js_x,  Js_y, Ms_x, Ms_y, a, b, k, num);
E_phi = E_phi_xy(theta, phi, Js_x,  Js_y, Ms_x, Ms_y, a, b, k, num);