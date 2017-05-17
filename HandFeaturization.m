% Featurization of RAW EMG data

clear all; close all; clc;

%% Section 1: read in data, slice into 150 ms cube
trialname = 'crouch_001';

data_in = dlmread(strcat('../BP_C_001/',trialname),',',6,15);


%% Section 2: calculate MAV, Variance, NZERO, etc

%% section 3: save data as .mat

