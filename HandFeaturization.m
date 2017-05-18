% Featurization of RAW EMG data

clear all; close all; clc;

%% Section 1: read in data, slice into 150 ms cube
dt = 1/1200;
time = 0:dt:3;
n = int16(.150/dt); %row length of 150 ms sample
cut = int16(.512/dt);
activity = 'crouch_';

%data_out = zeros(n,16,16*9);
ind2 = 1;
for k = 1:9
    num = strcat('00',num2str(k));
    trialname = strcat(activity,num);
    %trialname = strcat('BP_C_002_',activity,num);

    data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,15);
    %data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,15);

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);

    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
    
    %keyboard
end
for k = 10:99
    num = strcat('0',num2str(k));
    trialname = strcat(activity,num);
    %trialname = strcat('BP_C_002_',activity,num);

    data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,15);
    %data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,15);

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);

    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
end
for k = 100:150
    num = num2str(k);
    trialname = strcat(activity,num);
    %trialname = strcat('BP_C_002_',activity,num);

    data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,15);
    %data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,15);

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);

    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
end

if strcmp(activity,'crouch_')  
    data_crouch = data_out;
elseif strcmp(activity,'slowWalk_')  
    data_slowwalk = data_out;
elseif strcmp(activity,'sitting_')  
    data_sitting = data_out;
elseif strcmp(activity,'fastWalk_')  
    data_fastWalk = data_out;
elseif strcmp(activity,'standing_')  
    data_standing = data_out;
end

clearvars data_out
    
%% Section 2: calculate MAV, Variance, Nzero, etc

%% section 3: save data as .mat

% Hey what up