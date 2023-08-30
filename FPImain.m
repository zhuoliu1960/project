clear
n_cable=1;
n_SiC=2.7;
n_air=1;
L1=400*10^-6;%%%%%%%%%%%

resolution = 0.01*10^-9;%resolution is 0.01nm
lambda = 440*10^-9:resolution:690*10^-9;%Incident wavelength, one part per 0.01 nm from 440 nm to 690 nm.
[Io,Io_SiC,Io_test,l,l2,l3] = whiteLight(resolution);
%%%%%%
deltal=0*10^-6;%Amount of change due to pressure
anglein=0;%angle of incidence
[result_0]=FPIfor2D(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);
deltal=52.49*10^-6;
anglein=0;
[result_50]=FPIfor2D(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);
deltal=79.33*10^-6;
anglein=0;
[result_80]=FPIfor2D(Io_SiC,L1,lambda,n_cable,n_SiC,deltal,anglein);

%%%%%%%%%%%%% raw data with different pressure (0 2 5)
figure(1), tiledlayout(3,2);
nexttile
plot(lambda,result_0), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
title('raw data under 0Pa','FontSize',18);
nexttile
plot(lambda,result_0), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('raw data under 0Pa high frequency','FontSize',18);
nexttile
plot(lambda,result_50), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('White light SiC window raw data under 150Pa','FontSize',18)
nexttile
plot(lambda,result_50), grid on, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 0Pa high frequency','FontSize',18)
nexttile
plot(lambda,result_80), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.5*10^-7 6.5*10^-7]);set(gca,'FontSize',14);
 title('White light SiC window raw data under 230Pa','FontSize',18)
nexttile
plot(lambda,result_80), grid on, xlabel('Wavelength(m)'), ylabel('Intensity'), title('raw data under 0MPa, angle of incidence=40°','FontSize',16);
xlim([5.85*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
 title('raw data under 230Pa high frequency','FontSize',18)

%%%%%%%%%%%spectrometerOut
[x_01,output_01] = spectrometerOut(0.1,l2,result_0);
[x_501,output_501] = spectrometerOut(0.1,l2,result_50);
[x_801,output_801] = spectrometerOut(0.1,l2,result_80);

[x_02,output_02] = spectrometerOut(0.05,l2,result_0);
[x_502,output_502] = spectrometerOut(0.05,l2,result_50);
[x_802,output_802] = spectrometerOut(0.05,l2,result_80);
figure(4), tiledlayout(3,2);
nexttile
plot(x_01,output_01), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 0 Pa, resolution=0.1nm','FontSize',16);
nexttile
plot(x_02,output_02), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 0 Pa, resolution=0.05nm','FontSize',16)
nexttile
plot(x_501,output_501), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 150MPa, resolution=0.1nm','FontSize',16)
nexttile
plot(x_502,output_502), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 150MPa, resolution=0.05nm','FontSize',16)
nexttile
plot(x_801,output_801), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 230MPa, resolution=0.1nm','FontSize',16)
nexttile
plot(x_802,output_802), grid on, axis tight, xlabel('Wavelength(m)'), ylabel('Intensity');
xlim([5.8*10^-7 5.9*10^-7]);set(gca,'FontSize',14);
title('spectrometerOut under 230MPa, resolution=0.05nm','FontSize',16)
%%%%%%%%%%%%%crossCorrelation
N=3648;
[measurementRange_01,F_01,OPDs_01] = crossCorrelation1(x_01,output_01,N);
[measurementRange_501,F_501,OPDs_501] = crossCorrelation1(x_501,output_501,N);
[measurementRange_801,F_801,OPDs_801] = crossCorrelation1(x_801,output_801,N);
[measurementRange_02,F_02,OPDs_02] = crossCorrelation1(x_02,output_02,N);
[measurementRange_502,F_502,OPDs_502] = crossCorrelation1(x_502,output_502,N);
[measurementRange_802,F_802,OPDs_802] = crossCorrelation1(x_802,output_802,N);

figure(5), tiledlayout(3,1);
nexttile
plot(measurementRange_01,F_01),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 0MPa resolution=0.1nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa, resolution=0.1nm','FontSize',16)
nexttile
plot(measurementRange_501,F_501),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 150MPa resolution=0.1nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 150MPa, resolution=0.1nm','FontSize',16)
nexttile
plot(measurementRange_801,F_801),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 230MPa resolution=0.1nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa, resolution=0.1nm','FontSize',16)

figure(6), tiledlayout(3,1);
nexttile
plot(measurementRange_02,F_02),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 0MPa resolution=0.05nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 0MPa  resolution=0.05nm','FontSize',16)
nexttile
plot(measurementRange_502,F_502),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 150MPa resolution=0.05nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 150MPa, resolution=0.05nm','FontSize',16)
nexttile
plot(measurementRange_802,F_802),grid on,xlabel('OPD(m)'), ylabel('Normalised CCF'),title('CCF under 230MPa resolution=0.05nm','FontSize',20);
ylim([0.4 0.6]);xlim([0 1.4*10^-3]);set(gca,'FontSize',14);
title('CCF under 230MPa, resolution=0.05nm','FontSize',16)



