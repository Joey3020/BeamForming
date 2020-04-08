function E = regularize_mag(E_in,num)

    E_mag = get_magnitude(E_in, num);
    
    max_mag = max(max(E_mag));
    
    if max_mag ~= 0
        E = E_in./max(max(E_mag));
    else
        E = zeros(num);
    end
end