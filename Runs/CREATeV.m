clc
clear

seqALPHA = [-4:1:8];

% seqALPHA = 10

filename = 'inputs/CREATeV.vap';
for i = 1:length(seqALPHA)
    OUTP(i) = fcnVAP_MAIN(filename, []);
end