%Programmer: Chris Tralie
%Purpose: To show a flat torus and 3D embedded torus view into the
%state space of periodic and quasiperiodic signals

AnimationSpeed = 20;

addpath('../TDETools');
N1Periods = 5; %Make this higher for irrational to fill out more
theta1 = linspace(0, N1Periods*2*pi, 400);
theta2 = 3*theta1;
theta1 = mod(theta1, 2*pi);
theta2 = mod(theta2, 2*pi);
%Signal
y = cos(theta1) + 0.5*cos(theta2);

%Embedded on T2 in 3D
R1 = 4;
R2 = 1;
xt = (R1 + R2.*cos(theta2)) .* cos(theta1);
yt = (R1 + R2.*cos(theta2)) .* sin(theta1);
zt = R2.*sin(theta2);

C = plotTimeColors(1:length(y), y, 'type', '2DLine');
clf;

subplot(221);
xlim([1, length(y)]);
ylim([-max(abs(y)), max(abs(y))]);
dot1 = animatedline('color', 'k', 'LineWidth', 10, 'Marker', 'o');

hold on;

subplot(222);
xlim([0, 2*pi]);
ylim([0, 2*pi]);
hold on;
dot2 = animatedline('color', 'k', 'LineWidth', 10, 'Marker', 'o');


subplot(2, 2, 3:4);
%Step 1: Draw Torus
[theta, phi] = meshgrid(linspace(0, 2*pi, 64), linspace(0, 2*pi, 128));
R1 = 4;
R2 = 1;
xx = (R1 + R2.*cos(phi)) .* cos(theta);
yy = (R1 + R2.*cos(phi)) .* sin(theta);
zz = R2.*sin(phi);
surf(xx, yy, zz, 'FaceColor', 'blue', 'EdgeColor', 'none');
camlight left;
lighting phong
axis equal;
alpha(0.2);
hold on;
dot3 = animatedline('color', 'k', 'LineWidth', 40, 'Marker', 'o');


cameratoolbar('setmode','orbit');


%Now loop through and incrementally draw
for ii = 2:length(y)
    %Step 1: Plot time series
    subplot(221);
    plot([ii-1, ii], [y(ii-1), y(ii)], 'color', C(ii, 1:3));
    clearpoints(dot1);
    addpoints(dot1, ii, y(ii));
    
    
    
    %Step 2: Plot flat torus state space
    subplot(222);
    diff1 = abs(theta1(ii) - theta1(ii-1));
    diff2 = abs(theta2(ii) - theta2(ii-1));
    if diff1 < pi && diff2 < pi
        plot(theta1(ii-1:ii), theta2(ii-1:ii), 'color', C(ii, 1:3));
    else
        %Split line segment into 2 parts
        xs = theta1(ii-1:ii);
        ys = theta2(ii-1:ii);
        if diff1 >= pi
            xs(2) = xs(2) + 2*pi;
        end
        if diff2 >= pi
            ys(2) = ys(2) + 2*pi;
        end
        m = (ys(2)-ys(1))/(xs(2)-xs(1));
        minv = 1/m;
        if xs(2) > 2*pi
            plot([xs(1), 2*pi], [ys(1), ys(1) + m*(2*pi-xs(1))], 'color', C(ii, 1:3));
            plot([0, xs(2)-2*pi], [ys(1) + m*(2*pi-xs(1)), ys(2)], 'color', C(ii, 1:3));
        end
        if ys(2) > 2*pi
            plot([xs(1), xs(1)+minv*(2*pi-ys(1))], [ys(1), 2*pi], 'color', C(ii, 1:3));
            plot([xs(1)+minv*(2*pi-ys(1)), xs(2)], [0, ys(2)-2*pi], 'color', C(ii, 1:3));
        end
    end
    clearpoints(dot2);
    addpoints(dot2, theta1(ii), theta2(ii));
    
    
    %Step 3: Plot 3D embedded torus
    subplot(2, 2, 3:4);
    plot3([xt(ii-1), xt(ii)], [yt(ii-1), yt(ii)], [zt(ii-1), zt(ii)], ...
        'color', C(ii, 1:3), 'LineWidth', 2);
    clearpoints(dot3);
    addpoints(dot3, xt(ii), yt(ii), zt(ii));
    
    pause(1/AnimationSpeed);
end

