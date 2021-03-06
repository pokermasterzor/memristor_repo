global isOctave; % can use this in scripts
isOctave = exist('OCTAVE_VERSION') ~= 0;
if 1 == isOctave
        warning('off','Octave:shadowed-function'); % otherwise it complains on startup about strsplit etc being shadowed
end
basedir='C:\Users\poker\Documents\Projects\Research\MAPP-2017-02-15-release-936fe19c63bf22cd50399c5cba1de4f0c2a339fa'; 
global MAPPbasedir;
MAPPbasedir=basedir;
currentwd = pwd();
cd(basedir);
more off; % changed by JR 2013/09/26 more on;

fprintf(2,'--------------------------------------------------------------------------------\n');
fprintf(2,'This is the Berkeley Model and Algorithm Prototyping Platform (MAPP).\n');
fprintf(2,'- git branch 2017-02-15-github-release-GITHUB-branch\n');
fprintf(2,'- git version MAPP-2017-02-15-release-936fe19c63bf22cd50399c5cba1de4f0c2a339fa\n');
fprintf(2,'- installed under:\n');
fprintf(2,'  %s.\n\n', basedir);
setuppaths_MAPP; % needs basedir
cd(currentwd);
fprintf(2,'MAPP paths have been set up.\n');
fprintf(2,'--------------------------------------------------------------------------------\n\n');
fprintf(2,'type "help MAPP" (without the quotes) to start.\n\n');

% working around some Octave quirks
if 1 == isOctave
        tks = available_graphics_toolkits();
        if sum(strcmp(tks, 'qt')) > 0
            graphics_toolkit('qt');
            warning('qt graphics toolkit being used. If there are rendering problems, try graphics_toolkit(''gnuplot'').');
        elseif sum(strcmp(tks, 'fltk')) > 0
            graphics_toolkit('fltk')
            warning('fltk graphics toolkit being used. If there are rendering problems, try graphics_toolkit(''gnuplot'').');
        elseif sum(strcmp(tks, 'gnuplot')) > 0
            graphics_toolkit('gnuplot');
        else
            warning('The qt, fltk and gnuplot graphics toolkits seem unavailable in your Octave installation. You may have problems with graphics. help graphics_toolkit for more information.');
        end

        warning ('off','Octave:possible-matlab-short-circuit-operator');
        warning ('off','Octave:deprecated-function'); 
        warning('off','Octave:function-name-clash');
        warning('off','Octave:matlab-incompatible');
        warning('off','Octave:load-file-in-path'); % doesn't work in 4.0.2
        warning('off','Octave:divide-by-zero'); % otherwise legend spits out lots of these warnings
        page_output_immediately(1);
        do_braindead_shortcircuit_evaluation(1);
end

if 1 == isOctave
        clear -f; % clears functions. If we don't do this,
                % running this script again results in a strange
                % error in vecvalder.times
end


% test that CWD is writable; issue warning if not
% (nice way to do it, adapted from
%   www.mathworks.com/matlabcentral/fileexchange/9322-iswrite/content/iswrite.m)
testDir = ['deleteMe_', num2str(floor(rand*1e12))]; 

% test for write permissions by creating a folder and then deleting it
[isWritable,message,messageid] = mkdir('.', testDir);
% check if directory creation was successful
if isWritable == 1
    % we have permission to write so delete the created test directory
    [status,message,messageid] = rmdir(testDir);
    if status ~= 1
        disp(['Warning: Test folder "', testDir, '" could not be deleted']);
    end
else
    fprintf(2, '\nWARNING: your current working directory seems not to be writable.\n');
    fprintf(2, 'Because of this, certain features of MAPP (eg, MAPPtest) will not work.\n');
    fprintf(2, 'It is best to start MATLAB/MAPP in a directory/folder where you have\nwrite permission.\n\n');
end

if 0 == isOctave
    if verLessThan('matlab', '7.10.0.499')
        fprintf(2, '\nWARNING: your MATLAB version (%s) is old - MAPP may not work.\n', version());
        fprintf(2, 'MAPP has been tested on MATLAB 7.10.0.499 (R2010a)\n and later versions.\n\n');
    end
end
