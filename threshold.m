function urbanWords = threshold(PurbanGword, thresh) 
numWords = size(PurbanGword,2);
urbanWords = zeros(size(PurbanGword,2),1);
urban = 1;
nonurban = 0;
for i = 1:numWords
    if PurbanGword(i) > thresh
        urbanWords(i) = urban;
    else
        urbanWords(i) = nonurban;
    end
end

