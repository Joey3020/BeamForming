function [d_opt, A_opt, B_opt] = linesearch(data, a, b, phase, R, k, num)
    dx = 0.5;
    max_AB = 5;
    max_d = 8;
    
    data = pos_filter(data);
    
    min_loss = 1e20;
    A_opt = 0;
    B_opt = 0;
    d_opt = 0;
    for A = 1:dx:max_AB
        for B = 1:dx:max_AB
            for d = 1:dx:max_d
                [data_, label_] = generate_train_data_point2(a, b, d, A, B, phase, R, k, num);
                data_ = pos_filter(data_);
                cur_loss = MSELoss(data_, data);
                %cur_loss = L1Loss(D_, D);
                if cur_loss < min_loss
                    min_loss = cur_loss;
                    A_opt = A;
                    B_opt = B;
                    d_opt = d;
                end
            end
        end
    end
    save('linesearchMAT')
end