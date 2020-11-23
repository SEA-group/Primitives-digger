% This script can help adding a pair of vertex & index chunks (i.e. one renderSet) into a bunch of .primitives files
% ver.2020.11.23
% requirement:
% - PrimitivesAppend_Mk1.m
% - PrimitivesAppend32_Mk1.m
% - PrimitivesAppendWire_Mk1.m
% - PrimitivesAppendWire32_Mk1.m
% - AntiNormalConvertor_Mk1.m
% by AstreTunes@SEA-group

tic
clc
clear
close all;

%% Parameters

fileNames = dir('Queue/*.primitives');
chunkName = 'new_chunk';

% !!!Attention!!! 
% "wire" type vertex chunk cannot be added to skinned model 
wire = 0;
list32 = 1;

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
    if wire == 1
        if list32 == 1
            primCodeKai = PrimitivesAppendWire32_Mk1(primCode, chunkName);
        else
            primCodeKai = PrimitivesAppendWire_Mk1(primCode, chunkName);
        end
    else
        if list32 == 1
            primCodeKai = PrimitivesAppend32_Mk1(primCode, chunkName);
        else
            primCodeKai = PrimitivesAppend_Mk1(primCode, chunkName);
        end
    end

    % Write to file
    newFile=fopen(fileName, 'w');
    fwrite(newFile, primCodeKai);
    fclose(newFile);
    
end


%% Finish

% fclose all;
toc