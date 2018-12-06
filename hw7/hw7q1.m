%Load in the matlab images so that they are accessible to the workspace
in01 = load('IMG_7401.mat');
in05 = load('IMG_7405.mat');
orig01 = in01.I;
orig05 = in05.I;

%Show the original images
figure
imshow(orig01);
figure
imshow(orig05);

%Take the 2d DFT of the original images
dft01 = fft2(orig01);
dft05 = fft2(orig05);

%Take the real component of the inverse DFT of the DFT of the original
%images.
recon01 = uint8(real(ifft2(dft01)));
recon05 = uint8(real(ifft2(dft05)));

%Show the reconstructed images from the inverse DFT.
figure
imshow(recon01);
figure
imshow(recon05);
