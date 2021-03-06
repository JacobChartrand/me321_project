%% ME321 Project - Jacob Chartrand, Jared Elliott, Chris Gosk
clear; clc; close all;

%%Fixed lengths
r1 = 5*10^(-2); % m  o2o
r2 = 2*10^(-2); % m  o2a
r4 = 8.5*10^(-2); % m o3B
r5 = 3*10^(-2); % m BC
r7 = 10*10^(-2); % m o2o4.

%Driving link parameters
theta2 = deg2rad(1):deg2rad(1):deg2rad(360); % from 0-360 degrees
dtheta2 = -10; % 10 rad/s CCW constant rotation
ddtheta2 = 0;  % 0 rad/s^2 angular acceleration

%% Part 1- Calculations for kinematic variables, loop closure eqn

%Displacments
r3 = sqrt((r1.*r1 + r2.*r2 -2.*r2.*r1.*cos(theta2)));
theta3 = -asin(r2.*sin(theta2)./r3)+pi;
theta5 = acos((-r7-r4.*cos(theta3))/r5);
r6 = -r4.*sin(theta3)-r5.*sin(theta5); 

%Velocities
dtheta3 = -r2.*dtheta2.*cos(theta2-theta3);
dtheta5 = -r4.*dtheta3.*sin(theta3)./(r5.*sin(theta5));
dr3 = sqrt(r3.*r3.*dtheta3.*dtheta3+r2.*r2.*dtheta2.*dtheta2-2.*r2.*r3.*...
        dtheta2.*dtheta3.*cos(theta3-theta2));
dr4 = 0;
dr6 = r4.*dtheta3.*sin(theta3-theta5)./(sin(theta5));

%Acelerations
ddtheta3 = (-2.*dr3.*dtheta3 +r2.*dtheta2.*dtheta2.*sin(theta3-theta2))...
        ./r3;
ddtheta5 = (r4.*ddtheta3.*sin(theta3)+r4.*dtheta3.*dtheta3.*cos(theta3)...
        +r5.*dtheta5.*dtheta5.*cos(theta5))./(-r5.*sin(theta5));
ddr6 = r4.*dtheta3.*dtheta3.*sin(theta3)-r4.*ddtheta3.*cos(theta3)+r5.*...
        dtheta5.*dtheta5.*sin(theta5)-r5.*ddtheta5.*cos(theta5);


%% Plot vars;

for x = 1:1:360 %Mechanism Animation
figure (1)

%Plot fixed points
plot (0,0,'^','MarkerFaceColor', [0 0 0],'MarkerEdgeColor', [0 0 0]) %o2
hold on
plot (r1,0,'^','MarkerFaceColor', [0 0 0],'MarkerEdgeColor', [0 0 0]) %o3
hold on

%Positions of joints
%      o2   A2          o3    B                         C
Cx = [0   r2.*cosd(x)   r1    r1+r4.*cos(theta3(x))      r1-r7 ];
Cy = [0   r2.*sind(x)   0     r4.*sin(theta3(x))        -r6(x) ];

%Connecting joints with lines
Link2 = line([Cx(1) Cx(2)], [Cy(1) Cy(2)], 'color', 'r', 'linewidth', 2);
Link3 = line([Cx(3) Cx(4)], [Cy(3) Cy(4)], 'color', 'b', 'linewidth', 2 );
Link5 = line([Cx(4) Cx(5)], [Cy(4) Cy(5)], 'color', 'g', 'linewidth', 2);
hold off

%Plot wall slider block
rectangle('Position',[-5.5*10^(-2) -r6(x)-1*10^(-2) 1*10^(-2) 2*10^(-2)],...
        'FaceColor', [0.9290 0.6940 0.1250]);
hold on
set(gca,'Children',flipud(get(gca,'Children'))) %Places link5 over slider

%Plot slider
slider_height = 0.5*10^(-2);
slider_width = 0.25*10^(-2);

slider = polyshape([Cx(2)-slider_height Cx(2)-slider_height ...%X points
    Cx(2)+slider_height Cx(2)+slider_height], ... 
    [Cy(2)+slider_width Cy(2)-slider_width ... %Y points
    Cy(2)-slider_width Cy(2)+slider_width]); %Slider position
slider = rotate(slider,rad2deg(theta3(x)),[Cx(2) Cy(2)]); %Slider Rotation
plot(slider, 'FaceColor', [0.9290 0.6940 0.1250]);
hold off

%Axis formatting
axis equal
axis ([-0.07 0.1 -0.12 0.12])

end



