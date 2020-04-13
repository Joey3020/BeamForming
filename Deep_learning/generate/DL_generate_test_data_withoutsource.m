function [data, labels] = DL_generate_test_data_withoutsource(testdata_size, lamda, num)
     
     
    k=2*pi()/lamda;
    n0 = 120*pi();
    %preallocation
    Direct = zeros(num*num, testdata_size);
    labels = zeros(testdata_size, 4);

    minlen = 1;
    maxlen = 4;
    minphi = 0;
    maxphi = pi()/4;
    
    processbar = waitbar(0, 'processing output');
    
    
    for iter = 1:1:testdata_size
        mode = 0;
        a = (maxlen - minlen) * rand + minlen;
        b = (maxlen - minlen) * rand + minlen;
        phi = - k * a / num * ((maxphi - minphi)*rand + minphi);
        
        [Exa, Eya] = Set_E_field(mode, phi, a, b, num);
        direct = Get_Directivity_General(Exa, Eya, -Eya/n0, Exa/n0, a, b, lamda, num);
        
        plot_single_beam(direct);
                                 
        Direct(:,iter) = reshape(direct,[],1);
        labels(iter, 1) = a;
        labels(iter, 2) = b;
        labels(iter, 3) = phi;
        labels(iter, 4) = mode;
        
        waitbar(iter/testdata_size)
    end
     data = reshape(Direct, num*num, testdata_size);
     data = data.';
     close(processbar)
end