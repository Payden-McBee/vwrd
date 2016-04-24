function [dictionary,classifiedPatches,patchWordID] = createDictionary(images, masks)
numImages = size(images,1);
patchSize = 11; 
allImagePatches = cell(numImages,1);
allMaskPatches = cell(numImages,1);
numTotalPatches = 0;
numPatchesEachImg = zeros(numImages,1);
for i = 1:size(images,1) 
   img = cell2mat(images(i));
   mask = cell2mat(masks(i));
   numRowImg = size(img,1);
   numColImg = size(img,2);
   numRowPatches = floor(numRowImg/patchSize);
   numColPatches = floor(numColImg/patchSize);
   numPatchesImg = numRowPatches*numColPatches;
   patches = zeros(patchSize, patchSize, numPatchesImg);
   maskPatches = zeros(patchSize, patchSize, numPatchesImg);
   %patchImg = img( 1:numRowPatches*patchSize , 1:numColPatches*patchSize ); 
   patchNum = 1;
   for j = 1: numRowPatches
       for k = 1:numColPatches
       %get patches
       patches(:,:,patchNum) = img( (j-1)*patchSize+1:j*patchSize, (k-1)*patchSize+1:k*patchSize );
       maskPatches(:,:,patchNum) = mask( (j-1)*patchSize+1:j*patchSize, (k-1)*patchSize+1:k*patchSize );
       patchNum = patchNum +1;
       end    
   end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %{
   %normalize patches
   for m = 1:numPatchesImg
        meanPatch = ones( patchSize ) * mean(mean(patches(:,:,m)));
        patches(:,:,m) = patches(:,:,m) - meanPatch;
   end
   %}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   allImagePatches{i} = patches; 
   allMaskPatches{i} = maskPatches;
   numPatchesEachImg(i) = size(cell2mat(allImagePatches(i)),3);
   numTotalPatches = numTotalPatches + numPatchesEachImg(i);
end


allPatches = zeros(patchSize,patchSize,numTotalPatches);
allPatchesMasks = zeros(patchSize,patchSize,numTotalPatches);
numPatches = 0;
for i = 1:numImages
    tempPatch = cell2mat(allImagePatches(i));
    tempPatchMask = cell2mat(allMaskPatches(i));
    numPatches = numPatches + numPatchesEachImg(i);
    allPatches( : , : , numPatches - numPatchesEachImg(i) + 1 : numPatches ) = tempPatch; %it's more complicated than that
    allPatchesMasks( : , : , numPatches - numPatchesEachImg(i) + 1 : numPatches ) = tempPatchMask;
end 

%do PCA on patches
patchPCAmatrix = zeros(numTotalPatches,patchSize*patchSize);
allPatchesMasksInRows = zeros(numTotalPatches,patchSize*patchSize);
for j = 1:numPatches
        for k =1:patchSize
            patchPCAmatrix(   j,  (k-1)*patchSize+1:k*patchSize )= allPatches(k,:,j);
            allPatchesMasksInRows(   j,  (k-1)*patchSize+1:k*patchSize ) = allPatchesMasks(k,:,j);
        end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%normalize by variable
normPatchPCAmatrix = patchPCAmatrix;
for i = 1:patchSize
    normPatchPCAmatrix(:,i) = patchPCAmatrix(:,i) - ones(numTotalPatches,1)*mean( patchPCAmatrix(:,i) );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[U,S,V] = svd(normPatchPCAmatrix);
%newS = max(S);
%plot(newS)
numComponents = 15; %40 was determind experimentally, they used 10 in the paper
PCAtransformVector = V(:,1:numComponents);
pcaPatches = normPatchPCAmatrix*PCAtransformVector;
%convert to uint8 if too large
numWords = 60;
[idx,words] = kmeans(pcaPatches,numWords);
patchWordID = zeros(size(pcaPatches,1),1);
for i = 1:numTotalPatches
    pcaPatchV = zeros(numWords,numComponents);
    for j = 1:numComponents
        pcaPatchV(:,j) = pcaPatches(i,j);
    end
    distance = sum(((pcaPatchV - words).^2),2);
    [~,patchWordID(i)] = min(distance);
end
dictionary = words;


%each patch is assigned an urban/nonurban value
classifiedPatches = zeros(numTotalPatches,1);
urban = 1;
nonurban = 0;
for i = 1:numTotalPatches
    mean(allPatchesMasksInRows(i,:)) %%test
    if mean(allPatchesMasksInRows(i,:)) > 0.5
        classifiedPatches(i) = urban;
    else
        classifiedPatches(i) = nonurban;
    end
end
