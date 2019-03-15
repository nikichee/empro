
% get 90%CIs from contrast estimates from EOI; --> see and run getCIs.m



% This function extracts beta, st error and 90% CI
% for the voxel at the current location in the SPM
% results viewer (or at a location specified in
% the third argument).
% [beta,sterr,ci90] = extractSPMData(xSPM,SPM,[coords]);
% 11/6/2010 J Carlin
function [cbeta,SE,CI] = extractSPMData(xSPM,SPM,coords)

hReg = findobj('Tag','hReg'); % get results figure handle

% Use current coordinates, if none were provided
if ~exist('coords','var')
        coords = spm_XYZreg('GetCoords',hReg);
end

% This is mostly pulled out of spm_graph
[xyz,i] = spm_XYZreg('NearestXYZ',coords,xSPM.XYZmm);
spm_XYZreg('SetCoords',xyz,hReg);
XYZ     = xSPM.XYZ(:,i); % coordinates

%-Parameter estimates:   beta = xX.pKX*xX.K*y;
%-Residual mean square: ResMS = sum(R.^2)/xX.trRV
%----------------------------------------------------------------------
beta  = spm_get_data(SPM.Vbeta, XYZ);
ResMS = spm_get_data(SPM.VResMS,XYZ);
Bcov  = ResMS*SPM.xX.Bcov;

CI    = 1.6449;
% compute contrast of parameter estimates and 90% C.I.
%------------------------------------------------------------------
Ic = 1; % use EOI! before: =xSPM.Ic; % Use current contrast
cbeta = SPM.xCon(Ic).c'*beta;
SE    = sqrt(diag(SPM.xCon(Ic).c'*Bcov*SPM.xCon(Ic).c));
CI    = CI*SE;
end