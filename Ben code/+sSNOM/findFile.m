function [filename] = findFile(searchString)
% [filename] = findFile(searchString)
% Searches the current directory for the first file containing the string
% "searchString," and returns the full "filename."

files = dir(strcat('*', searchString, '*'));

if isempty(files)
    return
else
    filename = files(1).name;
end

end