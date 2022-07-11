function ma = get_ma_vector(m2, m3, m4, m5, m6, theta2, dtheta2, theta3,... 
              dtheta3, ddtheta3, theta5, dtheta5, ddtheta5,... 
              r2, r3, r4, r5, ddr6)

b2 = r2/2;
b3 = r3/2;
b5 = r5/2;

I_3 = (1/3)*m3*r4^2;
I_5 = (1/3)*m5*(r5^2);

a_G2x = -b2*dtheta2^2*cos(theta2);
a_G2y = -b2*dtheta2^2*sin(theta2);

a_G3x = -b3*ddtheta3*sin(theta3)-b3*dtheta3^2*cos(theta3);
a_G3y = -b3*ddtheta3*cos(theta3)-b3*dtheta3^2*sin(theta3);

a_G4x = -r2*dtheta2^2*cos(theta2);
a_G4y = -r2*dtheta2^2*sin(theta2);

a_G5x = -r4*ddtheta3*sin(theta3)-r4*dtheta3^2*cos(theta3)-b5*ddtheta5 ...
        *sin(theta5)-b5*dtheta5^2*cos(theta5);
a_G5y = -r4*ddtheta3*cos(theta3)-r4*dtheta3^2*sin(theta3)-b5*ddtheta5 ...
        *cos(theta5)-b5*dtheta5^2*sin(theta5);
    
a_6y = -ddr6;

ma = [ m2*a_G2x;
       m2*a_G2y;
       0;
       m4*a_G4x;
       m4*a_G4y;
       m3*a_G3x;
       m3*a_G3y;
       I_3*ddtheta3
       m5*a_G5x;
       m5*a_G5y;
       I_5*ddtheta5;
       0;
       m6*a_6y;
    ];

end