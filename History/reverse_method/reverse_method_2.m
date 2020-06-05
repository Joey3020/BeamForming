% this method assumes a x polarized E field at the aperture

function [Exa, Eya] = reverse_method_2(D,lamda,x,y)
    %get size of directivity matrix
    [num, num]=size(D);

    %convert db into Np
    D_NP = 10.^(D./10);

    %horizontal angle phi
    phi = 0 : 2*pi()/(num-1) : 2*pi();
    theta = 0.005*pi() : pi()*0.495/(num-1) : pi()*0.5;

    %IFT of E field
    fx=sqrt(D_NP./( cos(phi).*cos(phi)+(cos(theta).*cos(theta)).'*(sin(phi).*sin(phi)))) ;
    fy=zeros(num);

    %FT of fx and fy -> get aperture field Exa and Eya
    Exa=0;
    Eya=0;
    for m=1:1:num
        for n=1:1:num
            Exa = Exa+1/(lamda^2)*fx(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
            Eya = Eya+1/(lamda^2)*fy(m,n)*0.5*sin(pi()/num*m)*exp((-1)*1i*2*pi()/lamda*(x'*sin(pi()/2*m/num)*cos(2*pi()/num*n)+y*sin(pi()/2*m/num)*sin(2*pi()/num*n)))*pi()*pi()/num/num;
        end    
    end
end