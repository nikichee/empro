function [ M, Wm ] = meanInSphere( fname, varargin )
%meanInSphere Computes the mean of the values in a nifti using a sphere.
%   Computes the mean of the values in the Nifti fname using a
%   sphere with center c (length 3 vector of indices) and radius r (in voxel)
%   using weights for voxel at the border of the sphere acquired using n^3
%   subsamples. Alternativly, supply fname and path to a weighting nifti
%   for computing the mean.

nii = nifti(fname);

if nargin == 2
    fnameW = varargin{1};
    nii_w = nifti(fnameW);
    Wm = nii_w.dat(:,:,:);
    V = nii.dat(:,:,:);
    Vm = ~isnan(V);
    M = sum(V(Vm) .* Wm(Vm)) ./ sum(Wm(Vm));
else
    c = varargin{1};
    r = varargin{2};
    
    if nargin < 4
        n = 50;
    else
        n = varargin{3};
    end
    
    marg = 1.1;
    b = ceil(marg*r);
    
    [I,J,K] = ndgrid(-floor(b+c(1)):ceil(b+c(1)), -floor(b+c(2)):ceil(b+c(2)), -floor(b+c(3)):ceil(b+c(3)));
    
    I = I(:); J = J(:); K = K(:);
    
    % make sure that our points lie inside the nifti
    m = I < 1 | J < 1 | K < 1 | I > nii.dat.dim(1) | J > nii.dat.dim(2) | K > nii.dat.dim(3);
    I(m) = []; J(m) = []; K(m) = [];
    
    % make center weights
    d = (I-c(1)).^2 + (J-c(2)).^2 + (K-c(3)).^2;
    W = double(d <= r.^2);
    
    % voxels along the surface of the sphere
    ms = d <= (r+2)^2 & d >= (r-2)^2;
    Is = I(ms);
    Js = J(ms);
    Ks = K(ms);
    
    % sample voxels
    [Iv,Jv,Kv] = ndgrid(linspace(-0.5,0.5, n));
    Iv = Iv(:); Jv = Jv(:); Kv = Kv(:);
    
    Ir = Is(:,ones(1,length(Iv))) + Iv(:,ones(1, length(Is))).';
    Jr = Js(:,ones(1,length(Jv))) + Jv(:,ones(1, length(Js))).';
    Kr = Ks(:,ones(1,length(Kv))) + Kv(:,ones(1, length(Ks))).';
    
    Ws = mean( (Ir-c(1)).^2 + (Jr-c(2)).^2 + (Kr-c(3)).^2 <= r.^2, 2);
    W(ms) = Ws;
    
    Ind = sub2ind(nii.dat.dim, I, J, K);
    
    V = nii.dat(Ind);
    Vn = isnan(V);
    
    M = sum(W(~Vn) .* V(~Vn)) / sum(W(~Vn));
    
    Wm = zeros(nii.dat.dim);
    Wm(Ind) = W;
    
    % save weight matrix
    [pth,nam,ext] = fileparts(fname);
    nii.dat.fname = fullfile(pth, ['W_' nam ext]);
    create(nii);
    nii.dat(:,:,:) = Wm;
end
end

