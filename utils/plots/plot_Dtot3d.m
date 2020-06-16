function plot_Dtot3d(D1, D2, D3, D4, D1_, D2_, D3_, D4_)
    red = [1, 0, 0];
    green = [0, 1, 0];
    
    subplot(2, 4, 1)
    plot_D(D1, red)
    subplot(2, 4, 2)
    plot_D(D1_, green)
    subplot(2, 4, 3)
    plot_D(D2, red)
    subplot(2, 4, 4)
    plot_D(D2_, green)
    subplot(2, 4, 5)
    plot_D(D3, red)
    subplot(2, 4, 6)
    plot_D(D3_, green)
    subplot(2, 4, 7)
    plot_D(D4, red)
    subplot(2, 4, 8)
    plot_D(D4_, green)
    
end