function [scoring, y]=findnoise(varargin)
% scoring=findnoise(signal,fs,epoch,overlap,threshold)
%
% detects noisy epochs on EEG signal based on MSE analysis
% Please note that the Matlab wfdb library
% https://physionet.org/physiotools/matlab/wfdb-app-matlab/)
% must be installed and in your Matlab path 
%
% required inputs: 
% signal --> nx1 column vector containing EEG signal to denoise
% fs --> 1x1 integer containing sampling frequency of signal
%
% optional inputs:
% epoch --> size of the epoch, in seconds, to be marked as containing an
%           artifact or not (default, 2 s)
% overlap --> size of overlap, in percentage (0-100) between one epoch and
%             the next (default, 0)
% threshold--> determines which values of CI are considered noise
%              (default, 1.34, as per published study)
%
% output:
% scoring --> boolean vector of length n/fs/epoch/(1-overlap/100)
%             containing a 0 for each epoch with no artifacts and a 1 for
%             each epoch with an artifact
%
% developed by Sara Mariani at the Wyss Institute for Biologically Inspired
% Engineering at Harvard University
%
% When using this code, please cite:
% "S. Mariani, A. F. T. Borges, T. Henriques, A. L. Goldberger, 
% M. D. Costa. “Use of Multiscale Entropy to Facilitate Artifact Detection 
% in Electroencephalographic Signals”, Engineering in Medicine and Biology 
% Society (EMBC), 37th Annual International Conference of the IEEE, 
% Milan, Italy, 2015."
%
% please report bugs/questions at sara.mariani7@gmail.com
%
% endOfHelp

inputs={'signal','fs','epoch','overlap','threshold'};
Ninputs=length(inputs);
if nargin>Ninputs
    error('Too many input arguments')
end
if nargin<2
    error('Not enough input arguments')
end
% set default parameter values
epoch=2;
overlap=0;
threshold=1.34;
for nn=1:nargin
    eval([inputs{nn} '=varargin{nn};'])
end
% check that your epoch has enough samples to get to scale 5 (3750)
if epoch*fs<3750
    warning(['Be careful: you need at least 3750 samples for accurate MSE'...
        ' computation up to scale 5, and your epochs are only ', ...
        num2str(epoch*fs), ' samples long'])
end
n=length(signal); %in samples
scoring=zeros(floor(n/fs/epoch/(1-overlap/100))-1,1);
y=zeros(size(scoring));
shift=round(epoch*(1-overlap/100)*fs); %shift in samples
        h = waitbar(0,'Please wait...');
for j=0:length(scoring)-1
    waitbar((j+1)/length(scoring),h)
    win=signal(1+shift*j:epoch*fs+shift*j); %window
    y(j+1)=sum(msentropy(win,[],[],[],[],[],[],[],5,[],[]));
    if y(j+1)<threshold
        scoring(j+1)=1;
    end
end
close(h)
end
