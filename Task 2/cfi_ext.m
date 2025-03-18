function sSharp = cfi_ext(s)
    % This function sharpens an image by applying an unsharp mask. 
    % It works by blurring the image with a Gaussian kernel, subtracting the blurred image from the original to obtain the detail mask, and then adding a fraction of this mask back to the original image.
    % The function takes a struct s as input, which must contain the fields imageData and fileNameData.
    % The function returns a struct sSharp, which contains the sharpened image.
    % sSharp = cfi_ext(s)

    if ~isstruct(s) || ~isfield(s, 'imageData') || ~isfield(s, 'fileNameData')
        error('Input must be a struct with fields imageData and fileNameData');
    end

    % Check if the image data is in the correct format
    image = s.imageData;
    if max(image(:)) > 1
        image = im2double(image);
    else
        image = double(image);
    end

    % Gaussian kernel for blurring
    gaussianKernel = [1,  4,  6,  4, 1;
                      4, 16, 24, 16, 4;
                      6, 24, 36, 24, 6;
                      4, 16, 24, 16, 4;
                      1,  4,  6,  4, 1] / 256;

    if size(image, 3) == 3
        % Separate the RGB channels
        r = image(:,:,1);
        g = image(:,:,2);
        b = image(:,:,3);

        % Apply the unsharp mask to each channel
        rBlur = conv2(r, gaussianKernel, 'same');
        gBlur = conv2(g, gaussianKernel, 'same');
        bBlur = conv2(b, gaussianKernel, 'same');

        % Calculate the detail mask
        rMask = r - rBlur;
        gMask = g - gBlur;
        bMask = b - bBlur;

        % Adjust the strength of the sharpening effect
        amount = 1 

        % Add a fraction of the detail mask back to the original image
        rSharp = r + rMask * amount;
        gSharp = g + gMask * amount;
        bSharp = b + bMask * amount;

        % Combine the sharpened channels
        imageSharp = cat(3, rSharp, gSharp, bSharp);
    else
        % Apply the unsharp mask to the grayscale image
        imageBlur = conv2(image, gaussianKernel, 'same');
        imageMask = image - imageBlur;
        imageSharp = image + imageMask;
    end

    % Clip the values to the range [0, 1]
    imageSharp = max(min(imageSharp, 1), 0);

    % Create a new struct for the sharpened image
    sSharp = struct();
    sSharp.imageData = imageSharp;
    sSharp.fileNameData = s.fileNameData;
end