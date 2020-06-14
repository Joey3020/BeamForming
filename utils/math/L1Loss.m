function loss = L1Loss(D_, D)
    diff = D_ - D;
    loss = sum(abs(diff), 'all');
end