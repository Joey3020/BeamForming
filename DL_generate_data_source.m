
%generate test data for aperture radiation with source
function [ data, labels_ab, labels_source] = DL_generate_data_source(data_size, lamda, num)
    

    %k=2*pi()/lamda;

    D_matrix = zeros(num*num, data_size);
    labels_ab = zeros(data_size, 2);
    labels_source = zeros(data_size, 3);
    
    max_ab = 15;
    min_ab = 5;
    max_d = 15;
    min_d = 1;
    
    for iter = 1:1:data_size
           a = (max_ab - min_ab) * rand + min_ab;
           b = (max_ab - min_ab) * rand + min_ab;
           
           x0 = a*rand;
           y0 = b*rand;
           d = (max_d - min_d) * rand + min_d;
           
            [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num);
            
            D = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
            
            plot_single_beam(D);
           
         
            D_matrix(:,iter) = reshape(D, [], 1);
            labels_ab(iter, 1) = a;
            labels_ab(iter, 2) = b;
            labels_source(iter, 1) = x0;
            labels_source(iter, 2) = y0;
            labels_source(iter, 3) = d;
            
    end
    
     data = reshape(D_matrix, num*num, data_size);
     data = data.';
     
end