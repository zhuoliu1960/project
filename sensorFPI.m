function [I_out,air_cavity] = sensorFPI(l,I,air_cavity,basal_cavity,n_cable,ang1)
%Inputs: incident wavelength, light intensity, air cavity length, SIC cavity length, extracavity n
%sensorFPI: Calculates the output spectrum of the 3 interface sensor
%configuration
n_SiC=2.7;
n_air = 1;
cos1= cos(ang1);
cos2= sqrt(1-((n_cable/n_SiC)*sin(ang1))^2);
R1=(abs((n_cable*cos1-n_SiC*cos2)/(n_cable* cos1+n_SiC* cos2)))^2;
%reflectivity of the first interface
ang2=acos(cos2);
cos3= sqrt(1-((n_SiC / n_air)*sin(ang2))^2);
R2=(abs((n_SiC*cos2-n_air*cos3)/(n_air*cos3+n_SiC*cos2)))^2;
%(same as the diaphragm reflectivity)

R_v = 2*R2*cos((4*pi./l).*air_cavity);
R_b = 2*sqrt(R1*R2)*cos((4*pi./l).*n_SiC*basal_cavity);
R_vb = 2*sqrt(R1*R2)*cos((4*pi./l).*(air_cavity+n_SiC*basal_cavity));
R_FP = R1+2*R2+R_v+R_b+R_vb;
Iout=R_FP.*I;
I_out = normalize(Iout,'range');
end