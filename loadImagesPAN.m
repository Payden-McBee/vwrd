function images = loadImages(directory)

addpath(directory)
allPics = strcat(directory,'*.tif');
srcFiles = dir(allPics);  
numImages = 1;%length(srcFiles);
images = cell(numImages,1);%files are different sizes, cannot be array

for i = 1 : numImages
    filename = strcat(directory,srcFiles(i).name);   
    img = imread(filename); 
    modImg = panImageFMT(img,filename,false); %modify img pixel value range (it's too dark)
    images{i}=modImg;
    
  
    
end





