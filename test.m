function test()
close all
%directory = 'D:\Draper\trainingImages\MS\';
directory = 'D:\Draper\test1\';
addpath(directory)
patchSize = 11;
numComponentsPCA = 15;
wordThresh = 0.75;
[urbanWords, dictionary, PCAtransformVector] = train(directory, patchSize, numComponentsPCA, wordThresh);

%classify training data

%classify test data

%directory = 'D:\Draper\testImages\MS';
images = loadImages(directory);
masks = loadImageRegionMasks(directory);
% PCA transform test image 
[pcaPatches, numRowPatches, numColPatches, trueClassifiedPatches] = patchMatrixTransform(images, masks, PCAtransformVector, patchSize);
%Assign word to each by smallest Euclidean Distance 
EuclideanClassifiedPatches = assignWordsToPatches(pcaPatches, dictionary, numComponentsPCA);
%create urban "mask" by word patch
[computedMask, trueMask] = createMasks(EuclideanClassifiedPatches, numRowPatches, numColPatches, patchSize, urbanWords, trueClassifiedPatches);
%display resulting image w/ error (pixels classified as urban compared to
displayClassifiedImg(images, trueClassifiedPatches, EuclideanClassifiedPatches, patchSize);

%training data)



