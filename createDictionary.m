function [urbanDictionary, nonurbanDictionary] = createDictionary(images)
numImages = size(images,1);
patchSize = 11; 
allImagePatches = cell(numImages,1);
numTotalPatches = 0;
numPatchesEachImg = zeros(numImages,1);
for i = 1:size(images,1) 
   img = cell2mat(images(i));
   numRowImg = size(img,1);
   numColImg = size(img,2);
   numRowPatches = floor(numRowImg/patchSize);
   numColPatches = floor(numColImg/patchSize);
   numPatchesImg = numRowPatches*numColPatches;
   patches = zeros(patchSize, patchSize, numPatchesImg);
   %patchImg = img( 1:numRowPatches*patchSize , 1:numColPatches*patchSize ); 
   patchNum = 1;
   for j = 1: numRowPatches
       for k = 1:numColPatches
       %get patches
       patches(:,:,patchNum) = img( (j-1)*patchSize+1:j*patchSize, (k-1)*patchSize+1:k*patchSize );
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
   numPatchesEachImg(i) = size(cell2mat(allImagePatches(i)),3);
   numTotalPatches = numTotalPatches + numPatchesEachImg(i);
end


allPatches = zeros(patchSize,patchSize,numTotalPatches);
numPatches = 0;
for i = 1:numImages
    temp = cell2mat(allImagePatches(i));
    numPatches = numPatches + numPatchesEachImg(i);
    allPatches( : , : , numPatches - numPatchesEachImg(i) + 1 : numPatches ) = temp; %it's more complicated than that
end 

%do PCA on patches
patchPCAmatrix = zeros(numTotalPatches,patchSize*patchSize);
for j = 1:numPatches
        for k =1:patchSize
            patchPCAmatrix(   j,  (k-1)*patchSize+1:k*patchSize )= allPatches(k,:,j);
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%normalize by variable
normPatchPCAmatrix = patchPCAmatrix;
for i = 1:patchSize
    normPatchPCAmatrix(:,i) = patchPCAmatrix(:,i) - ones(numTotalPatches,1)*mean( patchPCAmatrix(:,i) );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[V,D] = eig(cov(normPatchPCAmatrix));

%[U,S,V] = svd(patchPCAmatrix);
coeff = pca(normPatchPCAmatrix);
size(coeff)
[pc,score,latent,tsquare] = princomp(normPatchPCAmatrix);
cumsum(latent)./sum(latent);
[coeff,score,latent,tsquared,explained] = pca(normPatchPCAmatrix);
urbanDictionary = 0; nonurbanDictionary = 0;