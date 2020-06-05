[a, b, c, k, lamda, Num] = get_input();

%input / E field (magnitude and phase) at the aperture 
%xy plane
Ex_magnitude_xy = ones(Num);
Ey_magnitude_xy = zeros(Num);
%TE10 mode
q=0:a/(Num-1):a;
Ey_magnitude_xy = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(Num);
Phase_angle_xy = zeros(Num);

iteration_time = 2;

Direct = zeros(Num,Num,iteration_time);
Direct_reverse = zeros(Num,Num,iteration_time);

Dmax = zeros(1,iteration_time);
Dmax_reverse = zeros(1,iteration_time);
Dmax_error = zeros(1,iteration_time);

for iter = 1:iteration_time
    for i=1:Num
        for j=1:Num
            Phase_angle_xy(i,j) = pi()*iter/Num*k*(i);
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
    [Exa, Eya] = reverse_method_2(Direct(:,:,iter),lamda,x,y);

    %divide phase and magnitude
    Exa_phase = get_phase(Exa,Num);
    Exa_mag = get_magnitude(Exa,Num);

    Eya_phase = get_phase(Eya,Num);
    Eya_mag = get_magnitude(Eya,Num);

    %go across filter
    Exa_smooth = smooth_saturation_filter(Exa_mag, Num);
    Eya_smooth = smooth_saturation_filter(Eya_mag, Num);
    Exa_smooth_saturation = Exa_smooth .* Exa_phase;
    Eya_smooth_saturation = Eya_smooth .* Eya_phase;

    %assuming that the sides are small enough so that their field can be
    %neglected
    [Pr_reverse, Dmax_reverse(:,iter), Direct_reverse(:,:,iter)] = Get_directivity_open_3d(Exa_smooth_saturation, Eya_smooth_saturation, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, Num);
    Dmax_error(:,iter) = Dmax(:,iter) - Dmax_reverse(:,iter);
    
    subplot(2,iteration_time,iter);
    plot_directivity(Direct(:,:,iter));
    
    subplot(2,iteration_time, iter+iteration_time);
    plot_directivity(Direct_reverse(:,:,iter));
end