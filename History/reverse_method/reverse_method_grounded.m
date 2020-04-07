function [Exa, Eya] = reverse_method_grounded(D,lamda,x,y)
%get size of directivity matrix
[num, num]=size(D);

%convert db into Np
D_NP = 10.^(D./10);

%horizontal angle phi
phi = 0:2*pi()/(num-1):2*pi();

%IFT of E field
fx=sqrt(D_NP).*cos(phi);
fy=sqrt(D_NP).*sin(phi);

%FT of fx and fy -> get aperture field Exa and Eya
Exa=0;
Eya=0;
for m=1:1:num
    for n=1:1:num
        
        %Exa = Exa+1/(lamda^2)*fx(m,n)*cos(2*pi()/num*n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
        %Eya = Eya+1/(lamda^2)*fy(m,n)*cos(2*pi()/num*n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
        Exa = Exa+1/(lamda^2)*fx(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
        Eya = Eya+1/(lamda^2)*fy(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
    end    
end

%find half power beam width in xz and yz plane -> find a & b
%{
hpbw_yz = powerbw(D_NP(:,1));
hpbw_xz = powerbw(D_NP(:,round(num/4)));
c = sqrt(D_max/4/pi()*hpbw_yz/hpbw_xz)*lamda;
d = sqrt(D_max/4/pi()*hpbw_xz/hpbw_yz)*lamda;
%}
end