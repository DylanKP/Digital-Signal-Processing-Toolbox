function m = cfi_segment(s)
    % This function segments the input image based on a simple thresholding.
    % It works by converting the image to grayscale, calculating the mean intensity value, and then thresholding the image based on this value.
    % The function takes a struct s as input, which must contain the fields imageData and fileNameData.
    % The function returns a binary mask m, where the segmented regions are set to 1 and the background is set to 0.
    % m = cfi_segment(s)

    % Check if the input is a struct with the required fields
    if ~isstruct(s) || ~isfield(s, 'imageData') || ~isfield(s, 'fileNameData')
        error('Input must be a struct with fields imageData and fileNameData');
    end

    image = s.imageData;
    if size(image, 3) == 3
        % Convert the image to grayscale
        imageGray = 0.2989 * double(image(:,:,1)) + 0.5870 * double(image(:,:,2)) + 0.1140 * double(image(:,:,3));
    else
        % If the image is already grayscale
        imageGray = image;
    end

    % Normalize the image if necessary
    if max(imageGray(:)) > 1
        imageGray = imageGray / 255;
    end

    % Calculate the threshold based on the mean intensity value
    threshold = mean(imageGray(:));

    % Segment the image based on the threshold
    m = imageGray > threshold;
end