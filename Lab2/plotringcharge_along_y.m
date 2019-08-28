function [ ] = plotringcharge_y()
    a = 0.5;
    q = 3e-3;
    N = 500;
    y1 = 0.1;
    y2 = 2;
    rho = q / (2*pi*a);
    y = linspace(y1, y2, 300);
    
    Etotal = zeros(1, length(y));
    Ex = zeros(1, length(y));    
    Ey = zeros(1, length(y));    
    Ez = zeros(1, length(y));    
    
    for k = 1:length(y)
        [Etotal(k), Ex(k), Ey(k), Ez(k)] = ringofcharge(a, rho, 0, y(k), 0, N);
    end
    
    figure;
    hold on;    
    grid on;
    plot(y, Ex, 'b--');
    plot(y, Ey, 'g-');
    plot(y, Ez, 'r:');
    legend('Ex', 'Ey', 'Ez');
    xlabel('y(m)');
    ylabel('E(m/C)');
end
