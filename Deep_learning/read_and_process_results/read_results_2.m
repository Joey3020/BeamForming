% read labels and prediction
% i 번째 label : labels(1:i) labels(2:i) labels(3:i) labels(4:i)
% prediction과 label으로 구한 beam에서 원하는 directivity의 x % 이상을 얻은
% 공간각을 전체 공간각인 2 PI 로 나눈 비율을 return

labels = xlsread('prediction_and_label', 2);
predic = xlsread('prediction_and_label', 1);

num = 32;
lamda = 1;
k = 2*pi() / lamda;
testdatasize = 2000;
showresultsuntil = 20;
zm = zeros(num);
c = 0;
ret = zeros(showresultsuntil, 8);
for iter = 1 : 1 : showresultsuntil
    a_lab = labels(iter, 1);  b_lab = labels(iter, 2);  mode_lab = labels(iter, 3);  phase_lab = labels(iter, 4);
    a_pre = predic(iter, 1);  b_pre = predic(iter, 2);  mode_pre = predic(iter, 3);  phase_pre = predic(iter, 4);
    
    [Ex_lab, Ey_lab] = Set_E_field(mode_lab, phase_lab, a_lab, b_lab, num);
    [Ex_pre, Ey_pre] = Set_E_field(mode_pre, phase_pre, a_pre, b_pre, num);
    
    [Pr_label, dmax_label, direct_label] =...
    Get_directivity_open_3d(Ex_lab, Ey_lab, zm, zm, zm, zm, zm, zm, zm, zm, a_lab, b_lab, c, k, num);
                        
    [Pr_pred, dmax_pred, direct_pred] =...
    Get_directivity_open_3d(Ex_pre, Ey_pre, zm, zm, zm, zm, zm, zm, zm, zm, a_pre, b_pre, c, k, num);

    ratio = GetRatio(direct_pred, direct_label, num);
    for i = 1:1:8
    ret(iter,i) = ratio(i);
    end
end
filename = 'C:\Users\User\Documents\MATLAB\DL_result_analysis_2.xlsx';
writematrix(ret, filename, 'Sheet', 1);
