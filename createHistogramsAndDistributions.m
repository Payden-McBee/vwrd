function [Purban, Pnonurban, PurbanGword] = createHistogramsAndDistributions(dictionary, classifiedPatches, patchWordID)
numWords = size(dictionary,1);
Purban = zeros(1,numWords);
Pnonurban = zeros(1,numWords);
PurbanGword = zeros(1,numWords);
numUrbanPatches = sum(classifiedPatches);
TotalNumPatches = size(classifiedPatches,1);
numNonUrbanPatches = TotalNumPatches - numUrbanPatches;
urban = 1;
nonurban = 0;
for i = 1:TotalNumPatches
    if classifiedPatches(i) == urban
        Purban(patchWordID(i)) = Purban(patchWordID(i)) + 1;
    else
        Pnonurban(patchWordID(i)) = Pnonurban(patchWordID(i)) + 1;
    end
end
size(Purban)
figure(1);
bar(Purban)
title('Purban(words)')

figure(2);
bar(Pnonurban)
title('Pnonurban(words)')

Purban = Purban/numUrbanPatches;
Pnonurban = Pnonurban/numNonUrbanPatches;

alpha = numUrbanPatches/TotalNumPatches;
PurbanGword = alpha*Purban./(alpha*Purban + (1-alpha)*Pnonurban);

figure(3);
bar(PurbanGword)
title('P(urban | word) alpha = exact')

alpha = 0.5;
PurbanGword = alpha*Purban./(alpha*Purban + (1-alpha)*Pnonurban);

figure(4);
bar(PurbanGword)
title('P(urban | word) alpha = 0.5')




