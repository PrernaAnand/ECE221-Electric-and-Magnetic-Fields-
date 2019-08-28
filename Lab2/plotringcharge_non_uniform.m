function [ ] = plotringcharge_non_uniform()
    a = 0.5;
    N = 500;
    z1 = 3;
    z2 = -3;
    phi = linspace(0, 2*pi, N);
    
    rho = 3e-3.*sin(phi);
    
    z = linspace(z1, z2, 201);
    
    Etotal = zeros(1, length(z));
    Ex = zeros(1, length(z));
    Ey = zeros(1, length(z));
    Ez = zeros(1, length(z));
    
    for k = 1:length(z)
        [Etotal(k), Ex(k), Ey(k), Ez(k)] = ringofcharge_non_uniform(a, rho, 0, 0, z(k), N);
    end
    
    figure;
    hold on;
    grid on;    
    plot(z, Ex, 'r--');
    plot(z, Ey, 'g-');
    plot(z, Ez, 'b:');
    legend('Ex', 'Ey', 'Ez');
    xlabel('z(m)');
    ylabel('E(m/C)');
end
