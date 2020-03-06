function [INPU, VEHI, SURF, MISC] = fcnSETTRIM(FLAG, COND, INPU, VEHI, SURF, MISC, trim_rot)
% Function to orient the vehicle and tail based on the computed trim
% conditions

% Rotate vehicle for prescirbed AoA
[ VEHI.matVEHUVW, VEHI.matVEHROT, VEHI.matVEHROTRATE, MISC.matCIRORIG] = fcnINITVEHICLE( COND.vecVEHVINF, INPU.matVEHORIG, trim_rot(1), COND.vecVEHBETA, COND.vecVEHFPA, COND.vecVEHROLL, COND.vecVEHTRK, VEHI.vecVEHRADIUS );
[SURF.matVLST, SURF.matCENTER, INPU.matROTORHUBGLOB, INPU.matROTORAXIS, SURF.matNPVLST, INPU.vecVEHCG, SURF.matEALST, SURF.vecWINGCG, VEHI.vecPAYLCG, VEHI.vecFUSECG, VEHI.vecWINGCG(2,:), VEHI.vecBFRAME] = fcnROTVEHICLEFLEX( SURF.matDVE, SURF.matNPDVE, SURF.matVLST, SURF.matCENTER,...
    INPU.valVEHICLES, SURF.vecDVEVEHICLE, INPU.matVEHORIG, VEHI.matVEHROT, INPU.matROTORHUB, INPU.matROTORAXIS, VEHI.vecROTORVEH,...
    SURF.matNPVLST, INPU.vecVEHCG, SURF.matEALST, SURF.vecWINGCG, VEHI.vecPAYLCG, VEHI.vecFUSECG, VEHI.vecWINGCG(2,:), VEHI.vecBFRAME);

[ SURF.vecDVEHVSPN, SURF.vecDVEHVCRD, SURF.vecDVEROLL, SURF.vecDVEPITCH, SURF.vecDVEYAW,...
    SURF.vecDVELESWP, SURF.vecDVEMCSWP, SURF.vecDVETESWP, SURF.vecDVEAREA, SURF.matDVENORM, ~, ~, SURF.matCENTER ] ...
    = fcnVLST2DVEPARAM(SURF.matDVE, SURF.matVLST);

SURF.matTRIMORIG(2,:) = SURF.matTRIMORIG(2,:) - repmat(INPU.matVEHORIG(1,:),1,1);
dcm = angle2dcm(VEHI.matVEHROT(1,3), VEHI.matVEHROT(1,1), VEHI.matVEHROT(1,2), 'ZXY');
SURF.matTRIMORIG(2,:) = SURF.matTRIMORIG(2,:)*dcm;
SURF.matTRIMORIG(2,:) = SURF.matTRIMORIG(2,:) + repmat(INPU.matVEHORIG(1,:),1,1);

[SURF] = fcnTAILTRIM(SURF, FLAG, COND, trim_rot(2), 1);
