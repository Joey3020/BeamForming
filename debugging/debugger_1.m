% debugging 에 이용되는 함수

% Exa_xy 는 xy 평면에서 test beam 만들때 aperture field를 나타내는 것임
    % 1이면 ones(num)   /   0이면 zeros(num)

% mode 는 uniform E field, TE10모드 표시 
    % 0 이면 uniform   /   1이면 TE10

function [ Dmax, Dmax_reverse, Dmax_error, Dmax_relative_error, Direct, Direct_reverse] ...
         = debugger_1(Exa_xy, Eya_xy, Eya_yz, Eza_yz, Eza_zx, Exa_zx, ...
                      mode_xy, mode_yz, mode_zx, ...
                      a_range, b_range, c_range, lamda, num)
                 
     
     %global variables             
     test_total = a_range * b_range * c_range;
     iteration_time = 10;
     k=2*pi()/lamda;
     color_label_blue = 0;
     color_label_red = 1;
     
     %preallocation
     Direct = zeros(num*num, iteration_time, test_total);
     Direct_reverse = zeros(num*num, iteration_time, test_total);
     %Direct_reverse2 = zeros(num*num, iteration_time, test_total);

     Dmax = zeros(iteration_time, test_total);
     Dmax_reverse = zeros(iteration_time, test_total);
     Dmax_error = zeros(iteration_time, test_total);
     Dmax_relative_error = zeros(iteration_time, test_total);
     %Dmax_reverse2 = zeros(iteration_time, test_total);
     %Dmax_error2 = zeros(iteration_time, test_total);
     %Dmax_relative_error2 = zeros(iteration_time, test_total);             
             
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
                            % Phase_angle_xy(i,j) =(-1) * k * a * i/num *cos( pi()/2 * iter/iteration_time );
                            Phase_angle_xy(i,j) = (-1) *k*(a*i/num)*sin(pi()/2*iter/iteration_time) ;

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

                    %get aperture Field from reverse method

                    x=(-1)*a/2 : a/(num-1) : a/2;
                    y=(-1)*b/2 : b/(num-1) : b/2;
                    [Exa, Eya] = reverse_method_2(direct,lamda,x,y);
                    
                    %divide phase and magnitude
                    Exa_phase = get_phase(Exa,num);
                    Exa_mag = get_magnitude(Exa,num);
                    Exa_mag_reg = regularize_mag(Exa_mag, num);

                    Eya_phase = get_phase(Eya,num);
                    Eya_mag = get_magnitude(Eya,num);
                    Eya_mag_reg = regularize_mag(Eya_mag, num);

                    %go across filter
                    Exa_smooth = smooth_saturation_filter(Exa_mag_reg, num);
                    Eya_smooth = smooth_saturation_filter(Eya_mag_reg, num);
                    Exa = Exa_smooth .* Exa_phase;
                    Eya = Eya_smooth .* Eya_phase;

                    %new method of getting aperture magnitude
                    %{
                    [Exa2, Eya2] = reverse_test(Direct(:,:,iter, test_time),lamda,x,y);
                    Exa2_mag = get_magnitude(Exa2, num);
                    Eya2_mag = get_magnitude(Eya2, num);
                    Exa2_mag_reg = regularize_mag(Exa2_mag, num);
                    Eya2_mag_reg = regularize_mag(Eya2_mag, num);
                    Exa2_smooth = smooth_saturation_filter(Exa2_mag_reg, num);
                    Eya2_smooth = smooth_saturation_filter(Eya2_mag_reg, num);
                    Exa2 = Exa2_smooth .* Exa_phase;
                    Eya2 = Eya2_smooth .* Eya_phase;
                    %}
                    
                    %assuming that the sides are small enough so that their field can be neglected
                    [Pr_reverse, dmax_reverse, direct_reverse] =...
                    Get_directivity_open_3d(Exa, Eya, zeromatrix, zeromatrix, zeromatrix, zeromatrix, ... 
                                            zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, num);
                                        
                    %[Pr_reverse2, Dmax_reverse2, Direct_reverse2] =...
                    %Get_directivity_open_3d(Exa2, Eya2, zeromatrix, zeromatrix, zeromatrix, zeromatrix, ... 
                    %                        zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, num);
                                        
                    %getting error
                    dmax = max(max(direct));
                    
                    %original reverse method error
                    dmax_reverse = max(max(direct_reverse));
                    Dmax_error(iter, test_time) = dmax_reverse - dmax;
                    Dmax_relative_error(iter, test_time) = 100 * Dmax_error(iter, test_time) ./ dmax;                    
                    
                    %new reverse method error
                    %Dmax_reverse2(iter, test_time) = max(max(Direct_reverse2(:,:,iter, test_time)));
                    %Dmax_error2(iter, test_time) = Dmax_reverse2(iter, test_time) - dmax(iter, test_time);
                    %Dmax_relative_error2(iter, test_time) = 100 * Dmax_error2(iter, test_time) ./ dmax(iter, test_time);
                    
                    
                    %return value
                    Direct(:,iter, test_time) = reshape(direct,[],1);
                    Direct_reverse(:,iter, test_time) = reshape(direct_reverse, [], 1);
                    Dmax(iter,test_time) = dmax;
                    Dmax_reverse(iter,test_time) = dmax_reverse;
                    
                    %plotting
                    fig = figure( test_time );
                    subplot(2, iteration_time/2, iter);
                    plot_directivity( direct, color_label_blue ); % test beam is green
                    hold on
                    plot_directivity( direct_reverse, color_label_red ); %reverse beam is blue
                    title (sprintf('aperture size  %d x %d (lamda)',a_iter, b_iter))
                    
                    %{
                    subplot(2, iteration_time, iteration_time + iter);
                    plot_directivity( Direct, color_label_blue ); % test beam is green
                    hold on
                    plot_directivity( Direct_reverse2(:,:,iter, test_time), color_label_red ); %reverse beam is blue
                    title (sprintf('aperture size  %d x %d (lamda)',a_iter, b_iter))
                    %}
                    
                    maximize_fig(fig);
                    filename = sprintf('size_of_aperture_%d_x_%d', a_iter, b_iter);
                    filepath = 'C:\Users\User\Documents\MATLAB\figures\'
                    saveas(fig, strcat(filepath, filename));
                end
             end
         end
     end
end