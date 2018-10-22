
image = imread("image1.jpg");
newImage = image;
[rows, columns, colorChannels] = size(image);

function halftone(image, rowBegin, rowEnd, columnBegin, columnEnd)
    rowMid = 0;
    if(rowEnd-rowBegin > 1)
        rowMid = round((rowEnd-rowBegin)/2);
    else
        rowMid = rowEnd;
    end
    columnMid = 0;
    if(columnEnd - columnBegin > 1)
        columnMid = round((columnEnd-columnBegin)/2);
    else
        columnMid = columnEnd;
    end
        
    if(columnEnd-columnBegin == 1 && rowEnd-rowBegin == 1)
        total = 0;
        for i=columnBegin:columnEnd
           for j=rowBegin:columnEnd
               if(image(i,j) > 127)
                  total = total + image(i,j);
               else
                  image(i,j) = 0;
               end
        end
        
    elseif(columnEnd-columnBegin == 1 && rowEnd-rowBegin == 0)
        %equalize 1x2
        
    elseif(columnEnd-columnBegin == 0 && rowEnd-rowBegin == 1)
        %equalize 2x1
    else
        halftone(image, rowBegin, round((rowEnd-rowBegin)/2), columnBegin, round((columnEnd-columnBegin)/2));
        halftone(image, rowBegin, round((rowEnd-rowBegin)/2), round((columnEnd-columnBegin)/2)+1, columnEnd);
        halftone(image, round((rowEnd-rowBegin)/2)+1, rowEnd, columnBegin, round((columnEnd-columnBegin)/2));
        halftone(image, round((rowEnd-rowBegin)/2)+1, rowEnd, round((columnEnd-columnBegin)/2)+1, columnEnd);
    end
      
        
    




end
