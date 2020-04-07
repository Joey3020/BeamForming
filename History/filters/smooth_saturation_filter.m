%%filtering E field
% if it is smaller that 0.25 * maximum value : saturate it


function E_sat = smooth_saturation_filter(E_mag, Num)
    
    
    E_max = max(max(E_mag));
    
    if E_max ==0
        E_sat = E_mag;
        return;
    end
    
    E_mag = E_mag./E_max;

    for m = 1:1:Num
        for n = 1:1:Num                
            if E_mag(m,n)<0.25 && E_mag(m,n) ~= 0
                E_mag(m,n) = 0.25;
            end
        end
    end
    
    E_sat = E_mag;
end