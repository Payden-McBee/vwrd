function images = loadImages(directory)

addpath(directory)
allPics = strcat(directory,'*.tif');
srcFiles = dir(allPics);  
numImages = length(srcFiles);
images = cell(numImages,1);%files are different sizes, cannot be array

for i = 1 : numImages
    filename = strcat(directory,srcFiles(i).name);   
    [tempI,map] = imread(filename);
    simg = MSimageFMT(tempI);
    temp2=rgb2gray(simg(:,:,1:3));
    imshow(temp2)
    images{i}= temp2;
end





