testdata = csvread('test_data.csv');
predictions = xlsread('predictions.xlsx', 1);

lambda = 1;
num = 64;
k = 2 * pi() / lambda;
R = 10;
a = 1.5;
b = 1.5;
ratio = 1.3;

len = num * num;

labels = testdata(:, end-2:end);

testdata_size = 200;

green = [0.0, 1.0, 0.0];
blue = [0.0, 0.0, 1.0];
red = [1.0, 0.0, 0.0];



results = zeros(testdata_size, 30);

processbar = waitbar(0, 'processing output');
for iter=1:1:testdata_size
    %get test beam
    A = labels(iter, 1);
    B = labels(iter, 2);
    t_max = labels(iter, 3);
    [D, label] = generate_test_data_point(A, B, t_max, R, k, num);
    D1 = reshape(D(:, 1:len), num, num);
    D2 = reshape(D(:, len + 1: 2*len), num, num);
    D3 = reshape(D(:, 2*len + 1:3*len), num, num);
    D4 = reshape(D(:, 3*len + 1:4*len), num, num);
    
    A_ = predictions(iter, 1) / ratio;
    B_ = predictions(iter, 2) / ratio;
    d_ = predictions(iter, 3);
    t_max_ = predictions(iter, 4);
    AA_ = A_ * ratio;
    BB_ = B_ * ratio;
    
    %[D_, label_] = generate_train_data_point(A, B, a_, b_, d_, t_max, R, k, num);
    [D_, label_]  = generate_train_data_point3( a, b, d_, A_, B_, AA_, BB_, t_max, R, k, num);
    D1_ = reshape(D_(:, 1:len), num, num);
    D2_ = reshape(D_(:, len + 1: 2*len), num, num);
    D3_ = reshape(D_(:, 2*len + 1:3*len), num,num);
    D4_ = reshape(D_(:, 3*len + 1:4*len), num, num);
    
    results(iter, 1) = A;
    results(iter, 2) = B;
    results(iter, 3) = t_max;
    results(iter, 4) = A_;
    results(iter, 5) = B_;
    results(iter, 6) = AA_;
    results(iter, 7) = BB_;
    results(iter, 8) = d_;
    results(iter, 9) = t_max_;
    results(iter, 10) = max(max(D1));
    results(iter, 11) = max(max(D2));
    results(iter, 12) = max(max(D3));
    results(iter, 13) = max(max(D4));
    results(iter, 14) = max(max(D1_));
    results(iter, 15) = max(max(D2_));
    results(iter, 16) = max(max(D3_));
    results(iter, 17) = max(max(D4_));
    results(iter, 18) = get_space_angle(D1, max(max(D1)));
    results(iter, 19) = get_space_angle(D2, max(max(D2)));
    results(iter, 20) = get_space_angle(D3, max(max(D3)));
    results(iter, 21) = get_space_angle(D4, max(max(D4)));
    results(iter, 22) = get_space_angle(D1_, max(max(D1)));
    results(iter, 23) = get_space_angle(D2_, max(max(D2)));
    results(iter, 24) = get_space_angle(D3_, max(max(D3)));
    results(iter, 25) = get_space_angle(D4_, max(max(D4)));
    results(iter, 26) = get_energy_ratio(1.5, 1.5, d_, AA_, BB_, R, k, num);
   
    fig = figure(iter);
    subplot(2, 2, 1)
    plot_D(D1, red);
    hold on
    plot_D(D1_, green);
    hold off
    subplot(2, 2, 2)
    plot_D(D2, red);
    hold on
    plot_D(D2_, green);
    hold off
    subplot(2, 2, 3)
    plot_D(D3, red);
    hold on
    plot_D(D3_, green);
    hold off
    subplot(2, 2, 4)
    plot_D(D4, red);
    hold on
    plot_D(D4_, green);
    hold off
    saveas(fig, sprintf('%d th result ', iter));
    %}
    waitbar(iter/testdata_size)
end
close(processbar)
csvwrite('results1.csv', results);
    