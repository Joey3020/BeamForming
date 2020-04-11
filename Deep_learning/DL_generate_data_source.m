
%generate test data for aperture radiation with source
function [ data, labels_ab_source] = DL_generate_data_source(data_size, lamda, num)
    

    %k=2*pi()/lamda;

    D_matrix = zeros(num*num, data_size);
    labels_ab_source = zeros(data_size, 8);
    
    max_ab = 30;
    min_ab = 1;
    max_d = 10;
    min_d = 1;
    
    processbar = waitbar(0, 'processing output');

    for iter = 1:1:data_size
           a = (max_ab - min_ab) * rand + min_ab;
           b = (max_ab - min_ab) * rand + min_ab;
           
           x01 = a*rand;
           y01 = b*rand;
           d1 = (max_d - min_d) * rand + min_d;
           
           x02 = a*rand;
           y02 = b*rand;
           d2 = (max_d - min_d) * rand + min_d;
           
           [Exa1, Eya1, Hxa1, Hya1] = Aperture_field_from_point_source(x01, y01, d1, a, b, lamda, num);
           [Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x02, y02, d2, a, b, lamda, num);

            D = Get_Directivity_General(Exa1 + Exa2, Eya1 + Eya2, Hxa1 + Hxa2, Hya1 + Hya2, a, b, lamda, num);
            
            plot_single_beam(D);
           
    
            D_matrix(:,iter) = reshape(D, [], 1);
            labels_ab_source(iter, 1) = a;
            labels_ab_source(iter, 2) = b;
            labels_ab_source(iter, 3) = x01;
            labels_ab_source(iter, 4) = y01;
            labels_ab_source(iter, 5) = d1;
            labels_ab_source(iter, 3) = x02;
            labels_ab_source(iter, 4) = y02;
            labels_ab_source(iter, 5) = d2;
            waitbar(iter/data_size)

    end
    
     data = reshape(D_matrix, num*num, data_size);
     data = data.';
     close(processbar)

end