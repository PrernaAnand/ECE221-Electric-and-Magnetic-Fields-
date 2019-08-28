function [ ] = plotringcharge_along_z()
    epsilon = 8.854e-12;
    a = 0.5;
    q = 3e-3;
    N = 500;
    z1 = 3;
    z2 = -3;
    rho = q / (2*pi*a);
    
    %data points between 100 and 400
    z = linspace(z1, z2, 300); 

    %theory
    Ez = (a * rho / (2 * epsilon)) .* z ./(z.^2 + a^2).^(3/2); 

    Etotal = zeros(1, length(z));
    
    for k = 1:length(z)
        Etotal(k) = ringofcharge(a, rho, 0, 0, z(k), N);
        Etotal(k) = (z(k)/abs(z(k))) * Etotal(k);
    end

    figure;
    hold on;
    plot(z, Ez, 'b');
    plot(z, Etot, 'ro');
    legend('Theory', 'Practical');
    xlabel('z(m)');
    ylabel('E(m/C)');
end