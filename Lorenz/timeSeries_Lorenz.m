% Lorenz attractor example

rhos = [0.5 28 99.65 100.5 160 350];

rho = rhos(2);
sigma = 10;
beta = 8/3;

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

figure 
subplot(3,2,2)
plot(t(t0:end), y(t0:end,1))
subplot(3,2,4)
plot(t(t0:end), y(t0:end,2))
subplot(3,2,6)
plot(t(t0:end), y(t0:end,3))

subplot(3,2,[1,3,5])
plot3(y(t0:end,1), y(t0:end,2), y(t0:end,3)), grid on

