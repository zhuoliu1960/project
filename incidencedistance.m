function[x3,y3]=incidencedistance(angle1,k1,x0,n1,n2,d,a,L1,x)%Reflection point reached after light incident,n1Air,k2Sic,L1 is the SiC cavity length

angle2=asin((n1*sin(angle1))/n2);%angle of refraction after incidence
x1=x0+tan(angle2)*L1;%on the coordinates M2 at the intersection of the air cavity and SiC
b=-x1*k1;%The incident light intercept, k1 is the incident light slope
%%%%Equation of two lines
y1=a*x.^2+d;%on M2
y2=k1*x+b;
bz = y1 ./ (y2 + eps);%Find the ratio of the two
bz=abs(bz);
ix = find(bz > 0.5 & bz < 1.2); %Find the subscripts of x with ratios between 0.95 and 1.05 for the intersection points
x3=x(ix);
x3=mean(x3);
y3=a*x3.^2+d;

end