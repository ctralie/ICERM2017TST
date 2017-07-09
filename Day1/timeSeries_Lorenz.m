% Lorenz attractor example
function [t, y] = timeSeries_Lorenz(rho, sigma, beta)
    eta = sqrt(beta*(rho-1));

    A = [ -beta    0     eta
            0  -sigma   sigma 
          -eta   rho    -1  ];

    opts = odeset('reltol',1.e-3,'refine',4);

    tspan = [0 200];

    yc = [rho-1; eta; eta];
    y0 = yc + [0; 0; 3];

    [t, y] = ode45(@lorenzeqn, tspan,  y0, opts, A);

    t0 = 200;
    t = t(t0:end);
    y = y(t0:end, :);
end

