%%  Use this script to reduce sensors in a manner of average intelligence
%   I'm sure there's a 'smart' way to do this, and the 'dumb' was is to do
%   it combinatorially, but this should work to some degree.

clear; close all; clc;

%% load

% load crouch_featurized_norm1.mat
load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat
% load dorsiFlex_featurized_norm1.mat
% load plantarFlex_featurized_norm1.mat
load stairAscent_featurized1.mat
load stairDescent_featurized1.mat

% load crouch_featurized_norm2.mat
load fastWalk_featurized2.mat
load slowWalk_featurized2.mat
load sitting_featurized2.mat
load standing_featurized2.mat
% load dorsiFlex_featurized_norm2.mat
% load plantarFlex_featurized_norm2.mat
load stairAscent_featurized2.mat
load stairDescent_featurized2.mat

%% Reshape the training data into format needed for training.

% To train the classifier, a matrix must be built where each row
% corresponds to a labeled example, and each column is a
% measurement/feature.

% Use this switch to determine which data is used for training.
% training = 'P1';
% training = 'P2';
training = 'P1&P2';

% Use this switch to determine which data is used for testing.
% testing = 'P1';
% testing = 'P2';
testing = 'P1&P2';

% parfor i = 1:1200
%     trainingData1(i,:) = reshape(crouch_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i,:) = reshape(crouch_feat_norm2(:,:,i), 1, 80);
%     trainingLabels{i} = 'crouch';
% end


parfor i = 1:1200
    trainingData1(i,:) = reshape(fastWalk_feat1(:,:,i), 1, 80);
    trainingData2(i,:) = reshape(fastWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i} = 'fastWalk';
end

