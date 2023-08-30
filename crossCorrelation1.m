function [measurementRange,F,OPDs] = crossCorrelation1(l,I_out,N)
%crossCorrelation: Cross-correlation method for pressure and temperature data measurement
%Interpolates the input intensity based on spectrometer 'N' and calculates
%cross-correlation within a given range

% CUBIC SPLINE INTERPOLATION
xx=linspace(440*10^-9,690*10^-9,3648); %interpolates lambda range from the beginning to end by the number 'N'
yy=spline(l,I_out,xx); %Recalculates the output spectrum based on the new interpolated lambda
% CROSS CORRELATION  
F = zeros(1,84951);

i=0;

for d=10^-6:0.2*10^-7:1700*10^-6
   
    i=i+1;
    
    for k=1:1:N

        F(i) = F(i) + yy(k)*(cos((4*pi*d)/xx(k))+pi);
        
    end
    
end

%Normalizing F
F = normalize(F,'range');
measurementRange=10^-6:0.2*10^-7:1700*10^-6;
%Finding peaks to determine the OPDs

[~,OPDs]=findpeaks(F,measurementRange,'MinPeakHeight',0.6);
k = OPDs(1)-10^-8;
[~,OPDs]=findpeaks(F,measurementRange,'MinPeakHeight',0.6,'MinPeakDistance',k);

% %Normalizing Range
% measurementRange=measurementRange/(10^-6);

end