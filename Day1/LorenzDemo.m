% Lorenz attractor example

% System parameters
rhos = [0.5 350 28];

rho = rhos(1);
sigma = 10;
beta = 8/3;


% Set up system of differential equations
eta = sqrt(beta*(rho-1));

A = [ -beta    0     eta
        0  -sigma   sigma 
      -eta   rho    -1  ];

opts = odeset('reltol',1.e-3,'refine',4);

tspan = [0 200];


% Initial point at which to solve the system
epsilon = 0;
initial_state = [5;5;5+epsilon];

% Solve system of differential equations
[t, solution] = ode45(@lorenzeqn, tspan,  initial_state, opts, A);


% Plot the curve (x(t), y(t), z(t))  (solution)
x = solution(:,1);
y = solution(:,2);
z = solution(:,3);

t_initial = 800;
color_initial = [.7 .7 .7];
color_final = [0 .447 .741];


figure 
subplot(3,2,2)
plot(t(1:(t_initial-1)), x(1:(t_initial-1)), 'Color', color_initial)
hold on
plot(t(t_initial:end), x(t_initial:end), 'Color', color_final)

subplot(3,2,4)
plot(t(1:(t_initial-1)), y(1:(t_initial-1)), 'Color',color_initial)
hold on
plot(t(t_initial:end), y(t_initial:end), 'Color', color_final)

subplot(3,2,6)
plot(t(1:(t_initial-1)), z(1:(t_initial-1)), 'Color', color_initial)
hold on
plot(t(t_initial:end), z(t_initial:end), 'Color', color_final)

subplot(3,2,[1,3,5])
plot3(x(1:(t_initial-1)), y(1:(t_initial-1)), z(1:(t_initial-1)), 'Color', color_initial)
grid on
hold on
plot3(x(t_initial:end), y(t_initial:end), z(t_initial:end), 'Color', color_final)

