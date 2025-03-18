function s = cfi_load(filename)
    % This function loads an image file from disk and returns a struct containing the image data and filename.
    % The function takes a string filename as input and returns a struct s with fields imageData and fileNameData.
    % s = cfi_load(filename)

    % Check if the input argument is provided
    if nargin < 1
        error('Usage: cfa_load(filename). Please provide a filename.');
    end

    % Check if the input argument is a string
    if ~ischar(filename)
        error('Input must be a string');
    end
    % Check if the file exists
    if ~exist(filename, 'file')
        error('File does not exist');
    end
    % Check if the file is an image
    if ~strcmp(filename(end-3:end), '.png') && ~strcmp(filename(end-3:end), '.jpg')
        error('File is in invalid format');
    end

    % Load the image file
    image = imread(filename);

    % Create a struct to store the image data and filename
    s = struct();
    s.imageData = image;
    s.fileNameData = filename;

    disp('File loaded successfully');
end