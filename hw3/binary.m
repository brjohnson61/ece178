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