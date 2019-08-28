function [ ] = plot_sphere_charge()
  epsilon = 8.854e-12;
  a = 0.5;
  N = 200;
  y1 = -3;
  y2 = 3;
  rho_s = 2e-6;

  y = linspace(y1, y2, 100);

  %Electric Field inside a spherical surface is zero
  Etot_theory = (rho_s*a^2)./(epsilon.*(y.^2));
  for i = 1:length(y)
      if abs(y(i)) < a
          Etot_theory(i) = 0;
      end
  end
  
  V_theory = zeros(1, length(y)); 
  for i = 1:length(y)
      if abs(y(i)) < a
          V_theory(i) = rho_s * a / epsilon;
      else
          V_theory(i) = rho_s * a^2 / (epsilon * abs(y(i)));
      end
  end
  
  Etot_calculated = zeros(1, length(y));
  V_calculated = zeros(1, length(y));

  for k = 1:length(y)
    [Etot_calculated(k), V_calculated(k)] = sphere_of_charge(a, rho_s, 0, y(k), 0, N);
  end


  figure;
  hold on;
  plot(y, Etot_calculated, 'b-'); %calculated
  plot(y, Etot_theory, 'ro');  %theory
  legend('Theory', 'Calculated');
  xlabel('y(m)');
  ylabel('E(m/C)');

  figure;
  hold on;
  plot(y, V_calculated, 'b-');  %calculated
  plot(y, V_theory, 'ro');   %theory
  legend('Theory', 'Calculated');
  xlabel('y(m)');
  ylabel('V(Volt)');
end