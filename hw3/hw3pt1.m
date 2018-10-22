
image = imread("image1.jpg");

[rows, columns, colorChannels] = size(image);

newImageBin = binary(image);
newImageHalftone = halftone(image, 0);

figure, imshow(image);
figure, imshow(newImageBin);
figure, imshow(newImageHalftone);

function J = binary(image)
    [rows, columns, colorChannels] = size(image);
    for i=1:rows
       for j=1:columns
           if(image(i,j) > 128)
              image(i,j) = 255;
           else
              image(i,j) = 0;
           end
       end
    end
    J=image;
end

function J = halftone(image, is3x3)
    [rows, columns, colorChannels] = size(image);
    if(is3x3)
        stepSize = 3;
    else
        stepSize = 2;
    end
    for i=1:stepSize:rows
       for j=1:stepSize:columns
           total = 0;
           pixelCount = 0;
           rowBegin = i;
           columnBegin = j;
           rowEnd = rowBegin + stepSize - 1;
           columnBegin = columnBegin + stepSize - 1;
           columnEnd = columnBegin + stepSize -1;
           for k=rowBegin:rowEnd
               for l=columnBegin:columnEnd
                   if(k<=rows && l <=columns)
                       total = total + image(k,l);
                       pixelCount = pixelCount + 1;
                   end
               end
           end
           average = round(total/pixelCount);
           numWhite = 0;
           if(average <= 51)
               numWhite = 0;
           elseif(average > 51 && average <= 102)
               numWhite = round(0.25*pixelCount);
           elseif(average > 102 && average <= 154)
               numWhite = round(0.5*pixelCount);
           elseif(average > 154 && average <= 205)
               numWhite = round(0.75*pixelCount);
           else
               numWhite = pixelCount;
           end
           for k=rowBegin:rowEnd
               for l=columnBegin:columnEnd
                   if(k<=rows && l <=columns)
                        if(numWhite > 0)
                           image(k,l) = 255;
                           numWhite = numWhite - 1;
                        else
                           image(k,l) = 0;
                        end
                    end
                end
           end
       end
    end
    J=image;
end