% Example: Find noisy segments in signals from the
% Motion Artifact Database on Physionet
% Please note that the Matlab wfdb library
% https://physionet.org/physiotools/matlab/wfdb-app-matlab/)
% must be installed and in your Matlab path 
clc
close all
clear all
[~,eeg,~]=rdsamp('motion-artifact/eeg_10',[2],[],[],2);
fs=2048;
[scoring, y]=findnoise(eeg,fs,2);
figure('Position',[520 378 560 600])
ax(1)=subplot(311);
plot([1:length(eeg)]/2048, eeg)
set(gca, 'Fontsize',18)
ylabel({'Amplitude';'(mV)'})
title('Original EEG signal','Fontsize',18)
ax(2)=subplot(312);
plot([1:length(y)]*2,y)
set(gca, 'Fontsize',18)
title('CI (a.u.)','Fontsize',18)
ax(3)=subplot(313);
stairs([1:length(scoring)]*2,scoring) 
xlabel('Time (s)')
set(gca, 'Fontsize',18,'ytick',[0,1],...
    'yticklabel',[{'No artifact'},{'Artifact'}])
axis tight
ylim([-0.2 1.2])
linkaxes(ax,'x')