function E_phase = get_phase(E,Num)
    
E_mag = get_magnitude(E);

    for m = 1:1:Num
        for n = 1:1:Num
            if E_mag(m,n) ~= 0
                E_phase(m,n) = E(m,n) / E_mag(m,n);
            else
                E_phase(m,n) = 0;
            end
        end
    end
end