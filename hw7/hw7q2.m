in01 = load('IMG_7401.mat');
in05 = load('IMG_7405.mat');
orig01 = in01.I;
orig05 = in05.I;

%Make a call to my ProcessPlusPrint function to deconstruct and reconstruct
%my images and save the outputs for the different coefficient percentages.
[a, b, c, d, e] = ProcessPlusPrint(orig01);
[f, g, h, i, j] = ProcessPlusPrint(orig05);

%Make a call to my local RMSE function and store the values.
RMSEa = RMSE(orig01, a);
RMSEb = RMSE(orig01, b);
RMSEc = RMSE(orig01, c);
RMSEd = RMSE(orig01, d);
RMSEe = RMSE(orig01, e);
RMSEf = RMSE(orig05, f);
RMSEg = RMSE(orig05, g);
RMSEh = RMSE(orig05, h);
RMSEi = RMSE(orig05, i);
RMSEj = RMSE(orig05, j);

%Print out the RMSE values
disp(RMSEa);
disp(RMSEb);
disp(RMSEc);
disp(RMSEd);
disp(RMSEe);
disp(RMSEf);
disp(RMSEg);
disp(RMSEh);
disp(RMSEi);
disp(RMSEj);

%Show each of the images, with all 5 coefficients of the first image first,
%then the 5 coefficients of the second image.
figure
imshow(a);
figure
imshow(b);
figure
imshow(c);
figure
imshow(d);
figure
imshow(e);
figure
imshow(f);
figure
imshow(g);
figure
imshow(h);
figure
imshow(i);
figure
imshow(j);

%This function calculates the RMSE values the same way as the given
%equation.
function X = RMSE(original, reconstruct)
    [M, N] = size(original);
    sum = 0;
    
    for m=1:M
        for n=1:N
            sum = sum + (double(original(m,n)) - double(reconstruct(m,n)))^2;
        end
    end
    X = sqrt(sum/(M*N));
end

function [A, B, C, D, E] = ProcessPlusPrint(orig)
    %Initialization section of the function that calculates dft and
    %initializes matrices.
    dft = fft2(orig);
    dftABS = abs(dft);
    [M,N] = size(dftABS);
    percentValues = zeros(5);
    
    %This block calls the local function that finds the coefficient cutoff
    %values.
    percentValues(1) = minmax(dftABS, .5);
    percentValues(2) = minmax(dftABS, .2);
    percentValues(3) = minmax(dftABS, .1);
    percentValues(4) = minmax(dftABS, .05);
    percentValues(5) = minmax(dftABS, .01);

    %Outer for loop makes the process run for the different percentage
    %values we need to find
    for z=1:5
       percentValue = percentValues(z);
       newDFT = dftABS;
       %The inner for loops check the dft to see if the current element is
       %above the cutoff for the given percentage
       for m=1:M
           for n=1:N
               if(dftABS(m,n)<percentValue)
                   newDFT(m,n) = 0;
               else
                   newDFT(m,n) = dft(m,n);
               end
           end
       end
       %Reconstruct the image using the limited dft coefficients.
       recon = uint8(real(ifft2(newDFT)));
       if(z==1)
           A = recon;
       elseif(z==2)
           B = recon; 
       elseif(z==3)
           C = recon;
       elseif(z==4)
           D = recon;
       else
           E = recon;
       end
    end
end

%This function finds the cutoff element to determine which coefficients we
%should keep.
function J=minmax(orig, percent)
arr = reshape(orig, 1, []);
sortArr = sort(arr);
[~, length] = size(sortArr);
mm = length*(1-percent);
J=sortArr(uint32(round(mm)));
end
