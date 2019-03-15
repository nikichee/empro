function [ val ] = get_value_from_nifti( mnicoo, filepath )
%[ val ] = get_value_from_nifti( mnicoo, filepath )
%   mnicoo = [x y z]; mni coordinates from where to extract the value
%   filepath is nifti file

mnicoo(end+1)=1;

ind2vox=[   -1.5000         0         0   79.5000
         0    1.5000         0 -113.5000
         0         0    1.5000  -71.5000
         0         0         0    1.0000];
% voxelindices=inv(ind2vox)*mnicoo;
voxelcoo=ind2vox\mnicoo'; % more effective and integer


nif=nifti(filepath);
val=nif.dat(voxelcoo(1),voxelcoo(2),voxelcoo(3));

end

