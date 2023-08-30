function[result]=FPIhole(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein,aperture)
x=-1.2*10^-3:0.001*10^-3:1.2*10^-3;
d=(100*10^-6)-deltal;
a=((100*10^-6)-d)/((1200*10^-6)^2);
air_cavity=a*x.^2+d;%Setting the reflecting surface
result=0;
number=0;
angindeg=deg2rad(anglein);%%%Angle of incidence in radians
k2=tan(angindeg);
a1=90-anglein;
ang1= deg2rad(a1);
k1=tan(ang1);%Slope of incident light

for i=700:1700
    if anglein==0
        xr=x(i);
        yr=a*xr.^2+d;
    else
        [xr,yr]=incidencedistance(angindeg,k1,x(i),n_cable,n_SiC,d,a,L1,x);
    end
    [X,ang4]=ifthrough(a,L1,n_cable,n_SiC,xr,yr,k1,ang1);
    L=L1/(cos(ang4));
    X=abs(X);

    if X<aperture
        result1 = sensorFPI(lambda,Io_SiC,air_cavity(i),L,1,ang4);
        result = result + result1 ;
        number=number+1;
    end
    
end
end
