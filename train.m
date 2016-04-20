function train()

%load training images
images = 0;
%create words from training images
[urbanDictionary, nonurbanDictionary] = createDictionary(images);