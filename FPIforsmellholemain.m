clear
n_cable=1;
n_SiC=2.7;
n_air=1;
L1=400*10^-6;%%%%%%%%%%%SiC cavity length
siCtem=8.24*10^-9;
airtem=0.45*10^-9;
T=500;
L1=L1+T*siCtem;

x=0:10:230;
pre=335.47*10^-9;
b=2.1719*10^-6;
y=pre*x+b;
y=y+airtem*T;

resolution = 0.01*10^-9;%Resolution of 0.01nm
lambda = 440*10^-9:resolution:690*10^-9;%Incident wavelength, one part per 0.01 nm from 440 nm to 690 nm.
[Io,Io_SiC,Io_test,l,l2,l3] = whiteLight(resolution);
%%%%%%
aperture=0.2*10^-3; %output aperture

deltal=y(11);%Amount of change due to pressure
anglein=0;%angle of incidence
[result_0]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein,aperture);
deltal=y(24);
anglein=0;
[result_80]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein,aperture);

%%%%%%%%%%%%% raw data with different pressure (0 2 5)
figure(1), tiledlayout(2,2);
nexttile
plot(lambda,result_0), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.4*10^-7 6.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 0Pa, radius of the small hole=0.2cm','FontSize',18);
nexttile
plot(lambda,result_0), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 0Pa high frequency, radius of the small hole=0.2cm','FontSize',18);

nexttile
plot(lambda,result_80), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([4.4*10^-7 6.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230Pa, radius of the small hole=0.2cm','FontSize',18)
nexttile
plot(lambda,result_80), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230Pa high frequency, radius of the small hole=0.2cm','FontSize',18)

% %%%%%%%%%%%%spectrometerOut
[x_01,output_01] = spectrometerOut(0.1,l2,result_0);
[x_801,output_801] = spectrometerOut(0.1,l2,result_80);

figure(4), tiledlayout(1,2);
nexttile
plot(x_01,output_01), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 0 Pa, resolution=0.1nm','FontSize',16);

nexttile
plot(x_801,output_801), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 230MPa, resolution=0.1nm','FontSize',16)
% 
% %%%%%%%%%%%%%%crossCorrelation
N=3648;
[measurementRange_01,F_01,OPDs_01] = crossCorrelation1(x_01,output_01,N);
[measurementRange_801,F_801,OPDs_801] = crossCorrelation1(x_801,output_801,N);

figure(5), tiledlayout(2,1);
nexttile
plot(measurementRange_01,F_01),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 0MPa resolution=0.1nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa, resolution=0.1nm, radius of the small hole=0.2cm','FontSize',16)

nexttile
plot(measurementRange_801,F_801),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 230MPa resolution=0.1nm','FontSize',20);
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa, resolution=0.1nm, radius of the small hole=0.2cm','FontSize',16)


function[result]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein,aperture)
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

for i=700:1700%%%%%%
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