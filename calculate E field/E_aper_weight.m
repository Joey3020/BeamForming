%to solve the problem of directivity loss by the reverse method
%try giving weights to the aperture field and make it more uniform

function [Exa_w,Eya_w] = E_aper_weight(Exa, Eya, m,n)

for m = 1:1:Num
    for n = 1:1:Num
        Exa_w(m,n) = Exa(m,n).*(1+(abs(15-m)+abs(15-n))/30);
        Eya_w(m,n) = Eya(m,n).*(1+(abs(15-m)+abs(15-n))/30);
    end
end

end