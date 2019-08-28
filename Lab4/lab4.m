function [V,Ex,Ey,C,gridpointsx,gridpointsy,innerx,innery,outerx,outery] = bvprectangularcoax(a,b,c,d,xo,yo,er,Vo)
      %
      % This function used the finite difference method to solve the
      % two-dimensional electrostatic boundary value problem related to a square
      % coaxial cable.
      % a = width of outer conductor
      % b = height of outer conductor
      % c = width of inner conductor
      % d = height of inner conductor
% xo = the x-coordinate of the location of the bottom left corner of the inner conductor
% yo = the y-coordinate of the location of the bottom left corner of the inner conductor
% er = the relative permittivity of the dielectric which fills the space
% between the inner and outer conductor
% Vo = electric potential of the inner conductor (outer is grounded)
  a = 2e-2;
  b = 2e-2;
  c = 0.5e-2;
  d = 0.5e-2;
  xo = 0.75e-2;
  yo = 0.5e-2;
  er = 2.5;
  Vo = 10;

% Define the fundamental constant eo
  eo=8.854e-12;
  
% Define tolerance to exit loop
  threshold = 1e-4;
  
  % Set number of nodes and node spacings
  Nx=201;
  hx = a/(Nx-1);
  hy = hx;
  Ny=round(b/hy+1);
%   Ny=round(b/hy);

  % the initial values of V to zero
  V = zeros(Nx,Ny);

  % Set the known potential values (or boundary values)
  V(1,1:Ny)=0; % Grounded left side
  V(1:Nx,1)=0; % Grounded bottom side
  V(Nx,1:Ny)=0; % Grounded right side
  V(1:Nx,Ny)=0; % Grounded top side

  innerstartx=round(xo/hx+1);
  innerendx=round(innerstartx+c/hx);
  innerstarty=round(yo/hy+1);
  innerendy=round(innerstarty+d/hy);
  V(innerstartx:innerendx,innerstarty:innerendy)=Vo; % Set potentials of inner conductor

  [gridpointsx,gridpointsy]= meshgrid(0:hx:a,0:hy:b);
  [innerx,innery]= meshgrid((innerstartx-1)*hx:hx:(innerendx-1)*hx,(innerstarty-1)*hy:hy:(innerendy-1)*hy);
  outerx=[0:hx:a,zeros(1,Ny-2),a:-hx:0,zeros(1,Ny-2)];
  outerx((Nx+1):(Nx+Ny-2))=a;
  outery=[zeros(1,Nx),hy:hy:(b-hy),zeros(1,Nx),(b-hy):-hy:hy];
  outery((Nx+Ny-1):(2*Nx+Ny-2))=b;
  
  figure
  plot(gridpointsx,gridpointsy,'b*');
  hold;
  plot(outerx,outery,'kd');
  plot(innerx,innery,'ro');
  
  maxdev = threshold + 1; % initial maxdev to begin loop
  while (maxdev > threshold)
    Vold = V(2:Nx-1, 2:Ny-1);
    for x = 2 : Nx - 1
      for y = 2 : Ny - 1
         if (x < innerstartx || x > innerendx) || (y < innerstarty || y > innerendy)
            V(x, y) = (1/4)*(V(x+1, y) + V(x-1, y) + V(x, y+1) + V(x, y-1));
        end
      end
    end
    Vnew = V(2:Nx-1, 2:Ny-1);    
    maxdev = max(max(abs(100*(Vnew - Vold) ./ (Vnew))));
    Vold = Vnew;
  end

  [Ey, Ex] = gradient(-V, hx, hy);
  
  figure;
  meshc(gridpointsx,gridpointsy,V');
  figure;
  contourf(gridpointsx,gridpointsy,V');
  figure;
  quiver(gridpointsx,gridpointsy,Ex',Ey');

  QbyL = 0;
  for x = innerstartx : innerendx
      for y = innerstarty : innerendy
          if (x == innerstartx && y == innerstarty) 
              QbyL = QbyL + abs(V(x, y) - V(x-1, y-1)) * eo * er;
          elseif (x == innerstartx && y == innerendy) 
              QbyL = QbyL + abs(V(x, y) - V(x-1, y+1)) * eo * er;
          elseif (x == innerendx && y == innerstarty) 
              QbyL = QbyL + abs(V(x, y) - V(x+1, y-1)) * eo * er;          
          elseif (x == innerendx && y == innerendy) 
              QbyL = QbyL + abs(V(x, y) - V(x+1, y+1)) * eo * er;
          elseif (x == innerstartx)
             QbyL = QbyL + abs(V(x, y) - V(x-1, y)) * eo * er;
          elseif(y == innerstarty)
             QbyL = QbyL + abs(V(x, y) - V(x, y-1)) * eo * er; 
          elseif (x == innerendx)
             QbyL = QbyL + abs(V(x, y) - V(x+1, y)) * eo * er;
          elseif(y == innerendy)
             QbyL = QbyL + abs(V(x, y) - V(x, y+1)) * eo * er; 
          end
      end
  end
  
  C = QbyL / Vo; 

end