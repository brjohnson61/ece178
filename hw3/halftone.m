function J = halftone(image, squareWidth)
    stepSize = squareWidth;
    [rows, columns, colorChannels] = size(image);
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
           if(stepSize == 2)
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
           else
               if(average <= 25.5)
                   numWhite = 0;
                   %disp("set 0 pixels white")
               elseif(average > 25.5 && average <= 51)
                   numWhite = round((1/9)*pixelCount);
                   %disp("set 1 pixels white")
               elseif(average > 51 && average <= 76.5)
                   numWhite = round((2/9)*pixelCount);
                   %disp("set 2 pixels white")
               elseif(average > 76.5 && average <= 102)
                   numWhite = round((1/3)*pixelCount);
                   %disp("set 3 pixels white")
               elseif(average > 102 && average <= 127.5)
                   numWhite = round((4/9)*pixelCount);
                   %disp("set 4 pixels white")
               elseif(average > 127.5 && average <= 153)
                   numWhite = round((5/9)*pixelCount);
                   %disp("set 5 pixels white")
               elseif(average > 153 && average <= 178.5)
                   numWhite = round((2/3)*pixelCount);
                   %disp("set 6 pixels white")
               elseif(average > 178.5 && average <= 204)
                   numWhite = round((7/9)*pixelCount);
                   %disp("set 7 pixels white")
               elseif(average > 204 && average <= 229.5)
                   numWhite = round((8/9)*pixelCount);
                   %disp("set 8 pixels white")
               else
                   numWhite = pixelCount;
                   %disp("set all pixels white")
               end
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