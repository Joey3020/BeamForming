function loss = MSELoss(D_, D)
    diff = D_ - D;
    loss = sum(diff .* diff, 'all');
end