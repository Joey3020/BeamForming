
predictions = xlsread('C:\Users\User\Documents\Beamforming\predictions (1).xlsx', 1);
labels = xlsread('C:\Users\User\Documents\Beamforming\data_with_source_by_class6.xlsx', 2);

num = 64;
lamda = 1;
k = 2 * pi() / lamda;
n0 = 120 * pi();

testdatasize = 20;

color_label_green = 1;
color_label_blue = 2;

results = zeros(testdatasize, 8);
PATH = 'C:\Users\User\Documents\Beamforming\result.xlsx';
processbar = waitbar(0, 'processing output');


for iter = 1:1:testdatasize
    a = predictions(iter, 1) + 1;
    b = predictions(iter, 2) + 1;
    x01 = predictions(iter, 3);
    y01 = predictions(iter, 4);
    d1 = predictions(iter, 5) + 1;
    %x02 = predictions(iter, 6);
    %y02 = predictions(iter, 7);
    %d2 = predictions(iter, 8);
    
        
    a2 = labels(iter, 1);
    b2 = labels(iter, 2);
    x02 = labels(iter, 3);
    y02 = labels(iter, 4);
    d2 = labels(iter, 5);

    
    % get aperture field from predicted soure pos
    % and get directivity matrix 
    [Exa1, Eya1, Hxa1, Hya1] = Aperture_field_from_point_source(x01, y01, d1, a, b, lamda, num);
    %[Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x02, y02, d2, a, b, lamda, num);
    D_r = Get_Directivity_General(Exa1, Eya1, Hxa1, Hya1, a, b, lamda, num);
    %D_r = Get_Directivity_General(Exa1 + Exa2, Eya1 + Eya2, Hxa1 + Hxa2, Hya1 + Hya2, a, b, lamda, num);
    
    % test beam directivity matrix
    [Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x02, y02, d2, a2, b2, lamda, num);
    D = Get_Directivity_General(Exa2, Eya2, Hxa2, Hya2, a2, b2, lamda, num);
    
    
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
    fig = figure( iter );
    plot_directivity( D, color_label_blue ); % test beam is blue
    hold on
    plot_directivity( D_r, color_label_green ); %reverse beam is green
    hold off
    maximize_fig(fig);
    %saveas(fig, sprintf('%d th result ', iter));
    
    waitbar(iter/testdatasize)

end

close(processbar)
writematrix(results, PATH, 'Sheet', 1);