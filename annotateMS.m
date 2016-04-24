function annotateMS()
filename1='D:\Draper\annotatedImages\MS\';
addpath(filename1);
allPics = strcat(filename1,'*.tif');
srcFiles = dir(allPics);  

offset = 10;%30;%change back to 30
for i = offset : offset%length(srcFiles)
    filename2 = strcat(filename1,srcFiles(i).name)  
    img = imread(filename2);
    mask = zeros(size(img,1),size(img,2));
    MSimageFMT(img);  
    keyPressed = 0;
        while ~keyPressed            
            h = imfreehand(gca);
            position = wait(h);
            mask = mask | h.createMask();
            w = waitforbuttonpress;
            if w ~= 0
                keyPressed = true;
            end    
        end
        close
        filename = strcat(filename2,'mask')
        csvwrite(filename,mask)
end