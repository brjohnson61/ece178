function J = floydSteinberg(image)
    [rows, columns, colorChannels] = size(image);
    imageBin = binary(image);
    for i=1:rows
        for j=1:columns
            error = image(i,j) - imageBin(i,j);
            if(i <= rows && j+1 <= columns)
                image(i,j+1) = image(i,j+1) + 7*error/16;
            end
            if(i+1 <= rows && j-1 >= 1)
                image(i+1,j-1) = image(i+1,j-1) + 3*error/16;
            end
            if(i+1 <= rows && j <= columns)
                image(i+1,j) = image(i+1,j) + 5*error/16;
            end
            if(i+1 <= rows && j+1 <= rows)
                image(i+1,j+1) = image(i+1,j+1) + error/16;
            end
        end
    end
    J = image;
end