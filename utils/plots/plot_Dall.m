function plot_Dall(D, color)
    subplot(2, 2, [1, 3])
    plot_D(D, color)
    subplot(2, 2, 2)
    plot_Dxz(D)
    subplot(2, 2, 4)
    plot_Dyz(D)
end