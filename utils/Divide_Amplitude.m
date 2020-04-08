function E_out = Divide_Amplitude(E_in, val)

    if val==0
        E_out = E_in;
    else
        E_out = E_in ./ val;
    end
end