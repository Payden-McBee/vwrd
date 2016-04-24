function urbanWords = train(directory)
close all
%load training images
%directory = 'D:\Draper\trainingImages\MS\';
images = loadImages(directory);
masks = loadImageRegionMasks(directory);
%create words from training images
[dictionary, classifiedPatches, patchWordID] = createDictionary(images, masks);

%each mask differentiates urban (1) from non-urban (0) regions

[Purban, Pnonurban, PurbanGword] = createHistogramsAndDistributions(dictionary, classifiedPatches, patchWordID);

thresh = 0.35;
urbanWords = threshold(PurbanGword, thresh);

