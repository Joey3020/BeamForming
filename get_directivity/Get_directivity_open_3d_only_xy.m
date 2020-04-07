function D=Get_directivity_open_3d_only_xy(Ex_xy, Ey_xy,Ey_yz,Ez_yz,Ez_zx,Ex_zx,a,b,c,k,Num)

%Equivalent of aperture
%in open space

%xy plane
Ms_x_xy = Ey_xy;
Ms_y_xy = (-1)*Ex_xy;
Js_x_xy = (-1)*Ex_xy./(120*pi());
Js_y_xy = (-1)*Ey_xy./(120*pi());

%yz plane
Ms_y_yz = Ez_yz;
Ms_z_yz = (-1)*Ey_yz;
Js_y_yz = (-1)*Ey_yz./(120*pi());
Js_z_yz = (-1)*Ez_yz./(120*pi());

%zx plane
Ms_z_zx = Ex_zx;
Ms_x_zx = (-1)*Ez_zx;
Js_z_zx = (-1)*Ez_zx./(120*pi());
Js_x_zx = (-1)*Ex_zx./(120*pi());

%spherical coordinate variables
theta = 0:pi()/2/(Num-1):pi()/2;
phi= 0:2*pi()/(Num-1):2*pi();

%E theta field
E_t_xy = E_theta_xy(theta,phi, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy,a,b,k,Num);
E_t_yz = E_theta_yz(theta,phi, Js_y_yz, Js_z_yz, Ms_y_yz, Ms_z_yz,b,c,k,Num);
E_t_zx = E_theta_zx(theta,phi, Js_z_zx, Js_x_zx, Ms_z_zx, Ms_x_zx,c,a,k,Num);
E_t_yz_back = circshift(E_t_yz,Num/2,2);
E_t_zx_back = circshift(E_t_zx,Num/2,2);
E_t = E_t_xy + E_t_yz + E_t_zx + E_t_yz_back + E_t_zx_back;

%E phi field ( H field * 120pi())
E_p_xy = E_phi_xy(theta,phi, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy,a,b,k,Num);
E_p_yz = E_phi_yz(theta,phi, Js_y_yz, Js_z_yz, Ms_y_yz, Ms_z_yz,b,c,k,Num);
E_p_zx = E_phi_zx(theta,phi, Js_z_zx, Js_x_zx, Ms_z_zx, Ms_x_zx,c,a,k,Num);
E_p_yz_back = circshift(E_p_yz,Num/2,2);
E_p_zx_back = circshift(E_p_zx,Num/2,2);
E_p = E_p_xy + E_p_yz + E_p_zx + E_p_yz_back + E_p_zx_back; 

%total E field
E_total = sqrt(abs(E_t).*abs(E_t)+abs(E_p).*abs(E_p));

%total radiated power
Pr = 0;
for x1=0:pi()/2/(Num-1):pi()/2
    for y1=0:2*pi()/(Num-1):2*pi()
        
        E_tt_xy = E_theta_xy(x1,y1, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy,a,b,k,Num);
        E_pp_xy=E_phi_xy(x1,y1, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy,a,b,k,Num);
       
        Pr= Pr +  sin(x1).*(abs(E_tt_xy).*abs(E_tt_xy) + abs(E_pp_xy).*abs(E_pp_xy))*pi()/2/Num*(2*pi())/Num;
    end
end

%Directivity
D = 10*log10(4*pi()*E_total.*E_total./Pr);

end