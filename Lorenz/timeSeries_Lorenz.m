% Lorenz attractor example

rhos = [0.5 28 99.65];

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


R = zeros(1, 6);
R(1:2:end) = min(y, [], 1);
R(2:2:end) = max(y, [], 1);
ax = [R(2) R(1) R(1) R(1) R(1)];
ay = [R(3) R(3) R(4) R(3) R(3)];
az = [R(5) R(5) R(5) R(5) R(6)];
p = .9;
q = 1-p;
grey = [.4 .4 .4];
animatedline(ax,ay,az,'color',grey);


set(gca, 'color', 'black');

yanim = animatedline('color','y');
set(gca,'clipping','off')

klear = 'clearpoints(yanim), drawnow';
clear = uicontrol('style','push','string','clear', ...
  'units','norm','pos',[.26 .02 .10 .04], ...
  'callback',klear);

for ii = 1:size(y, 1)
    addpoints(yanim, y(ii, 1), y(ii, 2), y(ii, 3));
    %scatter3(y(ii, 1), y(ii, 2), y(ii, 3), 30, 'r', 'fill');
    drawnow;
    %pause(0.001);
    
   
    cameratoolbar('setmode','orbit')
end


