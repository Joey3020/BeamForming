% this method assumes a x polarized E field at the aperture

function [Exa, Eya] = reverse_test(D,lamda,x,y)
%get size of directivity matrix
[num, num]=size(D);

%convert db into Np
D_NP = 10.^(D./10);

%define angle
%phi = 0 : 2*pi()/(num-1) : 2*pi();
theta = 0 : pi()*0.5 /(num-1) : pi()*0.5;

%IFT of E field
Ly = - cos(theta)' + sqrt((cos(theta)).^2'.* (D + 1) + D);
Lx = zeros(num);

%FT of fx and fy -> get aperture field Exa and Eya
Exa=0;
Eya=0;

for m=1:1:num
    for n=1:1:num
        Exa = Exa+1/(lamda^2)*Ly(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
        Eya = Eya+1/(lamda^2)*Lx(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
    end    
end

end