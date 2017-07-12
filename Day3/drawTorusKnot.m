function [] = drawTorusKnot(ptheta, pphi, drawTorus, az, el, didx)
    if nargin < 6
        didx = -1;
    end
    [theta, phi] = meshgrid(linspace(0, 2*pi, 64), linspace(0, 2*pi, 128));
    R1 = 4;
    R2 = 1;

    x = (R1 + R2.*cos(phi)) .* cos(theta);
    y = (R1 + R2.*cos(phi)) .* sin(theta);
    z = R2.*sin(phi);
    surf(x, y, z, 'FaceColor', 'blue', 'EdgeColor', 'none');
    camlight left;
    lighting phong
    axis equal;
    if drawTorus
        alpha(.4);
    else
        alpha(0);
    end
    
    lw = 6;
    hold on;
    %R1 = R1 + 0.01;
    %R2 = R2 + 0.01;
    theta = ptheta;
    phi = pphi;
    x = (R1 + R2.*cos(phi)) .* cos(theta);
    y = (R1 + R2.*cos(phi)) .* sin(theta);
    z = R2.*sin(phi);
    plot3(x, y, z, 'r', 'LineWidth', lw);
    
    if drawBand
        x2 = (R1 - R2.*cos(phi)) .* cos(theta);
        y2 = (R1 - R2.*cos(phi)) .* sin(theta);
        z2 = -R2.*sin(phi);
        plot3(x2, y2, z2, 'r', 'LineWidth', lw);
    end
    
    if didx > -1
        hold on;
        scatter3(x(didx), y(didx), z(didx), 100, 'k', 'fill');
        %scatter3(x2(didx), y2(didx), z2(didx), 100, 'k', 'fill');
        %plot3([x(didx), x2(didx)], [y(didx), y2(didx)], [z(didx), z2(didx)], 'k', 'LineWidth', 6);
    end

    view(az, el);
    axis off;
    
end