%% Question 1
F=imread('hw4_im1.tif');
h = fspecial('average',31);
h_normalized=h/numel(h);
subplot(1,3,1),imshow(F),title('original image')
I=imfilter(F,h,'replicate'); 
subplot(1,3,2),imshow(I),title('filtered image with  unnormalized window')
I_normalized = imfilter(F,h_normalized,'replicate'); 
subplot(1,3,3),imshow(I_normalized),title('filtered image with normalized window')
% as we see in the figure after normalization, the image turns black
% because the idea behind averaging filter is for any pixel in the image,
% take an average across its neighborhood so by normalization(dividing each pixel intensity but the number of pixels in the image)
%each pixel turns to zero_ish so that's why the image turns black.

%% Question 2
   f=imread('hw4_im2.tif');
   imshow(f)
   h = fspecial('gaussian',11,1.5);
   f_gaussian=imfilter(f,h,'replicate');
   figure,subplot(1,3,1),imshow(f_gaussian),title('gaussian filter')
   % gaussian filter is an image smoother which reduce image noises and 
   %blurs edges and reduces contrast
   h2 = fspecial('disk',5);
   f_disk=imfilter(f,h2,'replicate');
   subplot(1,3,2),imshow(f_disk),title('disk filter')
   %disk filter:returns a circular averaging filter. blurs the image , and
   %reduces the contrast 
   h3 = fspecial('average',11);
   f_average=imfilter(f,h3,'replicate');
   subplot(1,3,3),imshow(f_average),title('average filter')
   % average filter:reducing noise in an image but we will lose sharp
   % details.it's used for extraction of large and bightest objects and  
   % also it reduces the image contrast
   
   %these tree filters are used to smooth the image but average smooth more
   %and also average filter blurs the image more . by comparing their
   %contrast we'll figure out that all of them reduce the contrast of the
   %image but gaussian_image has a wider contrast compared to disk and
   %averaged image that why the gaussian image has a better visual
   %appearance
   %we apply these filters to the image to smooth the image and reduce the
   %noises
   

%% Question 3
   f=imread('hw4_im3.tif');
% part a :
  h = fspecial('sobel');
  f_horz=imfilter(f,h,'replicate');
  subplot(2,2,1),imshow(f_horz),title('horizontal sober')
  
%part b
  h2=h';
  f_vert=imfilter(f,h2,'replicate');
  subplot(2,2,2),imshow(f_vert),title('vertical sober')
 %part c
 f_sum=imadd(f_horz,f_vert);
 subplot(2,2,3),imshow(f_sum),title('horizontal+vertical sober')
 % part d
 h3 = fspecial('laplacian');
 f_lap=imfilter(f,h3,'replicate');
 subplot(2,2,4),imshow(f_lap),title('Laplacian')
 %because the laplacian is the 2nd order derivative operator it has a
 %narrower([0-151]) contrast range and sobel is a 1st order derivative operators has
 %wider range ([o-255]) so that's why sobel image has a brighter gray-scale
 %including white but laplacian image doesn't. 
%% Question 4
    I= imread('hw4_im4.tif');
    I = im2double(I);
    Gaussian = fspecial('gaussian',7,2);
    I_G = imfilter(I,Gaussian);
    figure,subplot(2,2,1),imshow(I),title('Original Image');
    subplot(2,2,2),imshow(I_G),title('Image Affected by Gaussian Filter');
    G_Mask = I-I_G;
    G1 = I+G_Mask;
    G2 = I+2*G_Mask;
    subplot(2,2,3),imshow(G1),title('Image Affected by Unsharp Masking');
    subplot(2,2,4),imshow(G2),title('Image Affected by High Boost Filtering');
    %Gaussian makes the image blurry but unsharp makes it less blurry
    %I_G has only positive intensity but unsharp and high boost mask has
    %negetive values also. and high boost image has a wider contrast than
    %unsharp one that's why it has a better appearance
    
%% question 5
I = imread('hw4_im5.tif');
    I = im2double(I);
    I_Filter = double(imread('hw4_mask5.tif'));

    figure,subplot(3,2,1),imshow(I,[]),title('Original Image'),...
    subplot(3,2,2),imshow(I_Filter),title('Mask Filter');
    R = xcorr2(I,I_Filter);

    R=mat2gray(R);
    Imb=double(im2bw(R,0.7));

    subplot(3,2,3),imshow(R,[]),title('Correlation Output');
    subplot(3,2,4),imshow(Imb),title('Correlation Threshold Output');
    
    Imb=imcrop(Imb,[84,54,990,642]);
    subplot(3,2,5),imshow(Imb),title('Correlation Threshold Output Cropped');

     I_F = imfuse(I,Imb);
    subplot(3,2,6),imshow(I_F),...
    title('Overlay of Original & Correlation Threshold Output');