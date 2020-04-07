[a, b, c, k,lamda, Num] = get_input();

%input / E field (magnitude and phase) at the aperture 
%xy plane
Ex_magnitude_xy = ones(Num);
Ey_magnitude_xy = zeros(Num);
%TE10 mode
%q=0:a/(Num-1):a;
%Ey_magnitude_xy = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(Num);
Phase_angle_xy = zeros(Num);

%number of iterations
iteration_time = 5;

Direct = zeros(Num, Num, iteration_time);
Direct_reverse = zeros(Num, Num, iteration_time);
D_error = zeros(Num, Num, iteration_time);

Dmax = zeros(1, iteration_time);
Dmax_reverse = zeros(1, iteration_time);
Dmax_error = zeros(1, iteration_time);
Dmax_relative_error = zeros(1, iteration_time);

axis = zeros(1, 2 * iteration_time);

color_label_blue = 0;
color_label_red = 1;

for iter = 1:iteration_time
    for i=1:Num
        for j=1:Num
            Phase_angle_xy(i,j) =(-1) * k * a * i/Num *cos( pi()/2 * iter/iteration_time );
        end
    end
    Phase_angle_xy=reshape(Phase_angle_xy,Num,Num)';
    %}

    Phase_exponential_xy = exp(1i*Phase_angle_xy);
    Ex_xy = Ex_magnitude_xy.*Phase_exponential_xy;
    Ey_xy = Ey_magnitude_xy.*Phase_exponential_xy;

    %form test beam
    zeromatrix = zeros(Num);
    [Pr, Dmax(:,iter), Direct(:,:,iter)] = Get_directivity_open_3d(Ex_xy, Ey_xy, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, Num);

    %get aperture Field from reverse method
    
    x=(-1)*a/2 : a/(Num-1) : a/2;
    y=(-1)*b/2 : b/(Num-1) : b/2;
    [Exa, Eya] = reverse_test(Direct(:,:,iter),lamda,x,y);
    [Exa2, Eya2] = reverse_method_2(Direct(:,:,iter),lamda,x,y);
    
    Exa_phase2 = get_phase(Exa2, Num);
    Eya_phase2 = get_phase(Eya2, Num);
    
    %divide phase and magnitude
    Exa_phase = get_phase(Exa,Num);
    Exa_mag = get_magnitude(Exa,Num);
    Exa_mag_reg = regularize_mag(Exa_mag, Num);
    
    Eya_phase = get_phase(Eya,Num);
    Eya_mag = get_magnitude(Eya,Num);
    Eya_mag_reg = regularize_mag(Eya_mag, Num);
    
    %go across filter
    Exa_smooth = smooth_saturation_filter(Exa_mag_reg, Num);
    Eya_smooth = smooth_saturation_filter(Eya_mag_reg, Num);
    Exa = Exa_smooth .* Exa_phase2;
    Eya = Eya_smooth .* Eya_phase2;
    
    %Exa = Exa_mag_reg .* Exa_phase2;
    %Eya = Eya_mag_reg .* Eya_phase2;

    %calculate error
    %Exa_error = Ex_xy - Exa_smooth_saturation;
    %Eya_error = Ey_xy - Eya_smooth_saturation;

    
    %assuming that the sides are small enough so that their field can be
    %neglected
    [Pr_reverse, Dmax_reverse(:,iter), Direct_reverse(:,:,iter)] = Get_directivity_open_3d(Exa, Eya, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, Num);
    
    Dmax_error(:,iter) = Dmax_reverse(:,iter)- Dmax(:,iter);
    Dmax_relative_error(:,iter) = 100.*Dmax_error(:,iter) / Dmax(:,iter);
 
    axis (1,iter) = subplot(2, iteration_time, iter);
    plot_directivity( Direct(:,:,iter), color_label_blue ); % test beam is green
    hold on
    plot_directivity( Direct_reverse(:,:,iter), color_label_red ); %reverse beam is blue
    
end