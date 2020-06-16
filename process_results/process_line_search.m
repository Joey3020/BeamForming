
% exports line search optimal parameters to csv file

function process_line_search(test_data_dir, testdata_size, a_, b_, num, source_name_true, source_name_pred)
    testdata = csvread(test_data_dir);


    labels = testdata(:, end-5:end);
    predictions = zeros(testdata_size, 4);

    processbar = waitbar(0, 'processing output');
    for iter=1:1:testdata_size
        %get test beam
        a = labels(iter, 1);
        b = labels(iter, 2);
        d = labels(iter, 3);
        A = labels(iter, 4);
        B = labels(iter, 5);
        s_angle_max = labels(iter, 6);
        [Dtot, label] = gen_data_point(a, b, d, A, B, s_angle_max, num, source_name_true);
        [d_opt, A_opt, B_opt] = line_search(Dtot, a_, b_, s_angle_max, num, source_name_pred);

        predictions(iter, 1) = d_opt;
        predictions(iter, 2) = A_opt;
        predictions(iter, 3) = B_opt;

        waitbar(iter/testdata_size)
    end
    close(processbar)
    xlswrite('linesearch_predictions.xlsx', predictions, 1);
end