function [I_o,Io_SiC,Io_Test,l1,l2,l3] = whiteLight(resolution)
%whiteLight: Extracts excel spreadsheet data and interpolates it for further use
%- Interpolation based on user defined resolution, which can be a specific resolution 
%of a spectrometer or a high resolution for closeness to the real data
%- Function returns the interpolated output spectrums of the white light source
%as well as the wavelength ranges at which it is interpolated
whiteLight_spectrum = readtable('White_Light_Spec.xlsx','Range','A1:B3649');


y_values = whiteLight_spectrum.Pixel_Values/10^4;
x_values = whiteLight_spectrum.Wavelength_nm*10^-9;

l1 = 177.4049709*10^-9:resolution:890.827133198325*10^-9; %White light bandwidth
l2 = 440*10^-9:resolution:690*10^-9;  % Optical window of SiC 
l3 = 500*10^-9:resolution:700*10^-9;  % Zoomed in interval at central wavelengths 

Io = interp1(x_values,y_values,l1); %Interpolation of the intervals
IoSiC = interp1(x_values,y_values,l2);
IoTest = interp1(x_values,y_values,l3);

% I_o = normalize(Io,'range');
% Io_SiC = normalize(IoSiC,'range');
% Io_Test = normalize(IoTest,'range');
I_o = Io;
Io_SiC = IoSiC ;

Io_Test = IoTest; 
end
