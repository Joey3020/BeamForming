function D=Get_Directivity_grounded(Ex, Ey,a,b,k,Num)

%Equivalent of aperture
%infinite grounded plane -> Js =0
Ms_x = Ey;
Ms_y = (-1)*Ex; 
Js_x = zeros(Num);
Js_y = zeros(Num);
 

%spherical coordinate variables
theta = 0:pi()/2/(Num-1):pi()/2;
phi= 0:2*pi()/(Num-1):2*pi();

%E theta field
E_t = E_azithumal(theta,phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);

%E phi field ( H field * 120pi())
E_p=E_horizontal(theta,phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);

%total E field
E_total = sqrt(abs(E_t).*abs(E_t)+abs(E_p).*abs(E_p));

%total radiated power
Pr = 0;
for x1=0:pi()/2/(Num-1):pi()/2
    for y1=0:2*pi()/(Num-1):2*pi()
       Pr= Pr +  sin(x1).*(abs(E_azithumal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)).*abs(E_azithumal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)) + abs(E_horizontal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)).*abs(E_horizontal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)))*pi()/2/Num*(2*pi())/Num;
    end
end

%Directivity
D = 10*log10(4*pi()*E_total.*E_total./Pr);

end