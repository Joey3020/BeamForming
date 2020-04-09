function Pr = radiated_power(Ex_xy, Ey_xy,Ey_yz,Ez_yz,Ey_yz_bs,Ez_yz_bs,Ez_zx,Ex_zx,Ez_zx_bs,Ex_zx_bs, a,b,c,k,Num)

Pr = 0;

%Equivalent
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

%yz plane backside
Ms_y_yz_bs = Ez_yz_bs;
Ms_z_yz_bs = (-1)*Ey_yz_bs;
Js_y_yz_bs = (-1)*Ey_yz_bs./(120*pi());
Js_z_yz_bs = (-1)*Ez_yz_bs./(120*pi());

%zx plane
Ms_z_zx = Ex_zx;
Ms_x_zx = (-1)*Ez_zx;
Js_z_zx = (-1)*Ez_zx./(120*pi());
Js_x_zx = (-1)*Ex_zx./(120*pi());

%zx plane backside
Ms_z_zx_bs = Ex_zx_bs;
Ms_x_zx_bs = (-1)*Ez_zx_bs;
Js_z_zx_bs = (-1)*Ez_zx_bs./(120*pi());
Js_x_zx_bs = (-1)*Ex_zx_bs./(120*pi());

for x1=0:pi()/2/(Num-1):pi()/2
    for y1=0:2*pi()/(Num-1):2*pi()
        %theta direction E field
        E_tt_xy = E_theta_xy(x1, y1, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy, a, b, k, Num);
        
        E_tt_yz = E_theta_yz(x1, y1, Js_y_yz, Js_z_yz, Ms_y_yz, Ms_z_yz, b, c, k, Num);
        E_tt_zx = E_theta_zx(x1, y1, Js_z_zx, Js_x_zx, Ms_z_zx, Ms_x_zx, c, a, k, Num);
        
        E_tt_yz_bs = E_theta_yz(x1, y1, Js_y_yz_bs, Js_z_yz_bs, Ms_y_yz_bs, Ms_z_yz_bs, b, c, k, Num);
        E_tt_zx_bs = E_theta_zx(x1, y1, Js_z_zx_bs, Js_x_zx_bs, Ms_z_zx_bs, Ms_x_zx_bs, c, a, k, Num);
        E_tt_yz_back = circshift(E_tt_yz_bs, round(Num/2), 2);
        E_tt_zx_back = circshift(E_tt_zx_bs, round(Num/2), 2);
        
        E_tt = E_tt_xy + E_tt_yz + E_tt_zx + E_tt_yz_back + E_tt_zx_back;

        %phi direction E field
        E_pp_xy=E_phi_xy(x1,y1, Js_x_xy, Js_y_xy, Ms_x_xy, Ms_y_xy, a, b, k, Num);
        
        E_pp_yz = E_phi_yz(x1,y1, Js_y_yz, Js_z_yz, Ms_y_yz, Ms_z_yz, b, c, k, Num);
        E_pp_zx = E_phi_zx(x1,y1, Js_z_zx, Js_x_zx, Ms_z_zx, Ms_x_zx, c, a, k, Num);
        
        E_pp_yz_bs = E_phi_yz(x1, y1, Js_y_yz_bs, Js_z_yz_bs, Ms_y_yz_bs, Ms_z_yz_bs, b, c, k, Num);
        E_pp_zx_bs = E_phi_zx(x1, y1, Js_z_zx_bs, Js_x_zx_bs, Ms_z_zx_bs, Ms_x_zx_bs, c, a, k, Num);
        E_pp_yz_back = circshift(E_pp_yz_bs, round(Num/2), 2);
        E_pp_zx_back = circshift(E_pp_zx_bs, round(Num/2), 2);
        
        E_pp = E_pp_xy + E_pp_yz + E_pp_zx + E_pp_yz_back + E_pp_zx_back;

        Pr= Pr +  sin(x1).*(abs(E_tt).*abs(E_tt) + abs(E_pp).*abs(E_pp))*pi()/2/Num*(2*pi())/Num;
        
    end
end

end