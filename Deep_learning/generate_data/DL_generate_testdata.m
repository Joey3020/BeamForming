function [ data, labels_E, labels_ab, labels_mode, labels_phase ] ...
         = DL_generate_testdata(testdata_size, lamda, num)
     
     
     k=2*pi()/lamda;
     
     %preallocation
     Direct = zeros(num*num, testdata_size);
     ex_xy = zeros(2*num*num, testdata_size);       
     labels_ab = zeros(testdata_size,2);
     labels_mode = zeros(testdata_size,1);
     labels_phase = zeros(testdata_size,1);
     
     
    for iter = 1:1:testdata_size
        mode_xy = randi([0 4],1);
        a = 20 * rand;
        b = 20 * rand;
        phi = k*a/num * rand;
        
        if mode_xy == 0
            Ex_magnitude_xy = ones(num);
            Ey_magnitude_xy = zeros(num);
        elseif mode_xy == 1
            q=0 : b/(num-1) : b;
            Ex_magnitude_xy = sin(pi()/b*(q-b/2))'.*ones(num); 
            Ey_magnitude_xy = zeros(num);
        elseif mode_xy == 2
            q=0 : a/(num-1) : a;
            r=0 : b/(num-1) : b;
            Ex_magnitude_xy = 1/b * cos(pi()/a*(q-a/2))'.*sin(pi()/b*(r-b/2))'.*ones(num);
            Ey_magnitude_xy = (-1) * 1/a * sin(pi()/a*(q-a/2))'.*cos(pi()/b*(r-b/2))'.*ones(num);
        elseif mode_xy ==3
            q=0 : b/(num-1) : b;
            Ex_magnitude_xy = sin(2*pi()/b*(q-b/2))'.*ones(num); 
            Ey_magnitude_xy = zeros(num);
        else
            q=0 : a/(num-1) : a;
            r=0 : b/(num-1) : b;
            Ex_magnitude_xy = 2/b * cos(pi()/a*(q-a/2))'.*sin(2*pi()/b*(r-b/2))'.*ones(num);
            Ey_magnitude_xy = (-1) * 1/a * sin(pi()/a*(q-a/2))'.*cos(2*pi()/b*(r-b/2))'.*ones(num);
        end

        Ey_magnitude_yz = zeros(num);
        Ez_magnitude_yz = zeros(num);
        Ez_magnitude_zx = zeros(num);
        Ex_magnitude_zx = zeros(num);

        Phase_angle_xy = zeros(num);
        Phase_angle_yz = zeros(num);
        Phase_angle_zx = zeros(num);
        
        for i = 1 : num
            for j = 1 : num
                Phase_angle_xy(i,j) = i * phi ;
            end
        end
        Phase_angle_xy=reshape(Phase_angle_xy,num,num)';

        Phase_exponential_xy = exp(1i*Phase_angle_xy);
        Ex_xy = Ex_magnitude_xy.*Phase_exponential_xy;
        Ey_xy = Ey_magnitude_xy.*Phase_exponential_xy;

        Phase_exponential_yz = exp(1i*Phase_angle_yz);
        Ey_yz = Ey_magnitude_yz.*Phase_exponential_yz;
        Ez_yz = Ez_magnitude_yz.*Phase_exponential_yz;

        Phase_exponential_zx = exp(1i*Phase_angle_zx);
        Ez_zx = Ez_magnitude_zx.*Phase_exponential_zx;
        Ex_zx = Ex_magnitude_zx.*Phase_exponential_zx;

        %form test beam
        zeromatrix = zeros(num);
        
        c=0;
        [Pr, dmax, direct] =...
        Get_directivity_open_3d(Ex_xy, Ey_xy, Ey_yz, Ez_yz, zeromatrix, zeromatrix, Ez_zx, Ex_zx,...
                                zeromatrix, zeromatrix, a, b, c, k, num);
                            
       Direct(:,iter) = reshape(direct,[],1);
                    
       Ex_re = real(Ex_xy);
       Ex_re = reshape(Ex_re, [], 1);
       Ex_im = imag(Ex_xy);
       Ex_im = reshape(Ex_im, [], 1);                   
       E_new = vertcat(Ex_re, Ex_im);
                    
       ex_xy(:,iter) = reshape(E_new,[],1);
                    
       labels_mode(iter, 1) = mode_xy;
       labels_phase(iter, 1) = phi;
       labels_ab(iter, 1) = a;
       labels_ab(iter, 2) = b;

    end
     data = reshape(Direct, num*num, testdata_size);
     data = data.';
     labels_E = reshape(ex_xy, 2*num*num, testdata_size);
     labels_E = labels_E.';
     
end
