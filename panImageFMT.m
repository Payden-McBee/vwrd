function modImg = panImageFMT(img,filename,showImage)
%{
fileD = 'D:\Draper\BOT_Imagery_1km\';
addpath(fileD)
file = 'D:\Draper\BOT_Imagery_1km\Bobonong_20091016082517_PAN.tif';
img = imread(file);
%}
imgD = double(img);
[n1, n2] = size(imgD);

v=reshape(imgD,n1*n2,1) ;
lo = prctile(v,5);
hi = prctile(v,95); 
modImg = (imgD - lo) / (hi - lo ) ;
modImg(modImg>1)= 1.0 ;
if showImage
    imshow(modImg);
    title(filename);   
    disp(filename);
end