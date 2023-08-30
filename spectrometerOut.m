function [edges,output] = spectrometerOut(spectrometerResolution,lambda_interval,Iout)
%spectrometerOut: Takes the average of the high resolution simulation
%points 
%Intervals are defined based on spectrometer specs

% Wavelength range is splitted into intervals based spectrometer steps

stepSize = spectrometerResolution*10^-9;      
edges = min(lambda_interval) : stepSize : max(lambda_interval); 

% Determine x positions within the preset intervals

[~, ~, pos] = histcounts(lambda_interval,[edges,inf]);

% Calculate the mean at each interval

output = splitapply(@(high_res)mean(high_res,'omitnan'),Iout,pos); 
end

