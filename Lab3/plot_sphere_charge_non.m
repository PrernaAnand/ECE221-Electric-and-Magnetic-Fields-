function [ ] = plot_sphere_charge_non()
  a = 0.5;
  N = 200;
  z1 = -3;
  z2 = 3;
  dphi = 2*pi/N;
  rho_s = zeros(N+1, N+1);
  theta = linspace(0, pi, N + 1);
  phi = linspace(dphi, 2*pi, N);
  
  for v = 1:length(phi)
      for u = 1:length(theta)
          rho_s(u, v) = %TA has to give
      end
  end
  
  z = linspace(z1, z2, 100);
  Etot = zeros(1, length(z));
  V = zeros(1, length(z));
  
  for k = 1:length(z)
    [Etot(k), V(k)] = sphere_of_charge_non(a, rho_s, 0, 0, z(k), N);
  end

  figure;
  hold on;
  plot(y, Etot, 'ro');
  legend('Calculated');
  xlabel('z(m)');
  ylabel('E(m/C)');

  figure;
  hold on;
  plot(y, V, 'ro');
  legend('Calculated');
  xlabel('z(m)');
  ylabel('V(Volt)');
end