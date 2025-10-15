%% directory where the seg8mat files are stored
segDir = '/scratch/j90161ms';
outFile = fullfile(segDir, 'TCV_all.csv');  %this will produce a .csv file with the combined TCVs at the end 

% Find all TCV files - each participant currently has their own .txt file with their TCV
tcv_files = dir(fullfile(segDir, 'TCV_avg_*seg8.txt'));

all_data = [];
all_names = {};

for i = 1:numel(tcv_files)
    fname = fullfile(segDir, tcv_files(i).name);
    try
       	vals = readmatrix(fname, 'FileType', 'text');
        all_data = [all_data; vals(:)'];
        all_names{end+1,1} = erase(tcv_files(i).name, {'TCV_', '.txt'});
    catch
	warning('Could not read %s', fname);
    end
end

% Write combined output
T = array2table(all_data, 'VariableNames', {'GM', 'WM', 'CSF', 'ICV'}); % adjust column names if needed
T.Subject = all_names;
T = movevars(T, 'Subject', 'Before', 1);
writetable(T, outFile);
disp(['✅ Combined file saved: ' outFile]);

