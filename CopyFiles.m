   clc
clear
fileFolder=fullfile('response');%????plane
dirOutput=dir(fullfile(fileFolder,'*'));%??????????????*?????????????????'.'???????????.jpg?
fileNames={dirOutput.name}';
for subject = 1:1
    for group = 1:5
        DesDir = sprintf('Subject_%d_Group_%d',subject,group);
        %     mkdir('WebVersion\',DesDir);
        %     Copy Commom Scripts
        DST_PATH_t = ['WebVersion\',DesDir];%??????
        file_1 = 'GIFSource\FixAndPresent.gif';
        file_2 = 'GIFSource\patchPresentation.gif';
        file_3 = 'GIFSource\responsePage.jpg';
        file_4 = 'GIFSource\seriesPatch.gif';
        file_5 = 'CommonFile\monash-logo-mono.png';
        file_6 = 'CommonFile\consent_form.html';
        file_7 = 'GIFSource\CalibrationInstruction.gif';
        
        location1 = 'grey_masks\location1.png';
        location2 = 'grey_masks\location2.png';
        location3 = 'grey_masks\location3.png';
        location4 = 'grey_masks\location4.png';
        location5 = 'grey_masks\location5.png';
        location6 = 'grey_masks\location6.png';
        location7 = 'grey_masks\location7.png';
        location8 = 'grey_masks\location8.png';
        location9 = 'grey_masks\location9.png';
        location10 = 'grey_masks\location10.png';
        location11 = 'grey_masks\location11.png';
        location12 = 'grey_masks\location12.png';
        
        CalibrationLine = 'CommonFile\CalibrationLine.png';
        CalibrationPage4 = 'CommonFile\CalibrationPage4.png';
        CalibrationPage5 = 'CommonFile\CalibrationPage5.png';
        CalibrationPage6 = 'CommonFile\CalibrationPage6.png';
        copyfile(file_1,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
        copyfile(file_2,DST_PATH_t);
        copyfile(file_3,DST_PATH_t);
        copyfile(file_4,DST_PATH_t);
        copyfile(file_5,DST_PATH_t);
        copyfile(file_6,DST_PATH_t);
        copyfile(file_7,DST_PATH_t);
        
        copyfile(location1,DST_PATH_t);
        copyfile(location2,DST_PATH_t);
        copyfile(location3,DST_PATH_t);
        copyfile(location4,DST_PATH_t);
        copyfile(location5,DST_PATH_t);
        copyfile(location6,DST_PATH_t);
        copyfile(location7,DST_PATH_t);
        copyfile(location8,DST_PATH_t);
        copyfile(location9,DST_PATH_t);
        copyfile(location10,DST_PATH_t);
        copyfile(location11,DST_PATH_t);
        copyfile(location12,DST_PATH_t);
        
        
        
        copyfile(CalibrationLine,DST_PATH_t);
        copyfile(CalibrationPage4,DST_PATH_t);
        copyfile(CalibrationPage5,DST_PATH_t);
        copyfile(CalibrationPage6,DST_PATH_t);
        
    file_name = 'Calibration.iqx';
    copyfile(file_name,DST_PATH_t);    
    file_name = 'Instruction.iqx';
    copyfile(file_name,DST_PATH_t);
    file_name = 'MainStructure_V2.iqx';
    copyfile(file_name,DST_PATH_t);
    file_name = 'PictureAndText_V2.iqx';
    copyfile(file_name,DST_PATH_t);
    file_name = sprintf('BaseScript_B%d_G%d.iqx',subject,group);
    copyfile(file_name,DST_PATH_t);
    file_name = sprintf('Script_B%d_G%d.iqx',subject,group);
    copyfile(file_name,DST_PATH_t);
    file_name = 'PracticeTrial.iqx';
    copyfile(file_name,DST_PATH_t);
    
        for i = 3:length(fileNames)
            temp = string(fileNames(i));
            file_name = sprintf('response/%s',temp);
            copyfile(file_name,DST_PATH_t);
        end
        
        
    end
end













