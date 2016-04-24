function viewPans()
%filename1='D:\Draper\ZIM_Imagery_1km\';
filename1='D:\Draper\trainingImages\';
%filename1='D:\Draper\BOT_Imagery_1km\';
%filename1='D:\Draper\KEN_Imagery_1km\';
%filename1='D:\Draper\UrbanImgs\';%take out
%filename1='D:\Draper\trainingImages\';
addpath(filename1);
allPics = strcat(filename1,'*.tif');
srcFiles = dir(allPics);  
length(srcFiles)%take out

offset = 1;%30;%change back to 30
for i = offset : length(srcFiles)
    filename2 = strcat(filename1,srcFiles(i).name)  
    img = imread(filename2);
    if size(img,3)<2 && size(img,1)>10        
        modImg = panImageFMT(img,filename2,true);
        keyPressed = 0;
        while ~keyPressed      
            w = waitforbuttonpress;
            if w ~= 0
                keyPressed = true;
            end    
        end
        close
    end
end