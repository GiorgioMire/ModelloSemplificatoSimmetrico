function [M,D]=Theta2Matrices(Theta)
m1_1=Theta(1);
m2_2=Theta(2);
m2_6=Theta(3);
m6_6=Theta(4);
d1_1=Theta(5);
d2_2=Theta(6);
d2_6=Theta(7);
d6_6=Theta(8);
M =[ m1_1,    0,    0;
   0, m2_2, m2_6;
   0, m2_6, m6_6];

D =[ d1_1,    0,    0;
   0, d2_2, d2_6;
   0, d2_6, d6_6];

end