function urbanWords = threshold(PurbanGword, thresh) 
numWords = size(PurbanGword,1);
j = 1;
for i = 1:numWords
    if PurbanGword(i) > thresh
        urbanWords(j) = i;
        j = j + 1;
    end
end

