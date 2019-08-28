function [ Etotal, Ex, Ey, Ez ] = ringofcharge_non_uniform( a, rho, x, y, z, N )
    epsilon = 8.854e-12;
    dt = 2*pi/N;
    phi = linspace(0, 2*pi, N);

    %matrix size - pre -defining size cause the matrix has variable size in
    %every loop cycle
    dEx = zeros(1, length(phi));
    dEy = zeros(1, length(phi));
    dEz = zeros(1, length(phi));

    %from (acos(phi),asin(phi),0) -> to(x,y,z)
    %rho varies 
    for k = 1:N
        x_prime = x - a * cos(phi(k));
        y_prime = y - a * sin(phi(k));
        integrand = a * rho(k) * dt/((x_prime^2 + y_prime^2 + z^2)^(3/2));
        dEx(k) = integrand * x_prime;
        dEy(k) = integrand * y_prime;
        dEz(k) = integrand * z;
    end

    constant = (1/(4 * pi * epsilon));
    Ex = constant * sum(dEx);
    Ey = constant * sum(dEy);
    Ez = constant * sum(dEz);
    Etotal = (Ex ^ 2 + Ey ^ 2 + Ez ^ 2) ^ (1/2);
    
end