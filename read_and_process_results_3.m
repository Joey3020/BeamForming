

% read results from predictions file
% recover beam from prediction results
% compare hpbw, steared angle, maximum directivity vs original beam

predictions = xlsread('C:\Users\joonho0320\Documents\result\predictions.xlsx', 1);
labels = xlsread('C:\Users\joonho0320\Documents\result\testdata_without_source1.xlsx', 2);

num = 64;
lamda = 1;
k = 2 * pi() / lamda;
n0 = 120 * pi();


testdatasize = 200;

color_label_green = 1;
color_label_blue = 2;

results = zeros(testdatasize, 8);
PATH = 'C:\Users\User\Documents\Beamforming\result.xlsx';
processbar = waitbar(0, 'processing output');


for iter = 1:1:testdatasize

    a_class = predictions(iter, 1);
    b_class = predictions(iter, 2);
    y0 = predictions(iter, 3);
    d_class = predictions(iter, 4);
    a = a_class + 10;
    b = b_class + 10;
    x0 = a / 2;
    d = (d_class + 1 ) * 10;    
        
    a_label = labels(iter,1);
    b_label = labels(iter,2);
    phase_label = labels(iter,3);
    mode_label = 0;

    
    % get aperture field from predicted soure pos
    % and get directivity matrix 
    [Exa1, Eya1, Hxa1, Hya1] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num);
    D_r = Get_Directivity_General(Exa1, Eya1, Hxa1, Hya1, a, b, lamda, num);
    
    % test beam directivity matrix
    [Ex_label, Ey_label] = Set_E_field(mode_label, phase_label, a_label, b_label, num);
    D = Get_Directivity_General(Ex_label, Ey_label, -Ey_label/n0, Ex_label/n0, a_label, b_label, lamda, num);
    
    
    %save results
    maxD = max(max(D));
    maxD_r = max(max(D_r));
    
    HPBW = Get_HPBW(D);
    HPBW_r = Get_HPBW(D_r);
    
    [theta, phi] = GetStearedAngle(D);
    [theta_r, phi_r] = GetStearedAngle(D_r);
    
    results(iter, 1) = maxD;
    results(iter, 2) = maxD_r;
    results(iter, 3) = HPBW;
    results(iter, 4) = HPBW_r;
    results(iter, 5) = theta;
    results(iter, 6) = theta_r;
    results(iter, 7) = phi;
    results(iter, 8) = phi_r;
    
    %plot results
   % fig = figure( iter );
    %plot_directivity( D, color_label_blue ); % test beam is blue
    %hold on
    %plot_directivity( D_r, color_label_green ); %reverse beam is green
    %hold off
    %maximize_fig(fig);
    %saveas(fig, sprintf('%d th result ', iter));
    
    waitbar(iter/testdatasize)

end

close(processbar)
writematrix(results, PATH, 'Sheet', 1);
    