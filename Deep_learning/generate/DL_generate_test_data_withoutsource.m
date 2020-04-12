function [data, labels] = DL_generate_test_data_withoutsource(testdata_size, lamda, num)
     
     
    k=2*pi()/lamda;
    etha = 120*pi();
    %preallocation
    Direct = zeros(num*num, testdata_size);
    labels = zeros(testdata_size, 4);

    minlen = 5;
    maxlen = 20;
    
    processbar = waitbar(0, 'processing output');
    
    
    for iter = 1:1:testdata_size
        mode = randi([0 1],1);
        a = (maxlen - minlen) * rand + minlen;
        b = (maxlen - minlen) * rand + minlen;
        phi = k * a / num * rand;
        
        if mode == 0
            Exa = ones(num);
            Eya = zeros(num);

        elseif mode == 1
            q=0 : b/(num-1) : b;
            Exa = sin(pi()/b*(q-b/2))'.*ones(num); 
            Eya = zeros(num);
        end
        Hxa = -Eya ./ etha;
        Hya = Exa ./ etha;
        
        for i = 1 : num
            for j = 1 : num
                Phase_angle_xy(i,j) = i * phi ;
            end
        end
        Phase_angle_xy = reshape(Phase_angle_xy,num,num)';

        Phase_exponential_xy = exp(1i*Phase_angle_xy);
        Exa = Exa.*Phase_exponential_xy;
        Eya = Eya.*Phase_exponential_xy;

        direct = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
                                 
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