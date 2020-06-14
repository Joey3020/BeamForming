function plot_Dtot(D1, D2, D3, D4, D1_, D2_, D3_, D4_)
    subplot(2, 4, 1)
    plot_Dxz(D1)
    hold on
    plot_Dxz(D1_)
    hold off
    
    subplot(2, 4, 2)
    plot_Dyz(D1)
    hold on
    plot_Dyz(D1_)
    hold off
    
    subplot(2, 4, 3)
    plot_Dxz(D2)
    hold on
    plot_Dxz(D2_)
    hold off
    
    subplot(2, 4, 4)
    plot_Dyz(D2)
    hold on
    plot_Dyz(D2_)
    hold off
    
    subplot(2, 4, 5)
    plot_Dxz(D3)
    hold on
    plot_Dxz(D3_)
    hold off
    
    subplot(2, 4, 6)
    plot_Dyz(D3)
    hold on
    plot_Dyz(D3_)
    hold off
    
    subplot(2, 4, 7)
    plot_Dxz(D4)
    hold on
    plot_Dxz(D4_)
    hold off
    
    subplot(2, 4, 8)
    plot_Dyz(D4)
    hold on
    plot_Dyz(D4_)
    hold off
end