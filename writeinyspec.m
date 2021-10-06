function writeinyspec(QUAKE,earthmod,attn,g,outp,ptc,len,rdepth,numr,rlatlon,F,lrange,frange)
% WRTIEINYSPEC(QUAKE,earthmod,attn,g,outp,ptc,len,rdepth,numr,rlatlon,F,lrange,frange)
%
% Creates an input parameter files whose format is compatable the program YSPEC.
%
% INPUT:
%
% QUAKE                      [time depth lat lon Mtensor]
% earthmod                   Earh model input parameter for YSPEC [default: prem.200]
% attn                       attenuation switch: 1=on, 0=off [default: 1]
% g                          gravitation: 0=none, 1=cowling; 2=self [default: 2]
% outp                       0=displacement, 1=velocity, 2=acceleration [default: 2]
% ptc                        potential and tilt corrections: 0=no, 1=yes [default: 1]
% len                        length of time series (min)
% rdepth                     receiver depth (km)
% numr                       number of receivers
% rlatlon                    cell array of the latitudes and longitudes of each
%                            receiver
% F                          Frequencies for high-pass and low-pass filters [fh1 fh2 fl3 fl4]
% lrange                     Minimum and maximum value of spherical harmonic degree l
% frange                     Minimum and maximum frequencies for the calculations in mhz [fmin fmax]
%
% NOTES:
%
% Requires repository slepian_oscar. Format for input parameter file for 
% YSPEC in yspec manual. Line spacing matters.
%
% See YSPEC and readCMT
%
% Last modified by pdabney@princeton.edu, 10/06/21

\
% Create output file in the format to create input parameter file for YSPEC
fileID=fopen('yspec.in'); % Input file name must be 'yspec.in'


% WRITE INPUT PARAMETER FILE
fprintf(fileID, '# This file contains the parameters needed to run the \n# program yspec\n')
fprintf(fileID,'\n# prefix for output files\n yspec.out\n')
fprintf(fileID,'\n# Earth model\n %s\n',earthmod)
fprintf(fileID,'\n# attenuation switch\n %d\n', attn)
fprintf(fileID,'\n# gravitation: 0 = none, 1 = cowling, 2 = self\n %d\n',g)
fprintf(fileID,'\n# output: 0 = displacement, 1 = velocity, 2 = acceleration\n %d\n',outp)
fprintf(fileID,'\n# potential and tilt corrections: 0 = no, 1 = yes\n %d\n',ptc)

% spherical harmonic degree l range
fprintf(fileID,'\n# lmin\n %d\n',lmin)
fprintf(fileID,'\n# lmax\n %d\n',lmax)
% frequency maximums and minimums for calculations
fprintf(fileID,'\n# fmin (mHz)\n %d\n',fmin) 
fprintf(fileID,'\n# fmax (mHz)\n %d\n',fmax)

fprintf(fileID,'\n# length of time series\n %d\n',len)
fprintf(fileID,'\n# time step (sec)\n %d\n',ts)

% FILTERING
% high-pass filer
fprintf(fileID,'\n# f11 filter (mHz)\n %d\n',F(1))
fprintf(fileID,'\n# f12 filter (mHz)\n %d\n',F(2))
% low-pass filter
fprintf(fileID,'\n# f21 filter (mHz)\n %d\n',F(3))
fprintf(fileID,'\n# f22 filter (mHz)\n %d\n',F(4))

% Event info
fprintf(fileID,'\n# source depth (km)\n %d\n',QUAKES(2))
fprintf(fileID,'\n# source latitude (deg)\n %d\n',QUAKES(3))
fprintf(fileID,'\n# source longitude (deg)\n %d\n',QUAKES(4))
    
% Moment tensor components
fprintf(fileID,'\n# M_{r,r} (Nm)\n %d\n',QUAKES(5))
fprintf(fileID,'\n# M_{r,theta} (Nm)\n %d\n',QUAKES(6))
fprintf(fileID,'\n# M_{r,phi} (Nm)\n %d\n',QUAKES(7))
fprintf(fileID,'\n# M_{theta,theta} (Nm)\n %d\n',QUAKES(8))
fprintf(fileID,'\n# M_{theta,phi} (Nm)\n %d\n',QUAKES(9))
fprintf(fileID,'\n# M_{phi,phi} (Nm)\n %d\n',QUAKES(10))

% Receiver info
fprintf(fileID,'\n# receiver depth\n %d\n',rdepth)
fprintf(fileID,'\nnumber of receivers\n %d\n',numr)
fprintf(fileID,'\n# receiver latitudes and longitudes\n')
fprintf(fileID,' %f %f\n',rlatlon(:,1),rlatlon(:,2))
    

fclose(fileID);


end