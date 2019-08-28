function [ Etot, V, Ex, Ey, Ez ] = sphere_of_charge_non( a, rho_s, x, y, z, N )
    epsilon = 8.854e-12;
    dtheta = pi/N;
    dphi = 2*pi/N;

    theta = linspace(0, pi, N + 1);
    phi = linspace(dphi, 2*pi, N);

    dEx_theta = zeros(1, length(theta));
    dEy_theta = zeros(1, length(theta));
    dEz_theta = zeros(1, length(theta));

    dV_theta = zeros(1, length(theta));

    dEx_phi = zeros(1, length(phi));
    dEy_phi = zeros(1, length(phi));
    dEz_phi = zeros(1, length(phi));

    dV_phi = zeros(1, length(phi));

    for v = 1: length(phi)
      for u = 1: length(theta)
        delta_x = a*sin(theta(u))*cos(phi(v));
        delta_y = a*sin(theta(u))*sin(phi(v));
        delta_z = a*cos(theta(u));
        R = ((x-delta_x)^2 + (y-delta_y)^2 + (z-delta_z)^2)^(0.5);

        common_factor = (a^2)*sin(theta(u))*rho_s(u, v)*dtheta*dphi/(4*pi*epsilon*R^3);
        dEx_theta(u) = common_factor*(x-delta_x);
        dEy_theta(u) = common_factor*(y-delta_y);
        dEz_theta(u) = common_factor*(z-delta_z);

        dV_theta(u) = (a^2)*sin(theta(u))*rho_s(u, v)*dtheta*dphi/(4*pi*epsilon*R);
      end
      dEx_phi(v) = sum(dEx_theta);
      dEy_phi(v) = sum(dEy_theta);
      dEz_phi(v) = sum(dEz_theta);

      dV_phi(v) = sum(dV_theta);
    end

    Ex = sum(dEx_v);
    Ey = sum(dEy_v);
    Ez = sum(dEz_v);

    V = sum(dV_v);

    Etot = (Ex ^ 2 + Ey ^ 2 + Ez ^ 2) ^ (0.5);
end