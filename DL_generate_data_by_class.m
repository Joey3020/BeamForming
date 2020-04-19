function [data, label] = DL_generate_data_by_class(datasize, lamda, num)
    data = zeros(datasize, num*num);
    label = zeros(datasize, 4);
    
    MAX_L = 30;
    MAX_d = 10;
    
    processbar = waitbar(0, 'processing output');

    
    for iter = 1:1:datasize
        a_class = randi([0, 15]);
        b_class = randi([0, 15]);
        d_class = randi([0, 4]);
        
        a = a_class + 5;
        b = b_class + 5;
        x0 = a / 2;
        y0 = 2*b*rand - b;
        d = (d_class + 1) * 5;
        
        [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num);
        D = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
        
        %plot_single_beam(D);

        
        D = reshape(D, 1, []);
        
        
        data(iter, :) = D;
        label(iter, 1) = a_class;
        label(iter, 2) = b_class;
        label(iter, 3) = y0;
        label(iter, 4) = d_class;
        
        waitbar(iter / datasize)
    end
    
    close(processbar);

end