parfor i = 1:1200
    trainingData1(i+1200,:) = reshape(sitting_feat1(:,:,i), 1, 80);
    trainingData2(i+1200,:) = reshape(sitting_feat2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'sitting';
end

parfor i = 1:1200
    trainingData1(i+2400,:) = reshape(slowWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+2400,:) = reshape(slowWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'slowWalk';
end

parfor i = 1:1200
    trainingData1(i+3600,:) = reshape(standing_feat1(:,:,i), 1, 80);
    trainingData2(i+3600,:) = reshape(standing_feat2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'standing';
end

parfor i = 1:1200
    trainingData1(i+4800,:) = reshape(ascent_feat1(:,:,i), 1, 80);
    trainingData2(i+4800,:) = reshape(ascent_feat2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'stair ascent';
end

parfor i = 1:1200
    trainingData1(i+6000,:) = reshape(descent_feat1(:,:,i), 1, 80);
    trainingData2(i+6000,:) = reshape(descent_feat2(:,:,i), 1, 80);
    trainingLabels{i+6000} = 'stair descent';
end

% parfor i = 1:1200
%     trainingData1(i+7200,:) = reshape(dorsi_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+7200,:) = reshape(dorsi_feat_norm2(:,:,i), 1, 80);
%     trainingLabels{i+7200} = 'dorsi';
% end

% parfor i = 1:1200
%     trainingData1(i+8400,:) = reshape(plantar_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+8400,:) = reshape(plantar_feat_norm2(:,:,i), 1, 80);
%     trainingLabels{i+8400} = 'plantar';
% end

% Put together training matrix based up which data was selected above.
if strcmp(training, 'P1')
    trainingData = trainingData1;
    trainingLabels = trainingLabels';
elseif strcmp(training, 'P2')
    trainingData = trainingData2;
    trainingLabels = trainingLabels';
elseif strcmp(training, 'P1&P2')
    trainingData = vertcat(trainingData1,trainingData2);
    trainingLabels = vertcat(trainingLabels', trainingLabels');
end

%% Reshape the testing data 

% parfor i = 1:1200
%     testingData1(i,:) = reshape(crouch_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i,:) = reshape(crouch_feat_norm2(:,:,i+1200), 1, 80);
%     testingLabels{i} = 'crouch';
% end

parfor i = 1:1200
    testingData1(i,:) = reshape(fastWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i,:) = reshape(fastWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'fastWalk';
end

parfor i = 1:1200
    testingData1(i+1200,:) = reshape(sitting_feat1(:,:,i+1200), 1, 80);
    testingData2(i+1200,:) = reshape(sitting_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'sitting';
end

parfor i = 1:1200
    testingData1(i+2400,:) = reshape(slowWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+2400,:) = reshape(slowWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'slowWalk';
end

parfor i = 1:1200
    testingData1(i+3600,:) = reshape(standing_feat1(:,:,i+1200), 1, 80);
    testingData2(i+3600,:) = reshape(standing_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'standing';
end

parfor i = 1:1200
    testingData1(i+4800,:) = reshape(ascent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+4800,:) = reshape(ascent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'stair ascent';
end

parfor i = 1:1200
    testingData1(i+6000,:) = reshape(descent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+6000,:) = reshape(descent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+6000} = 'stair descent';
end

% parfor i = 1:1200
%     testingData1(i+6000,:) = reshape(dorsi_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+6000,:) = reshape(dorsi_feat_norm2(:,:,i+1200), 1, 80);
%     testingLabels{i+6000} = 'dorsi';
% end

% parfor i = 1:1200
%     testingData1(i+7200,:) = reshape(plantar_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+7200,:) = reshape(plantar_feat_norm2(:,:,i+1200), 1, 80);
%     testingLabels{i+7200} = 'plantar';
% end

% Put together testing matrix based up which data was selected above.
if strcmp(testing, 'P1')
    testingData = testingData1;
    testingLabels = testingLabels';
elseif strcmp(testing, 'P2')
    testingData = testingData2;
    testingLabels = testingLabels';
elseif strcmp(testing, 'P1&P2')
    testingData = vertcat(testingData1,testingData2);
    testingLabels = vertcat(testingLabels', testingLabels');
end

%% Sensor labeling

sensorLabels = {'sensor1','sensor2','sensor3','sensor4','sensor5',...
                    'sensor6','sensor7','sensor8','sensor9','sensor10',...
                        'sensor11','sensor12','sensor13','sensor14',...
                            'sensor15','sensor16'}';

%% First round
disp('1')

X = [trainingData; testingData];
Xlabels = [trainingLabels; testingLabels];

numSamp = size(X,1);
trainSize = floor(numSamp*0.8);

indVec = randperm(numSamp)';

randX = X(indVec,:);
randLabs = Xlabels(indVec);

trainingData = randX(1:trainSize,:);
trainingLabels = randLabs(1:trainSize);

testingData = randX(trainSize+1:end,:);
testingLabels = randLabs(trainSize+1:end);

[u,s,v] = svd(trainingData','econ');
trainingData = v;
testingData = inv(s)*u'*testingData';
testingData = testingData';

SVMclassifier = fitcecoc(trainingData,trainingLabels);

accuracy = evaluateClassifier_ASB(SVMclassifier,testingData,testingLabels);

for i = 0:15
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);

    accuracy1(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end
% keyboard

[a1,b1] = max(accuracy1);
sensorLabels(b1) = [];
sensorLabels1 = sensorLabels';

switch b1
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
    case 12
        trainingData(:,56:60) = [];
        testingData(:,56:60) = [];
    case 13
        trainingData(:,61:65) = [];
        testingData(:,61:65) = [];
    case 14
        trainingData(:,66:70) = [];
        testingData(:,66:70) = [];
    case 15
        trainingData(:,71:75) = [];
        testingData(:,71:75) = [];
    case 16
        trainingData(:,76:80) = [];
        testingData(:,76:80) = [];
end

clear cutStart cutEnd

%% Second round
disp('2')
% keyboard
parfor i = 0:14
    
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    
    accuracy2(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a2,b2] = max(accuracy2);
sensorLabels(b2) = [];
sensorLabels2 = sensorLabels';

switch b2
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
    case 12
        trainingData(:,56:60) = [];
        testingData(:,56:60) = [];
    case 13
        trainingData(:,61:65) = [];
        testingData(:,61:65) = [];
    case 14
        trainingData(:,66:70) = [];
        testingData(:,66:70) = [];
    case 15
        trainingData(:,71:75) = [];
        testingData(:,71:75) = [];
end

clear cutStart cutEnd

%% third round
disp('3')

parfor i = 0:13
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy3(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a3,b3] = max(accuracy3);
sensorLabels(b3) = [];
sensorLabels3 = sensorLabels';

switch b3
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
    case 12
        trainingData(:,56:60) = [];
        testingData(:,56:60) = [];
    case 13
        trainingData(:,61:65) = [];
        testingData(:,61:65) = [];
    case 14
        trainingData(:,66:70) = [];
        testingData(:,66:70) = [];
end

clear cutStart cutEnd

%% fourth round
disp('4')

parfor i = 0:12
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy4(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a4,b4] = max(accuracy4);
sensorLabels(b4) = [];
sensorLabels4 = sensorLabels';

switch b4
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
    case 12
        trainingData(:,56:60) = [];
        testingData(:,56:60) = [];
    case 13
        trainingData(:,61:65) = [];
        testingData(:,61:65) = [];
end

clear cutStart cutEnd

%% fifth round
disp('5')

parfor i = 0:11
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy5(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a5,b5] = max(accuracy5);
sensorLabels(b5) = [];
sensorLabels5 = sensorLabels';

switch b5
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
    case 12
        trainingData(:,56:60) = [];
        testingData(:,56:60) = [];
end

clear cutStart cutEnd

%% sixth round
disp('6')

parfor i = 0:10
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy6(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a6,b6] = max(accuracy6);
sensorLabels(b6) = [];
sensorLabels6 = sensorLabels';

switch b6
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
    case 11
        trainingData(:,51:55) = [];
        testingData(:,51:55) = [];
end

clear cutStart cutEnd

%% seventh round
disp('7')

parfor i = 0:9
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy7(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a7,b7] = max(accuracy7);
sensorLabels(b7) = [];
sensorLabels7 = sensorLabels';

switch b7
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
    case 10
        trainingData(:,46:50) = [];
        testingData(:,46:50) = [];
end

clear cutStart cutEnd

%% eigth round
disp('8')

parfor i = 0:8
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy8(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a8,b8] = max(accuracy8);
sensorLabels(b8) = [];
sensorLabels8 = sensorLabels';

switch b8
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
    case 9
        trainingData(:,41:45) = [];
        testingData(:,41:45) = [];
end

clear cutStart cutEnd

%% ninth round
disp('9')

parfor i = 0:7
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy9(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a9,b9] = max(accuracy9);
sensorLabels(b9) = [];
sensorLabels9 = sensorLabels';

switch b9
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
    case 8
        trainingData(:,36:40) = [];
        testingData(:,36:40) = [];
end

clear cutStart cutEnd

%% tenth round
disp('10')

parfor i = 0:6
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy10(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a10,b10] = max(accuracy10);
sensorLabels(b10) = [];
sensorLabels10 = sensorLabels';

switch b10
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
    case 7
        trainingData(:,31:35) = [];
        testingData(:,31:35) = [];
end

clear cutStart cutEnd

%% eleventh round
disp('11')

parfor i = 0:5
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy11(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a11,b11] = max(accuracy11);
sensorLabels(b11) = [];
sensorLabels11 = sensorLabels';

switch b11
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
    case 6
        trainingData(:,26:30) = [];
        testingData(:,26:30) = [];
end

clear cutStart cutEnd

%% twelfth round
disp('12')

parfor i = 0:4
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy12(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a12,b12] = max(accuracy12);
sensorLabels(b12) = [];
sensorLabels12 = sensorLabels';

switch b12
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
    case 5
        trainingData(:,21:25) = [];
        testingData(:,21:25) = [];
end

clear cutStart cutEnd

%% thirteenth round
disp('13')
parfor i = 0:3
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy13(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a13,b13] = max(accuracy13);
sensorLabels(b13) = [];
sensorLabels13 = sensorLabels';

switch b13
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
    case 4
        trainingData(:,16:20) = [];
        testingData(:,16:20) = [];
end

clear cutStart cutEnd

%% fourteenth round
disp('14')
parfor i = 0:2
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy14(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a14,b14] = max(accuracy14);
sensorLabels(b14) = [];
sensorLabels14 = sensorLabels';

switch b14
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
    case 3
        trainingData(:,11:15) = [];
        testingData(:,11:15) = [];
end

clear cutStart cutEnd

%% fifteenth round
disp('15')
parfor i = 0:1
    cutStart(i+1) = 5*i+1;
    cutEnd(i+1) = 5*i+5;
     
    trainingDataCut = trainingData;
    testingDataCut = testingData;
    
    trainingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    testingDataCut(:,cutStart(i+1):cutEnd(i+1)) = [];
    
    % cast into svd basis
    [u,s,v] = svd(trainingDataCut','econ');
    trainingDataCut = v;
    testingDataCut = inv(s)*u'*testingDataCut';
    testingDataCut = testingDataCut';
    
    SVMclassifier = fitcecoc(trainingDataCut,trainingLabels);
    accuracy15(i+1) = evaluateClassifier_ASB(SVMclassifier,testingDataCut,testingLabels);
end

[a15,b15] = max(accuracy15);
sensorLabels(b15) = [];
sensorLabels15 = sensorLabels';

switch b15
    case 1
        trainingData(:,1:5) = [];
        testingData(:,1:5) = [];
    case 2
        trainingData(:,6:10) = [];
        testingData(:,6:10) = [];
end

%% 

theCell = {accuracy1; accuracy2; accuracy3; accuracy4; accuracy5;...
                accuracy6; accuracy7; accuracy8; accuracy9; accuracy10;...
                    accuracy11; accuracy12; accuracy13; accuracy14;...
                        accuracy15};

parfor i = 1:15
    maxAcc(i) = max(cell2mat(theCell(i)));
end


%%

sensorsOrderedSVM = {};
                            
% sensorAccuracyPlotSVM = fliplr(maxAcc);

% save('sensorReductionResults.mat','sensorsOrderedSVM','sensorAccuracyPlotSVM')

