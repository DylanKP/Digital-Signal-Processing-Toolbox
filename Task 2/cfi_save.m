function cfi_save(filename, s)
    % This function saves the input image data to a file with the specified filename.
    % The function takes a string filename and a struct s as input.
    % The struct s must contain the fields imageData and fileNameData.
    % The function saves the image data to the specified file in PNG or JPG format.
    % cfi_save(filename, s)

    % Check if the input arguments are valid
    if ~ischar(filename)
        error('Input must be a string');
    end
    if ~isstruct(s) || ~isfield(s, 'imageData') || ~isfield(s, 'fileNameData')
        error('Input must be a valid struct');
    end

    % Check if the file already exists
    if exist(filename, 'file')
        warning('File already exists. Overwriting...');
    end

    % Save the image data to the specified file
    if strcmp(filename(end-3:end), '.png') || strcmp(filename(end-3:end), '.jpg')
        imwrite(s.imageData, filename);
        disp('File saved successfully');
    else
        % Display an error message if the file format is invalid
        error('File is in invalid format');
    end
end