
% read labels and prediction
% i 번째 label : labels(1:i) labels(2:i) labels(3:i) labels(4:i)
% labels로 복원한 beam의 부피와 predictions로 복원한 beam의 부피의 겹치는 부분 계산
labels = xlsread('prediction_and_label', 2);
predictions = xlsread('prediction_and_label', 1);


num = 32;
lamda = 1;
k=2*pi()/lamda;

testdatasize = 2000;

color_label_blue = 2;
color_label_green = 1;
color_label_red = 0;
 
Direct_label = zeros(num*num, testdatasize);
Direct_pred = zeros(num*num, testdatasize);

volume = zeros(testdatasize, 3);
direct_cross = zeros(num);

maxdir = zeros(testdatasize, 2);

showresultsuntil = 1;


for iter = 1:1:showresultsuntil
    
    
    a_label = labels(iter,1);
    b_label = labels(iter,2);
    mode_label = labels(iter,3);
    phase_label = labels(iter,4);
    
    a_pred = predictions(iter,1);
    b_pred = predictions(iter,2);
    mode_pred = predictions(iter,3);
    phase_pred = predictions(iter,4);
    
    [Ex_label, Ey_label] = Set_E_field(mode_label, phase_label, a_label, b_label, num);
    [Ex_pred, Ey_pred] = Set_E_field(mode_pred, phase_pred, a_pred, b_pred, num);
    
    zeromatrix = zeros(num);
    c=0;
    
    [Pr_label, dmax_label, direct_label] =...
    Get_directivity_open_3d(Ex_label, Ey_label, zeromatrix, zeromatrix, zeromatrix, zeromatrix,...
                            zeromatrix, zeromatrix, zeromatrix, zeromatrix,...
                            a_label, b_label, c, k, num);
                        
    [Pr_pred, dmax_pred, direct_pred] =...
    Get_directivity_open_3d(Ex_pred, Ey_pred, zeromatrix, zeromatrix, zeromatrix, zeromatrix,...
                            zeromatrix, zeromatrix, zeromatrix, zeromatrix,...
                            a_pred, b_pred, c, k, num);
                        
    Direct_label(:,iter) = reshape(direct_label,[],1);
    Direct_pred(:,iter) = reshape(direct_pred,[],1);
    
    for i = 1:1:num
        for j = 1:1:num
            direct_cross(i,j) = min(direct_label(i,j), direct_pred(i,j));
        end
    end
    
    volume(iter,1) = GetVolume(direct_label, num);
    volume(iter,2) = GetVolume(direct_pred, num);
    volume(iter,3) = GetVolume(direct_cross, num);
    
    maxdir(iter,1) = dmax_label;
    maxdir(iter,2) = dmax_pred;
    
    fig = figure( iter );
    plot_directivity( direct_label, color_label_blue ); % test beam is blue
    hold on
    plot_directivity( direct_pred, color_label_green ); %reverse beam is green
    hold on
    plot_directivity( direct_cross, color_label_red );
    hold off
    maximize_fig(fig);
    saveas(fig, sprintf('%d th result ', iter));
end

filename = 'C:\Users\User\Documents\MATLAB\DL_result_analysis.xlsx';
writematrix(volume, filename, 'Sheet', 1);
writematrix(maxdir, filename, 'Sheet', 2);

