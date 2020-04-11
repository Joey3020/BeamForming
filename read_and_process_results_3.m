

% read results from predictions file
% recover beam from prediction results
% compare hpbw, steared angle, maximum directivity vs original beam

predictions = xlsread('predictions', 1);
Directivity = xlsread('testdata', 1);

num = 64;
lamda = 1;
k = 2 * pi() / lamda;
testdatasize = 100;

color_label_green = 1;
color_label_blue = 2;

results = zeros(testdatasize, 8);
PATH = 'C:\Users\User\Documents\DL_Work_Bench\result.xlsx';
processbar = waitbar(0, 'processing output');


for iter = 1:1:testdatasize
    a = predictions(iter, 1);
    b = predictions(iter, 2);
    x0 = predictions(iter, 3);
    y0 = predictions(iter, 4);
    d = predictions(iter, 5);
    
    % get aperture field from predicted soure pos
    % and get directivity matrix 
    [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num);
    D_r = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
    
    % test beam directivity matrix
    D = Directivity(iter, :);
    D = reshape(D, num, num);
    
    
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
    %fig = figure( iter );
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
    