# MSE-based-EEG-artifact-detector

#### Overview
Electroencephalographic (EEG) signals present a myriad of challenges to analysis, beginning with the detection of artifacts. This simple algorithm is based on a statistical physics method, multiscale entropy (MSE) analysis, which quantifies the complexity of a signal. Noise corrupted EEG signals have lower information content, and, therefore, reduced complexity compared with their noise free counterparts. The method allows to identify epochs of corrupted noise on a given EEG signal. On an epoch-by-epoch base, the complexity index (CI) of the signal is computed as the sum of the MSE on the first 5 scales. Epochs having a CI lower than a pre-set threshold are scored as containing an artifact.

The code employs the function msentropy.m, from the [WFDB Matlab toolbox](http://physionet.org/physiotools/matlab/wfdb-app-matlab/).

#### Input
Mandatory inputs to the function are:
-	The EEG signal where noisy epochs should be recognized (nx1 vector)
-	The sampling rate of the EEG (1x1 integer)
Optional inputs to the function are:
-	The length of the analysis epoch for the identification of artifacts, in seconds (integer, default = 2 s)
-	The amount of overlap between epochs, in percentage (0-100) (default = 0)
-	The artifact detection threshold. Epochs where the  CI is lower than the threshold are scored as artifacts (default = 1.34)
Along with the function, we provide an example that employs one of the noise-corrupted EEG signals from the the [Motion Artifact Contaminated fNIRS and EEG Data Database on Physionet]( https://physionet.org/pn4/motion-artifact/).

#### Requirements
Matlab R2015a and later versions.
Please note that the [WFDB Matlab toolbox](http://physionet.org/physiotools/matlab/wfdb-app-matlab/) must be installed and in your Matlab path.

#### Acknowledgments
The MSE-based artifact detector software package was developed at the Wyss Institute for Biologically Inspired Engineering at Harvard University and Beth Israel Deaconess Medical Center/Harvard Medical School by Sara Mariani, Filipa Borges and Teresa S. Henriques.

When referencing this software, please cite:
[Sara Mariani, Ana F. T. Borges, Teresa Henriques, Ary L. Goldberger, Madalena D. Costa:
Use of multiscale entropy to facilitate artifact detection in electroencephalographic signals. EMBC 2015: 7869-7872](http://www.ncbi.nlm.nih.gov/pubmed/26738116)

#### More Questions
Please report bugs and questions at sara.mariani7@gmail.com.

#### Related links
- [National Sleep Research Resource](https://sleepdata.org/)

