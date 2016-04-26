function [urbanWords, dictionary, PCAtransformVector]= train(directory, patchSize, numComponentsPCA, wordThresh)

%load training images
%directory = 'D:\Draper\trainingImages\MS\';
images = loadImages(directory);
masks = loadImageRegionMasks(directory);
%create words from training images
[dictionary, trueClassifiedPatches, PCAtransformVector, pcaPatches] = createDictionary(images, masks, patchSize, numComponentsPCA);

%each mask differentiates urban (1) from non-urban (0) regions
EuclideanClassifiedPatches = assignWordsToPatches(pcaPatches, dictionary, numComponentsPCA);
[Purban, Pnonurban, PurbanGword] = createHistogramsAndDistributions(dictionary, trueClassifiedPatches, EuclideanClassifiedPatches);

urbanWords = threshold(PurbanGword, wordThresh);

