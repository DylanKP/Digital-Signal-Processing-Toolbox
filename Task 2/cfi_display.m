function cfi_display(s, domain)
    % This function displays the input image in the specified domain.
    % It works by showing the image in the spatial domain or frequency domain based on the input argument.
    % The function takes a struct s as input, which must contain the fields imageData and fileNameData.
    % The function also takes an optional argument domain, which specifies the domain to display the image in ('s' for spatial domain, 'f' for frequency domain).
    % If domain is not provided, the default is 's' for spatial domain.
    % cfi_display(s, domain)

    % Check if the input is a struct
    if ~isstruct(s) || ~isfield(s, 'imageData') || ~isfield(s, 'fileNameData')
        error('Input must be a struct with fields imageData and fileNameData');
    end
    % Check if the domain argument is provided
    if nargin < 2 || isempty(domain)
        domain = 's';
    end

    image = s.imageData;


    if domain ==  'f'
        % Convert the image to grayscale if necessary
        image = double(image);
        if size(image, 3) == 3
            img_gray = 0.2989 * image(:,:,1) + 0.5870 * image(:,:,2) + 0.1140 * image(:,:,3);
        else
            img_gray = image;
        end

        % Compute the Fourier transform of the image
        f = fft2(img_gray);
        fShifted = fftshift(f);
        % Compute the magnitude of the Fourier transform
        magnitude = log(abs(fShifted) + 1);

        % Display the frequency domain image
        figure;
        imagesc(magnitude);
        colormap('gray');
        title('Frequency Domain');
        colorbar;

        disp('Frequency Domain Image displayed');
    else
        % Display the spatial domain image
        figure;
        imshow(image);
        title('Spatial Domain');

        disp('Spatial Domain Image displayed');
    end
end