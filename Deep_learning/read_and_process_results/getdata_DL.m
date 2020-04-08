% debugging 에 이용되는 함수

% Exa_xy 는 xy 평면에서 test beam 만들때 aperture field를 나타내는 것임
    % 1이면 ones(num)   /   0이면 zeros(num)

% mode 는 uniform E field, TE10모드 표시 
    % 0 이면 uniform   /   1이면 TE10

function [ data, labels ] ...
         = getdata_DL(Exa_xy, Eya_xy, Eya_yz, Eza_yz, Eza_zx, Exa_zx, ...
                      mode_xy, mode_yz, mode_zx, ...
                      a_range, b_range, c_range, lamda, num)
                 
     
     %global variables             
     test_total = a_range * b_range * c_range;
     iteration_time = 5;
     k=2*pi()/lamda;
     
     %preallocation
     Direct = zeros(num*num, iteration_time, test_total);
     ex_xy = zeros(2*num*num, iteration_time, test_total);       
             
%------------------------------main loop-------------------------------%

     for a_iter = 1 : 1 : a_range
         for b_iter = 1 : 1 : b_range
             for c_iter = 1 : 1 : c_range
                 
                
                test_time = c_iter + c_range * (b_iter -1) +...
                            c_range * b_range * (a_iter -1);
                
                a = a_iter * lamda;
                b = b_iter * lamda;
                c = c_iter * lamda;
                
                % setting input / E field (magnitude and phase) at the aperture
                % xy plane
                if Exa_xy == 1 && mode_xy == 0
                    Ex_magnitude_xy = ones(num);
                elseif Exa_xy == 1 && mode_xy ==1                    
                    q=0 : b/(num-1) : b;
                    Ex_magnitude_xy = cos(pi()/b*(q-b/2))'.*cos(pi()/b*(q-b/2)).*ones(num);
                else
                    Ex_magnitude_xy = zeros(num);
                end
                
                if Eya_xy == 1 && mode_xy == 0
                    Ey_magnitude_xy = ones(num);
                elseif Eya_xy == 1 && mode_xy ==1                    
                    q=0 : a/(num-1) : a;
                    Ey_magnitude_xy = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(num);
                else
                    Ey_magnitude_xy = zeros(num);
                end
                
                % yz plane
                if Eya_yz == 1 && mode_yz == 0
                    Ey_magnitude_yz = ones(num);
                elseif Eya_yz == 1 && mode_yz ==1                    
                    q = 0:c/(num-1):c;
                    Ey_magnitude_yz = cos(pi()/c*(q-c/2))'.*cos(pi()/c*(q-c/2)).*ones(num);
                else
                    Ey_magnitude_yz = zeros(num);
                end
                
                if Eza_yz == 1 && mode_yz == 0
                    Ez_magnitude_yz = ones(num);
                elseif Eza_yz == 1 && mode_yz ==1                    
                    q = 0 : b/(num-1) : b;
                    Ez_magnitude_yz = cos(pi()/b*(q-b/2))'.*cos(pi()/b*(q-b/2)).*ones(num);
                else
                    Ez_magnitude_yz = zeros(num);
                end              
                
                % zx plane
                if Eza_zx == 1 && mode_zx == 0
                    Ez_magnitude_zx = ones(num);
                elseif Eza_zx == 1 && mode_zx ==1                    
                    q = 0 : a/(num-1) : a;
                    Ez_magnitude_zx = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(num);
                else
                    Ez_magnitude_zx = zeros(num);
                end
                
                if Exa_zx == 1 && mode_zx == 0
                    Ex_magnitude_zx = ones(num);
                elseif Exa_zx == 1 && mode_zx ==1                    
                    q = 0 : c/(num-1) : c;
                    Ex_magnitude_zx = cos(pi()/c*(q-c/2))'.*cos(pi()/c*(q-c/2)).*ones(num);
                else
                    Ex_magnitude_zx = zeros(num);
                end          
                
                Phase_angle_xy = zeros(num);
                Phase_angle_yz = zeros(num);
                Phase_angle_zx = zeros(num);
                
                % iteration for phase
                for iter = 1 : iteration_time
                    for i = 1 : num
                        for j = 1 : num
                            Phase_angle_xy(i,j) =(-1) * k * a * i/num *cos( pi()/2 * iter/iteration_time );
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
                    
                    [Pr, dmax, direct] =...
                    Get_directivity_open_3d(Ex_xy, Ey_xy, Ey_yz, Ez_yz, zeromatrix, zeromatrix, Ez_zx, Ex_zx,...
                                            zeromatrix, zeromatrix, a, b, c, k, num);

  
                    %return value
                    Direct(:,iter, test_time) = reshape(direct,[],1);
                    
                    Ex_re = real(Ex_xy);
                    Ex_re = reshape(Ex_re, [], 1);
                    Ex_im = imag(Ex_xy);
                    Ex_im = reshape(Ex_im, [], 1);
                    
                    E_new = vertcat(Ex_re, Ex_im);
                    
                    ex_xy(:,iter, test_time) = reshape(E_new,[],1);
                end
             end
         end
     end
     
     data = reshape(Direct, num*num, iteration_time * test_total);
     labels = reshape(ex_xy, 2*num*num, iteration_time * test_total);
     
end