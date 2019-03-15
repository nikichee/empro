% function CIs = getCIs()
% get 90%CIs from contrast estimates from EOI; 
% run SPM and show results of desired contrast (first eedt>odt) first, so that we have SPM and xSPM.  
[voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();%_TR07();
CIs = []; % zeros(1,size(voxelindices,2));
cbetas = [];
for i=1:size(mnicoo,2)
    [cbeta,SE,CI] = extractSPMData(xSPM,SPM,mnicoo(:,i));
    cbetas(:,i) = cbeta;
    CIs(:,i)=CI;
end
% end



% plotting: 