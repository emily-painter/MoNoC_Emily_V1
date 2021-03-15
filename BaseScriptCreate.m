clc
clear
% % Create the Base of Congruent Image Presentation
% Version for NEST FOLDER
file_path_CongruentCropped = 'square_images\congruent cropped\';
file_path_InCongruentCropped = 'square_images\incongruent cropped\';
file_path_Congruent_Center = 'patches\cong_center\';
file_path_inCongruent_Center = 'patches\incong_center\';
file_path_Congruent_Periphery = 'patches\cong_periphery\';
file_path_inCongruent_Periphery = 'patches\incong_periphery\';

file_path_N = 'square_images\Nullselected\';
file_path_N_periphery = 'patches\null_periphery\';
file_path_N_center = 'patches\null_center\';

file_path_mask = 'square_images\mask\';
file_path_mask_Center = 'patches\mask_center\';
file_path_mask_Periphery = 'patches\mask_periphery\';


Total_Trial_number = 30; %% Define how many congruent images are used to presentation
Total_Trial_number_practice = 3; % was 3
Number_of_Masking = 20;
for subject = 1:1
    order_list_group = randperm(140,140); % Shuffle the order of the square image base
    for group = 1:5
        DesDir = sprintf('Subject_%d_Group_%d',subject,group);
        mkdir('WebVersion\',DesDir);
        DST_PATH_t = ['WebVersion\',DesDir];
        %%Allocate the square images in each group
        if group == 1 || group == 2 || group == 3 || group == 4
            order_list = order_list_group(1 + Total_Trial_number*(group-1):Total_Trial_number + Total_Trial_number*(group-1));
        else
            order_list = order_list_group(111:end);
        end
        order_list_Masking = randperm(140,Number_of_Masking);
        order_list_practice = randperm(140,Total_Trial_number_practice);
        filename = sprintf('BaseScript_B%d_G%d.iqx',subject,group);
        fid = fopen(filename,'w');%Open or create new file for writing. Discard existing contents, if any.
        NumberOfNpatch = 7044;
        
%% Create List of Images in Present Step 
%Need to mix the congruent and Incongruent images throughout the experiment
        fprintf(fid,'<item image_presentation>\n'); 
        PresentArray = string(ones(1,Total_Trial_number)); %Pre-create an array to represent the order of presentation image for INCONG and CONG
        if mod(Total_Trial_number,2) == 0
            ChooseINCONGorCONG = randerr(1,Total_Trial_number,Total_Trial_number/2)+1;
        elseif mod(Total_Trial_number,2) == 1
            ChooseINCONGorCONG = randerr(1,Total_Trial_number,(Total_Trial_number-1)/2)+1;
        end
        for presentation_number = 1:Total_Trial_number
            if ChooseINCONGorCONG(presentation_number) == 1
                PresentArray(presentation_number) = 'Cong';
                string_order = num2str(order_list(presentation_number).','%03d');
                address = sprintf('"%s%s.jpg"','SquareCongruent_',string_order);
                file_name = sprintf('%s%s%s.jpg',file_path_CongruentCropped,'SquareCongruent_',string_order); 
                fprintf(fid,'/%d = ',presentation_number);
                fprintf(fid,'%s\n',address);
                copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            elseif ChooseINCONGorCONG(presentation_number) == 2
                %Here to create part of Incongruent images
                PresentArray(presentation_number) = 'INcong';
                string_order = num2str(order_list(presentation_number).','%03d');
                address = sprintf('"%s%s.jpg"','SquareIncongruent_',string_order);
                file_name = sprintf('%s%s%s.jpg',file_path_InCongruentCropped,'SquareIncongruent_',string_order); 
                fprintf(fid,'/%d = ',presentation_number);
                fprintf(fid,'%s\n',address);
                copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
        end
        fprintf(fid,'</item>\n\n');
   
%% Create List of Presentation for Practice        
fprintf(fid,'<item image_presentation_practice>\n');
PresentArray_practice = string(ones(1,Total_Trial_number_practice));
if mod(Total_Trial_number_practice,2) == 0
    ChooseINCONGorCONG_practice = randerr(1,Total_Trial_number_practice,Total_Trial_number_practice/2)+1;
elseif mod(Total_Trial_number_practice,2) == 1
    ChooseINCONGorCONG_practice = randerr(1,Total_Trial_number_practice,(Total_Trial_number_practice-1)/2)+1;
end
for presentation_number = 1:Total_Trial_number_practice
    if ChooseINCONGorCONG_practice(presentation_number) == 1
        PresentArray_practice(presentation_number) = 'Cong';
        string_order = num2str(order_list_practice(presentation_number).','%03d');
        address = sprintf('"%s%s.jpg"','SquareCongruent_',string_order);
        file_name = sprintf('%s%s%s.jpg',file_path_CongruentCropped,'SquareCongruent_',string_order);
        fprintf(fid,'/%d = ',presentation_number);
        fprintf(fid,'%s\n',address);
        copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
    elseif ChooseINCONGorCONG_practice(presentation_number) == 2
        %Here to create part of Incongruent images
        PresentArray_practice(presentation_number) = 'INcong';
        string_order = num2str(order_list_practice(presentation_number).','%03d');
        address = sprintf('"%s%s.jpg"','SquareIncongruent_',string_order);
        file_name = sprintf('%s%s%s.jpg',file_path_InCongruentCropped,'SquareIncongruent_',string_order);
        fprintf(fid,'/%d = ',presentation_number);
        fprintf(fid,'%s\n',address);
        copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
    end
end
fprintf(fid,'</item>\n\n');

%% Create List of Masking and the masking for patches
           for Masking_group = 1:5
                string_title_number = num2str(Masking_group.','%01d');
                fprintf(fid,'<item Masking_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/5)
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/5)*(Masking_group-1)).','%03d');
                    fprintf(fid,'/%d = "mask_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smask_%s.jpg',file_path_mask,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end

            for Masking_group_periphery = 1:5%%%%%%%%%%%%%%%%%%%%%%%%%%%change to include small masking patches
                string_title_number = num2str(Masking_group_periphery.','%01d');
                fprintf(fid,'<item Masking_periphery_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/5)
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/5)*(Masking_group_periphery-1)).','%03d');
                    fprintf(fid,'/%d = "maskCrop_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smaskCrop_%s.jpg',file_path_mask_Periphery,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end
            
            for Masking_group_center = 1:5
                string_title_number = num2str(Masking_group_center.','%01d');
                fprintf(fid,'<item Masking_center_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/5)
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/5)*(Masking_group_center-1)).','%03d');
                    fprintf(fid,'/%d = "maskCropc_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smaskCropc_%s.jpg',file_path_mask_Center,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end

            

%% Create Picture Stimuli

%% Randomly selcet 3 patches from 9 positions in the original image, and the position keep the same location from the image

%% Create group of position 1
            fprintf(fid,'<picture Patch_locate_1_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location1.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
%% Create group of position 2
            fprintf(fid,'<picture Patch_locate_2_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location2.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
%% Create group of position 3
            %Create Group of Position 3
            fprintf(fid,'<picture Patch_locate_3_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location3.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 4
            fprintf(fid,'<picture Patch_locate_4_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location4.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
%% Create group of position 5
            fprintf(fid,'<picture Patch_locate_5_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location5.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 6
            fprintf(fid,'<picture Patch_locate_6_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location6.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 7
%Create Group of Position 7
            fprintf(fid,'<picture Patch_locate_7_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location7.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
        
%% Create group of position 8
            fprintf(fid,'<picture Patch_locate_8_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location8.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 9
%Create Group of Position 9
            fprintf(fid,'<picture Patch_locate_9_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location9.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 10
%Create Group of Position 10
            fprintf(fid,'<picture Patch_locate_10_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location10.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n'); 
            
            
%% Create group of position 11
%Create Group of Position 11
            fprintf(fid,'<picture Patch_locate_11_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location11.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 12
%Create Group of Position 12
            fprintf(fid,'<picture Patch_locate_12_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location12.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
%% Create Absent patch stimuli step
% Randomly select from the base, but it needs to be in the same location from
% that image.
            folder = 'square_images/Nullselected';
            filepattern = fullfile(folder,'*.jpg');
            theFiles = dir(filepattern);
            filenames = {theFiles.name};
            filenames = extractBefore(filenames,'.jpg');
            Total_num_N = length(filenames);
            num_N_patch = Total_Trial_number;%number of patches presented in each location in each trial

 %% Create group of position 1
            fprintf(fid,'<picture nPatch_locate_1_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            temp1 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename1 = string(filenames(temp1(n_patch_list)));
                    fprintf(fid,'"%s_1.jpg",\n',filename1);
                    file_name = sprintf('%s%s_1.jpg',file_path_N_periphery,filename1);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 2
            fprintf(fid,'<picture nPatch_locate_2_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_2,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            temp2 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename2 = string(filenames(temp2(n_patch_list)));
                    fprintf(fid,'"%s_2.jpg",\n',filename2);
                    file_name = sprintf('%s%s_2.jpg',file_path_N_periphery,filename2);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');

            
 %% Create group of position 3
            fprintf(fid,'<picture nPatch_locate_3_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            temp3 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename3 = string(filenames(temp3(n_patch_list)));
                    fprintf(fid,'"%s_3.jpg",\n',filename3);
                    file_name = sprintf('%s%s_3.jpg',file_path_N_periphery,filename3);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');

 %% Create group of position 4
            fprintf(fid,'<picture nPatch_locate_4_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_2)\n');
            fprintf(fid,'  /items = (');
            temp4 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename4 = string(filenames(temp4(n_patch_list)));
                    fprintf(fid,'"%s_4.jpg",\n',filename4);
                    file_name = sprintf('%s%s_4.jpg',file_path_N_periphery,filename4);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 5
            fprintf(fid,'<picture nPatch_locate_5_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_2)\n');
            fprintf(fid,'  /items = (');
            temp5 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename5 = string(filenames(temp5(n_patch_list)));
                    fprintf(fid,'"%s_5.jpg",\n',filename5);
                    file_name = sprintf('%s%s_5.jpg',file_path_N_periphery,filename5);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');


 %% Create group of position 6
            fprintf(fid,'<picture nPatch_locate_6_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            temp6 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename6 = string(filenames(temp6(n_patch_list)));
                    fprintf(fid,'"%s_6.jpg",\n',filename6);
                    file_name = sprintf('%s%s_6.jpg',file_path_N_periphery,filename6);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');



 %% Create group of position 7
            fprintf(fid,'<picture nPatch_locate_7_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_2,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            temp7 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename7 = string(filenames(temp7(n_patch_list)));
                    fprintf(fid,'"%s_7.jpg",\n',filename7);
                    file_name = sprintf('%s%s_7.jpg',file_path_N_periphery,filename7);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');



 %% Create group of position 8
            fprintf(fid,'<picture nPatch_locate_8_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            temp8 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename8 = string(filenames(temp8(n_patch_list)));
                    fprintf(fid,'"%s_8.jpg",\n',filename8);
                    file_name = sprintf('%s%s_8.jpg',file_path_N_periphery,filename8);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');



 %% Create group of position 9
            fprintf(fid,'<picture nPatch_locate_9_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/6,values.present_image_size/6)\n');
            fprintf(fid,'  / position = (values.location_horizontal_4,values.location_vertical_4)\n');
            fprintf(fid,'  /items = (');
            temp9 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename9 = string(filenames(temp9(n_patch_list)));
                    fprintf(fid,'"%s_9.jpg",\n',filename9);
                    file_name = sprintf('%s%s_9.jpg',file_path_N_center,filename9);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');


%% Create group of position 10
fprintf(fid,'<picture nPatch_locate_10_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/6,values.present_image_size/6)\n');
            fprintf(fid,'  / position = (values.location_horizontal_5,values.location_vertical_4)\n');
            fprintf(fid,'  /items = (');
            temp10 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename10 = string(filenames(temp10(n_patch_list)));
                    fprintf(fid,'"%s_10.jpg",\n',filename10);
                    file_name = sprintf('%s%s_10.jpg',file_path_N_center,filename10);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');


%% Create Group of position 11
            fprintf(fid,'<picture nPatch_locate_11_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/6,values.present_image_size/6)\n');
            fprintf(fid,'  / position = (values.location_horizontal_4,values.location_vertical_5)\n');
            fprintf(fid,'  /items = (');
            temp11 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename11 = string(filenames(temp11(n_patch_list)));
                    fprintf(fid,'"%s_11.jpg",\n',filename11);
                    file_name = sprintf('%s%s_11.jpg',file_path_N_center,filename11);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');


%% Create Group of position 12
            fprintf(fid,'<picture nPatch_locate_12_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/6,values.present_image_size/6)\n');
            fprintf(fid,'  / position = (values.location_horizontal_5,values.location_vertical_5)\n');
            fprintf(fid,'  /items = (');
            temp12 = randperm(Total_num_N,num_N_patch);
            for n_patch_list = 1:num_N_patch
                    filename12 = string(filenames(temp12(n_patch_list)));
                    fprintf(fid,'"%s_12.jpg",\n',filename12);
                    file_name = sprintf('%s%s_12.jpg',file_path_N_center,filename12);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
           
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');


            %% List to define whether the images are Cong or Incong
            fprintf(fid,'<item CongOrIncong>\n');
            for presentation_order = 1:length(order_list)
                if PresentArray(presentation_order) == "Cong"
                    fprintf(fid,'/%d = "Cong" \n',presentation_order);
                elseif PresentArray(presentation_order) == "INcong"
                    fprintf(fid,'/%d = "Incong" \n',presentation_order);
                end
            end
            fprintf(fid,'</item>\n\n');
            
             %% List to define whether the images in practice trials are Cong or Incong
            fprintf(fid,'<item CongOrIncong_practice>\n');
            for presentation_order_practice = 1:length(order_list_practice)
                if PresentArray_practice(presentation_order_practice) == "Cong"
                    fprintf(fid,'/%d = "Cong" \n',presentation_order_practice);
                elseif PresentArray_practice(presentation_order_practice) == "INcong"
                    fprintf(fid,'/%d = "Incong" \n',presentation_order_practice);
                end
            end
            fprintf(fid,'</item>\n\n');

%% List of Image ID
            fprintf(fid,'<item Image_ID>\n');
            for presentation_order = 1:length(order_list)
                fprintf(fid,'/%d = "%d"\n',presentation_order,order_list(presentation_order));
            end
            fprintf(fid,'</item>\n\n');

%% List of Image ID in practice trials
            fprintf(fid,'<item Image_ID_practice>\n');
            for presentation_order_practice = 1:length(order_list_practice)
                fprintf(fid,'/%d = "%d"\n',presentation_order_practice,order_list_practice(presentation_order_practice));
            end
            fprintf(fid,'</item>\n\n');
%             fprintf(fid,'<page intro>\n');
%             fprintf(fid,'^^Welcome to our experiment!\n');
%             fprintf(fid,'</page>\n');
% 
%             fprintf(fid,'<page end>\n');
%             fprintf(fid,'^^This is the end of the experiment !\n');
%             fprintf(fid,'^^Thank you for your coorperation !\n');
%             fprintf(fid,'</page>\n');


%             fprintf(fid,'<expt Throughout>\n');
%             fprintf(fid,'/ preinstructions = (intro)\n');
%             fprintf(fid,'/ postinstructions = (end)\n');
%             fprintf(fid,'/ blocks = [');
%             fprintf(fid,']\n');
%             fprintf(fid,'</expt>\n\n');
%             fclose(fid);
 
            
     end
end 
















