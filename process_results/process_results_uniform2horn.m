testdata = csvread('test_data.csv');
predictions = xlsread('predictions.xlsx', 1);

lambda = 1;
num = 64;
k = 2 * pi() / lambda;
R = 10;
a = 1;
b = 1;

len = num * num;

labels = testdata(:, end-5:end);

testdata_size = 200;

green = [0.0, 1.0, 0.0];
blue = [0.0, 0.0, 1.0];
red = [1.0, 0.0, 0.0];

results = zeros(testdata_size, 30);

processbar = waitbar(0, 'processing output');
for iter=1:1:testdata_size
    %get test beam
    A = labels(iter, 4);
    B = labels(iter, 5);
    t_max = labels(iter, 6);
    [D, label] = generate_test_data_point(A, B, t_max, R, k, num);
    [D1, D2, D3, D4] = parse_Dtot(D, num);
    
    d_ = predictions(iter, 1);
    A_ = predictions(iter, 2);
    B_ = predictions(iter, 3);
    t_max_ = predictions(iter, 4);
    
    [D_, labels_] = generate_train_data_point2( a, b, d_, A_, B_, t_max, R, k, num);
    [D1_, D2_, D3_, D4_] = parse_Dtot(D_, num);
    
    results(iter, 1) = A;
    results(iter, 2) = B;
    results(iter, 3) = t_max;
    results(iter, 4) = A_;
    results(iter, 5) = B_;
    %results(iter, 6) = AA_;
    %results(iter, 7) = BB_;
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
    results(iter, 26) = get_energy_ratio(a, b, d_, A_, B_, R, k, num);
    
    fig = figure(iter);
    plot_Dtot(D1, D2, D3, D4, D1_, D2_, D3_, D4_)
    saveas(fig, sprintf('%d th 2d plot ', iter));
    
    fig = figure(iter + testdata_size);
    plot_Dtot3d(D1, D2, D3, D4, D1_, D2_, D3_, D4_)
    saveas(fig, sprintf('%d th 3d plot', iter));
    close all
    
    waitbar(iter/testdata_size)
end
close(processbar)
csvwrite('results1.csv', results);
    