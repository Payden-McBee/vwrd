function train()

%load training images
directory = 'D:\Draper\trainingImages\';
images = loadImages(directory);

%create words from training images
[urbanDictionary, nonurbanDictionary] = createDictionary(images);