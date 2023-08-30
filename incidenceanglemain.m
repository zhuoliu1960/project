clear
n_cable=1;
n_SiC=2.7;
n_air=1;
L1=400*10^-6;%%%%%%%%%%

resolution = 0.01*10^-9;
lambda = 440*10^-9:resolution:690*10^-9;%Incident wavelength, one part per 0.01 nm from 440 nm to 690 nm.
[Io,Io_SiC,Io_test,l,l2,l3] = whiteLight(resolution);
%%%%%%
deltal=0*10^-6;%Amount of change due to pressure
anglein=5;%angle of incidence
[result_05]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

deltal=80*10^-6;%因压力而改变的量
anglein=5;%入射角
[result_605]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

deltal=0*10^-6;%因压力而改变的量
anglein=10;%入射角
[result_010]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

deltal=80*10^-6;%因压力而改变的量
anglein=10;%入射角
[result_6010]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

deltal=0*10^-6;%因压力而改变的量
anglein=20;%入射角
[result_030]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

deltal=80*10^-6;%因压力而改变的量
anglein=20;%入射角
[result_6030]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

%%%%%%%%%%%%%% raw data with different pressure (0 2 5)
figure(1), tiledlayout(3,2);
nexttile
plot(lambda,result_05), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
title('raw data under 0MPa, angle of incidence=5°','FontSize',18);
nexttile
plot(lambda,result_05), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 0MPa, angle of incidence=5°','FontSize',18);

nexttile
plot(lambda,result_010), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, angle of incidence=10°','FontSize',18)
nexttile
plot(lambda,result_010), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, angle of incidence=10°','FontSize',18)

nexttile
plot(lambda,result_030), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, angle of incidence=20°','FontSize',18)
nexttile
plot(lambda,result_030), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, angle of incidence=20°','FontSize',18)

figure(2), tiledlayout(3,2);
nexttile
plot(lambda,result_605), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
title('raw data under 230MPa, angle of incidence=5°','FontSize',18);
nexttile
plot(lambda,result_605), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 230MPa, angle of incidence=5°','FontSize',18);
nexttile
plot(lambda,result_6010), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=20°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230MPa, angle of incidence=10°','FontSize',18)
nexttile
plot(lambda,result_6010), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=20°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230MPa, angle of incidence=10°','FontSize',18)
nexttile
plot(lambda,result_6030), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=40°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230MPa, angle of incidence=20°','FontSize',18)
nexttile
plot(lambda,result_6030), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230MPa, angle of incidence=20°','FontSize',18)
% 
% %%%%%%%%%%%spectrometerOut
[x_05,output_05] = spectrometerOut(0.05,l2,result_05);
[x_605,output_605] = spectrometerOut(0.05,l2,result_605);
[x_010,output_010] = spectrometerOut(0.05,l2,result_010);
[x_6010,output_6010] = spectrometerOut(0.05,l2,result_6010);
[x_030,output_030] = spectrometerOut(0.05,l2,result_030);
[x_6030,output_6030] = spectrometerOut(0.05,l2,result_6030);
% % 
% % 
% %%%%%%%%%%%%%demodulation
N=3648;
[measurementRange_05,F_05,OPDs_05] = crossCorrelation1(x_05,output_05,N);
[measurementRange_605,F_605,OPDs_605] = crossCorrelation1(x_605,output_605,N);
[measurementRange_010,F_010,OPDs_010] = crossCorrelation1(x_010,output_010,N);
[measurementRange_6010,F_6010,OPDs_6010] = crossCorrelation1(x_6010,output_6010,N);
[measurementRange_030,F_030,OPDs_030] = crossCorrelation1(x_030,output_030,N);
[measurementRange_6030,F_6030,OPDs_6030] = crossCorrelation1(x_6030,output_6030,N);
% 
figure(5), tiledlayout(3,1);
nexttile
plot(measurementRange_05,F_05),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa angle of incidence=5°','FontSize',16)
nexttile
plot(measurementRange_010,F_010),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa angle of incidence=10°','FontSize',16)
nexttile
plot(measurementRange_030,F_030),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa angle of incidence=20°','FontSize',16)

figure(6), tiledlayout(3,1);
nexttile
plot(measurementRange_605,F_605),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa angle of incidence=5°, radius of the small hole=0.2cm','FontSize',16)
nexttile
plot(measurementRange_6010,F_6010),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa angle of incidence=10°, radius of the small hole=0.2cm','FontSize',16)
nexttile
plot(measurementRange_6030,F_6030),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa angle of incidence=20°, radius of the small hole=0.2cm','FontSize',16)


function[result]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein)
x=-1.2*10^-3:0.001*10^-3:1.2*10^-3;

d=(100*10^-6)-deltal;
a=((100*10^-6)-d)/((1200*10^-6)^2);
air_cavity=a*x.^2+d;%Setting the reflecting surface

result=0;
number=0;
aperture=inf; %output aperture

angindeg=deg2rad(anglein);%%%Angle of incidence in radians
k2=tan(angindeg);
a1=90-anglein;
ang1= deg2rad(a1);
k1=tan(ang1);%Slope of incident light

for i=1:2400
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
        result1 = sensorFPI(lambda,Io_SiC,yr,L,1,ang4);
        result = result + result1 ;
        number=number+1;
    end
    
end
end
