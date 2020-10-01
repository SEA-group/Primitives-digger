% This script can help adding a pair of vertex & index chunks (i.e. one renderSet) into a bunch of .primitives files
% ver.2020.10.01
% requirement:
% - PrimitivesAppend_Mk1.m
% - AntiNormalConvertor_Mk1.m
% by AstreTunes@SEA-group

tic
clc
clear
close all;

%% Parameters

fileNames = dir('Queue/*.primitives');
chunkName = 'new_chunk';

%% Processing

for indFileInFolder = 1: size(fileNames, 1)
    
    fileName = ['Queue/', fileNames(indFileInFolder).name];
    
    % Create backup and load primitives content
    backupFileName = [fileName, 'bak'];
    movefile(fileName, backupFileName);
    originalFile=fopen(backupFileName, 'r');
    primCode=fread(originalFile);
    fclose(originalFile);
    clear originalFile;

    % Generate new primitives content
    primCodeKai = PrimitivesAppend_Mk1(primCode, chunkName);

    % Write to file
    newFile=fopen(fileName, 'w');
    fwrite(newFile, primCodeKai);
    fclose(newFile);
    
end


%% Finish

% fclose all;
toc