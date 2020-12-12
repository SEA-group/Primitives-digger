% This script can help adding a pair of vertex & index chunks (i.e. one renderSet) into a bunch of .primitives files
% ver.2020.12.12
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

chunkList{1}.name = 'Yamato_Propulsor';
chunkList{1}.wire = 0;
chunkList{1}.list32 = 0;

chunkList{2}.name = 'Yamato_TorpedoTube';
chunkList{2}.wire = 0;
chunkList{2}.list32 = 0;

chunkList{3}.name = 'Yamato_Lens_Blue';
chunkList{3}.wire = 0;
chunkList{3}.list32 = 1;

chunkList{4}.name = 'Yamato_Lens_Blue_alpha';
chunkList{4}.wire = 0;
chunkList{4}.list32 = 0;

chunkList{5}.name = 'Yamato_Lens_Red';
chunkList{5}.wire = 0;
chunkList{5}.list32 = 0;

chunkList{6}.name = 'Yamato_Lens_Red_alpha';
chunkList{6}.wire = 0;
chunkList{6}.list32 = 0;

chunkList{7}.name = 'Yamato_Mechanical1_A';
chunkList{7}.wire = 0;
chunkList{7}.list32 = 1;

chunkList{8}.name = 'Yamato_Mechanical1_B';
chunkList{8}.wire = 0;
chunkList{8}.list32 = 1;

chunkList{9}.name = 'Yamato_Mechanical1_C';
chunkList{9}.wire = 0;
chunkList{9}.list32 = 1;

chunkList{10}.name = 'Yamato_Mechanical1_D';
chunkList{10}.wire = 0;
chunkList{10}.list32 = 1;

% !!!Attention!!! 
% "wire" type vertex chunk cannot be added to skinned model 

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
    for indChunk = 1 : size(chunkList, 2)
        chunkName = chunkList{indChunk}.name;
        wire = chunkList{indChunk}.wire;
        list32 = chunkList{indChunk}.list32;
        if wire == 1
            if list32 == 1
                primCode = PrimitivesAppendWire32_Mk1(primCode, [chunkName, '_wire_32']);
            else
                primCode = PrimitivesAppendWire_Mk1(primCode, [chunkName, '_wire']);
            end
        else
            if list32 == 1
                primCode = PrimitivesAppend32_Mk1(primCode, [chunkName, '_32']);
            else
                primCode = PrimitivesAppend_Mk1(primCode, chunkName);
            end
        end
    end

    % Write to file
    newFile=fopen(fileName, 'w');
    fwrite(newFile, primCode);
    fclose(newFile);
    
end


%% Finish

% fclose all;
toc