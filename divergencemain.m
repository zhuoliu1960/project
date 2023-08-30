clear
n_cable=1;
n_SiC=2.7;
n_air=1;
L1=400*10^-6;%%%%%%%%%%

resolution = 0.01*10^-9;%resolution is 0.01nm
lambda = 440*10^-9:resolution:690*10^-9;%Incident wavelength, one part per 0.01 nm from 440 nm to 690 nm.
[Io,Io_SiC,Io_test,l,l2,l3] = whiteLight(resolution);
%%%%%
D=0:0.0025:3;
deltal=0*10^-6;%Amount of change due to pressure
[result_03]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_03=result_03*2;%%%asymmetrical
deltal=79.33*10^-6;%Amount of change due to pressure
[result_803]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_803=result_803*2;

D=0:0.004167:5;
deltal=0*10^-6;%Amount of change due to pressure
[result_05]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_05=result_05*2;
deltal=79.33*10^-6;%Amount of change due to pressure
[result_805]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_805=result_805*2;

D=0:0.01:12;
deltal=0*10^-6;%Amount of change due to pressure
[result_012]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_012=result_012*2;
deltal=79.33*10^-6;%Amount of change due to pressure
[result_8012]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D);
result_8012=result_8012*2;

% % %%%%%%%%%%%%%% raw data with different pressure (0 2 5)
figure(1), tiledlayout(3,2);
nexttile
plot(lambda,result_03), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
title('raw data under 0MPa, dispersion angle=3°','FontSize',18);
nexttile
plot(lambda,result_03), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 0MPa, dispersion angle=3°','FontSize',18);
nexttile
plot(lambda,result_05), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, dispersion angle=5°','FontSize',18)
nexttile
plot(lambda,result_05), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, dispersion angle=5°','FontSize',18)
nexttile
plot(lambda,result_012), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, dispersion angle=12°','FontSize',18)
nexttile
plot(lambda,result_012), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0MPa, dispersion angle=12°','FontSize',18)
figure(2), tiledlayout(3,2);
nexttile
plot(lambda,result_803), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);ylim([80 165]);set(gca,'FontSize',14);
title('raw data under 230MPa, dispersion angle=3°','FontSize',18);
nexttile
plot(lambda,result_803), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);ylim([95 150]);set(gca,'FontSize',14);
title('raw data under 230MPa, dispersion angle=3°','FontSize',18);
nexttile
plot(lambda,result_805), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=20°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);ylim([80 165]);set(gca,'FontSize',14);
 title('raw data under 230MPa, dispersion angle=5°','FontSize',18)
nexttile
plot(lambda,result_805), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=20°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);ylim([95 150]);set(gca,'FontSize',14);
 title('raw data under 230MPa, dispersion angle=5°','FontSize',18)
nexttile
plot(lambda,result_8012), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=40°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);ylim([80 165]);set(gca,'FontSize',14);
 title('raw data under 230MPa, dispersion angle=12°','FontSize',18)
nexttile
plot(lambda,result_8012), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 60MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);ylim([95 150]);set(gca,'FontSize',14);
 title('raw data under 230MPa, dispersion angle=12°','FontSize',18)
% % % % 
% %%%%%%%%%%%spectrometerOut
[x_03,output_03] = spectrometerOut(0.1,l2,result_03);
[x_803,output_803] = spectrometerOut(0.1,l2,result_803);
[x_05,output_05] = spectrometerOut(0.1,l2,result_05);
[x_805,output_805] = spectrometerOut(0.1,l2,result_805);
[x_012,output_012] = spectrometerOut(0.1,l2,result_012);
[x_8012,output_8012] = spectrometerOut(0.1,l2,result_8012);
% 
% %%%%%%%%%%%demodulation
N=3648;
[measurementRange_03,F_03,OPDs_03] = crossCorrelation1(x_03,output_03,N);
[measurementRange_803,F_803,OPDs_803] = crossCorrelation1(x_803,output_803,N);
[measurementRange_05,F_05,OPDs_05] = crossCorrelation1(x_05,output_05,N);
[measurementRange_805,F_805,OPDs_805] = crossCorrelation1(x_805,output_805,N);
[measurementRange_012,F_012,OPDs_012] = crossCorrelation1(x_012,output_012,N);
[measurementRange_8012,F_8012,OPDs_8012] = crossCorrelation1(x_8012,output_8012,N);

figure(5), tiledlayout(3,1);
nexttile
plot(measurementRange_03,F_03),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa dispersion angle=3°','FontSize',16)
nexttile
plot(measurementRange_05,F_05),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa dispersion angle=5°','FontSize',16)
nexttile
plot(measurementRange_012,F_012),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa dispersion angle=12°','FontSize',16)

figure(6), tiledlayout(3,1);
nexttile
plot(measurementRange_803,F_803),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa dispersion angle=3°','FontSize',16)
nexttile
plot(measurementRange_805,F_805),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa dispersion angle=5°','FontSize',16)
nexttile
plot(measurementRange_8012,F_8012),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF');
ylim([0.45 0.65]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa dispersion angle=12°','FontSize',16)







function[result]=FPI(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,D)
x=0:0.001*10^-3:1.2*10^-3;

d=(100*10^-6)-deltal;
a=((100*10^-6)-d)/((1200*10^-6)^2);
air_cavity=a*x.^2+d;%Setting the reflecting surface

result=0;
number=0;
aperture=0.2*10^-3; %output aperture

for i=1:200
     anglein=D(i);

    angindeg=deg2rad(anglein);%%%Angle of incidence in radians
    k2=tan(angindeg);
    a1=90-anglein;
    ang1= deg2rad(a1);
    k1=tan(ang1);%Slope of incident light

    [xr,yr]=incidencedistance(angindeg,k1,x(i),n_cable,n_SiC,d,a,L1,x);
    
    [X,ang4]=ifthrough(a,L1,n_cable,n_SiC,xr,yr,k1,ang1);
    L=L1/(cos(ang4));
    X=abs(X);


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

  

function[x3,y3]=incidencedistance(angle1,k1,x0,n1,n2,d,a,L1,x)%The point of reflection,n1 air,k2Sic,L1 is the SiC cavity length,reached after the light is incident.
%The ability of this function to find the intersection point still needs to be improved, the coefficient of judging the position of the intersection point 
% can not be adapted to more than 1 ° large angle and 0.01 ° such a small angle, 
% this function is set to set a small angle when the light incidence and outgoing position is the same to improve the problem.


angle2=asin((n1*sin(angle1))/n2);%angle of refraction after incidence
x1=x0+tan(angle2)*L1;%on the coordinates M2 at the intersection of the air cavity and SiC
b=-x1*k1;%The incident light intercept, k1 is the incident light slope
%%%%
y1=a*x.^2+d;% y on M2
y2=k1*x+b;
bz = y1 ./ (y2 + eps);%Find the ratio of the two
bz=abs(bz);
ix = find(bz > 0.3 & bz < 1.2); %Find the subscript of x with a ratio between 0.95 and 1.05 to find the point of intersection.
x3=x(ix);
x3=mean(x3);

if isnan(x3)

    x3=x1;
   
   
end
y3=a*x3.^2+d;

end
