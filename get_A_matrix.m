function A = get_A_matrix(theta2,theta3, theta5, r3, r4, r5) 

beta2 = theta2 - pi;
beta3 = theta3 - pi;
beta5 = theta5 - pi/2;

b5 = r5/2;

A = [ 1 0 0 0 0 -1 0 0 0 0 0 0 0;
      0 1 0 0 0 0 1 0 0 0 0 0 0;
      0 0 0 0 0 -sin(beta2) -cos(beta2) 0 0 0 0 0 1;  
      0 0 0 0 0 1 0 cos((pi/2)+theta3) 0 0 0 0 0;
      0 0 0 0 0 0 -1 sin((pi/2)+theta3) 0 0 0 0 0;
      0 0 -1 0 0 0 0 (cos(theta3-(pi/2))) 1 0 0 0 0;
      0 0 0 -1 0 0 0 (sin(theta3-(pi/2))) 0 -1 0 0 0; 
      0 0 0 0 0 0 0 -r3 r4*sin(beta3) r4*sin(beta3) 0 0 0;
      0 0 0 0 0 0 0 0 -1 0 1 0 0;
      0 0 0 0 0 0 0 0 0 1 0 -1 0;
      0 0 0 0 0 0 0 0 -b5*cos(beta5) b5*sin(beta5)  -b5*cos(beta5) b5*sin(beta5) 0;
      0 0 0 0 1 0 0 0 0 0 -1 0 0;
      0 0 0 0 0 0 0 0 0 0 0 1 0;
    ];

end