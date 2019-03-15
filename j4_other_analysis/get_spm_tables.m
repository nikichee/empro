TabDat={};
for Ic = [1:1];

    xSPM.u=0.001;          %T/F Threshold
    xSPM.k=0;                   %cluster threshold
    xSPM.Ic=Ic;

    xSPM.thresDesc='none';
    % spm_results_ui('Setup',xSPM);
    % xSPM.thresDesc='none';
    [SPM,xSPM] = spm_getSPM(xSPM);

    xSPM.title='';
%     xSPM.k=xSPM.uc(3);

    xSPM.u=xSPM.uc(1);          %T/F Threshold
    xSPM.k=0;                   %cluster threshold
    xSPM.Ic=Ic;

    xSPM.thresDesc='none';
    spm_results_ui('Setup',xSPM);
    xSPM.thresDesc='none';
    [SPM,xSPM] = spm_getSPM(xSPM);
    TabDat{Ic} = spm_list('List',xSPM,hReg,4,8);
%     cd('result_tables');
%     spm_results_export(SPM,xSPM,TabDat)
%     cd('..');
end