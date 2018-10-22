
image = imread("image1.jpg");
imageBin = binary(image);
newImage = floydSteinberg(image);

figure, imshow(image);
figure, imshow(imageBin);
figure, imshow(newImage);