%theta3/dtheta3/ddtheta3 v theta 
figure (2)
plot(theta2,theta3)
grid on
title('$\theta_3$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('\theta_3 unit: rad')

figure (3)
plot(theta2,dtheta3)
grid on
title('d $\theta_3$ vs $\theta_2$', 'Interpreter','latex')
xlabel(' \theta_2   unit: rad')
ylabel('d \theta_3 unit: rad/s')

figure (4)
plot(theta2, ddtheta3)
grid on
title('dd $\theta_3$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('dd \theta_3 unit: rad/s^2')

%Theta5 

figure (5)
plot(theta2,theta5)
grid on
title('$\theta_5$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('\theta_5 unit: rad')

figure (6)
plot(theta2,dtheta5)
grid on
title('d $\theta_5$ vs $\theta_2$', 'Interpreter','latex')
xlabel(' \theta_2   unit: rad')
ylabel('d \theta_5 unit: rad/s')

figure (7)
plot(theta2, ddtheta5)
grid on
title('dd $\theta_5$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('dd \theta_5 unit: rad/s^2')


%Slider 6 displacment, Speed Accleration

figure (8)
plot(theta2,-r6)
grid on
title('$r6$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('r6 unit: m')

figure (9)
plot(theta2,-dr6)
grid on
title('$dr6$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('dr6 unit: m/s')

figure (10)
plot(theta2,-ddr6)
grid on
title('$ddr6$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: rad')
ylabel('ddr6 unit: m/s^2')
 
%*****************************************************
%% Part 2 - Force and Moment Calculation

%%initial parameters:

rho = 2700; % density, kg/m3
d = 0.5*10^(-2); % diameter, m
m6 = 12*10^(-2); % slider mass, kg
m4 = 12*10^(-2); % slider mass, kg
m2 = pi*(d/2)^2*r2; % link 2, o2a2 kg
m5 = pi*(d/2)^2*r5; % link 5, BC kg

M12_list = [];
Fs_list  = []; % Shaking force
Fs_alpha = []; % Direction of shaking force
Ms_list  = []; % Shaking moment
theta2_list = [];

%Initializing force magnitude vectors
F12_list = [];
F13_list = [];
F16_list = [];
F24_list = [];
F34_list = [];
F35_list = [];
F56_list = [];

%Initializing force angle vectors
F12_alpha = [];
F13_alpha = [];
F24_alpha = [];
F35_alpha = [];
F56_alpha = [];

for i = 1:1:360
    %Calculate m3, changes with theta2
    m3 = pi*(d/2)^2*r3(i); % link 3, o3a3 kg
    
    %Create ma vector based on input variables at angle i
    B = get_ma_vector(m2, m3, m4, m5, m6, theta2(i), dtheta2, theta3(i),... 
              dtheta3(i), ddtheta3(i), theta5(i), dtheta5(i), ddtheta5(i),... 
              r2, r3(i), r4, r5, ddr6(i));

    
    %Create A matrix based on input variables at angle i
    A = get_A_matrix(theta2(i),theta3(i), theta5(i), r3(i), r4, r5);

    x = A\ B; % Ax = B, solution for x
    
    % M12:
    M12 = x(13);
    M12_list = [M12_list; M12];
    
    %Assign force to index in x array
    F12x = x(1);
    F12y = x(2);
    F13x = x(3);
    F13y = x(4);
    F16  = x(5);
    F24x = x(6);
    F24y = x(7);
    F34  = x(8);
    F35x = x(9);
    F35y = x(10);
    F56x = x(11);
    F56y = x(12);
    
    %Calculate magnitude for forces
    F12 = sqrt(F12x^2 + F12y^2);
    F13 = sqrt(F13x^2 + F13y^2);
    F24 = sqrt(F24x^2 + F24y^2);
    F35 = sqrt(F35x^2 + F35y^2);
    F56 = sqrt(F56x^2 + F56y^2);
    
    %Calculate shaking force
    Fsx = F12x + F13x + F16;
    Fsy = F12y + F13y;
    Fs = sqrt(Fsx^2 + Fsy^2);

    %Calculate shaking moment
    Ms = M12 + F13y*r1 - F16*r6(i);

    %Add force/moment to new column in respective Fij_list array 
    F12_list = [F12_list; F12];
    F13_list = [F13_list; F13];
    F16_list = [F16_list; F16];
    F24_list = [F24_list; F24];
    F34_list = [F34_list; F34];
    F35_list = [F35_list; F35];
    F56_list = [F56_list; F56];
    Fs_list  = [Fs_list; Fs];
    Ms_list  = [Ms_list; Ms];
    
    % Directions of all forces:    
    fx = F12x;
    fy = F12y;
    alpha_f = atan(fx\fy);
    if F12x < 0
        alpha_f = alpha_f + pi;
    end 
    F12_alpha = [F12_alpha; alpha_f];

    fx = F13x;
    fy = F13y;
    alpha_f = atan(fx\fy);
    if fx < 0
        alpha_f = alpha_f + pi;
    end 
    F13_alpha = [F13_alpha; alpha_f];

    fx = F24x;
    fy = F24y;
    alpha_f = atan(fx\fy);
    if fx < 0
        alpha_f = alpha_f + pi;
    end 
    F24_alpha = [F24_alpha; alpha_f];

    fx = F35x;
    fy = F35y;
    alpha_f = atan(fx\fy);
    if fx < 0
        alpha_f = alpha_f + pi;
    end 
    F35_alpha = [F35_alpha; alpha_f];

    fx = F56x;
    fy = F56y;
    alpha_f = atan(fx\fy);
    if fx < 0
        alpha_f = alpha_f + pi;
    end 
    F56_alpha = [F56_alpha; alpha_f];
   
    fx = Fsx;
    fy = Fsy;
    alpha_f = atan(fx\fy);
    if fx < 0
        alpha_f = alpha_f + pi;
    end 
    Fs_alpha = [Fs_alpha; alpha_f];
  
end

% Kinetics plot deliverables

figure (11)
plot(theta2,Ms_list)
grid on;
title('M_{s} vs \theta_2')
xlabel('\theta_2   unit: rad')
ylabel('M12   unit: N-m')

figure (12)
polarplot(Fs_alpha,Fs_list)
grid on;
title('F_{s} polar plot')

figure (13)
polarplot(F12_alpha,F12_list)
grid on;
title('F_{12} polar plot')

figure (14)
polarplot(F13_alpha,F13_list)
grid on;
title('F_{13} polar plot')

figure (15)
polarplot(F24_alpha,F24_list)
grid on;
title('F_{24} polar plot')

figure (16)
polarplot(F35_alpha,F35_list)
grid on;
title('F_{35} plot')

figure (17)
polarplot(F56_alpha,F56_list)
grid on;
title('F_{56} plot')