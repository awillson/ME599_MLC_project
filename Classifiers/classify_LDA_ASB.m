%% Perform LDA on our normalized Data Set
% |This script trains a linear discriminant analysis classifer to our data|
% 
% |and tests its accuracy.|
% 
% |Data points are also cast into LDA basis for 3D visualization.|

clear; close all; clc;
tic
%% Import data cubes
%%
load crouch_featurized1.mat
load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat
load dorsiFlex_featurized1.mat
load plantarFlex_featurized1.mat
load stairAscent_featurized1.mat
load stairDescent_featurized1.mat

load crouch_featurized2.mat
load fastWalk_featurized2.mat
load slowWalk_featurized2.mat
load sitting_featurized2.mat
load standing_featurized2.mat
load dorsiFlex_featurized2.mat
load plantarFlex_featurized2.mat
load stairAscent_featurized2.mat
load stairDescent_featurized2.mat
%% Reshape the training data into format needed for training.
%%
% To train the classifier, a matrix must be built where each row
% corresponds to a labeled example, and each column is a
% measurement/feature.

% Use this switch to determine which data is used for training.
 training = 'P1';
% training = 'P2';
% training = 'P1&P2';

% Use this switch to determine which data is used for testing.
 testing = 'P1';
% testing = 'P2';
% testing = 'P1&P2';

parfor i = 1:1200
    trainingData1(i,:) = reshape(crouch_feat1(:,:,i), 1, 80);
    trainingData2(i,:) = reshape(crouch_feat2(:,:,i), 1, 80);
    trainingLabels{i} = 'crouch';
end


parfor i = 1:1200
    trainingData1(i+1200,:) = reshape(fastWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+1200,:) = reshape(fastWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    trainingData1(i+2400,:) = reshape(sitting_feat1(:,:,i), 1, 80);
    trainingData2(i+2400,:) = reshape(sitting_feat2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    trainingData1(i+3600,:) = reshape(slowWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+3600,:) = reshape(slowWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    trainingData1(i+4800,:) = reshape(standing_feat1(:,:,i), 1, 80);
    trainingData2(i+4800,:) = reshape(standing_feat2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'standing';
end

parfor i = 1:1200
    trainingData1(i+6000,:) = reshape(ascent_feat1(:,:,i), 1, 80);
    trainingData2(i+6000,:) = reshape(ascent_feat2(:,:,i), 1, 80);
    trainingLabels{i+6000} = 'stair ascent';
end

parfor i = 1:1200
    trainingData1(i+7200,:) = reshape(descent_feat1(:,:,i), 1, 80);
    trainingData2(i+7200,:) = reshape(descent_feat2(:,:,i), 1, 80);
    trainingLabels{i+7200} = 'stair descent';
end

parfor i = 1:1200
    trainingData1(i+8400,:) = reshape(dorsi_feat1(:,:,i), 1, 80);
    trainingData2(i+8400,:) = reshape(dorsi_feat2(:,:,i), 1, 80);
    trainingLabels{i+8400} = 'dorsi';
end

parfor i = 1:1200
    trainingData1(i+9600,:) = reshape(plantar_feat1(:,:,i), 1, 80);
    trainingData2(i+9600,:) = reshape(plantar_feat2(:,:,i), 1, 80);
    trainingLabels{i+9600} = 'plantar';
end

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
%%
parfor i = 1:1200
    testingData1(i,:) = reshape(crouch_feat1(:,:,i+1200), 1, 80);
    testingData2(i,:) = reshape(crouch_feat2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'crouch';
end

parfor i = 1:1200
    testingData1(i+1200,:) = reshape(fastWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+1200,:) = reshape(fastWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    testingData1(i+2400,:) = reshape(sitting_feat1(:,:,i+1200), 1, 80);
    testingData2(i+2400,:) = reshape(sitting_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    testingData1(i+3600,:) = reshape(slowWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+3600,:) = reshape(slowWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    testingData1(i+4800,:) = reshape(standing_feat1(:,:,i+1200), 1, 80);
    testingData2(i+4800,:) = reshape(standing_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'standing';
end

parfor i = 1:1200
    testingData1(i+6000,:) = reshape(ascent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+6000,:) = reshape(ascent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+6000} = 'stair ascent';
end

parfor i = 1:1200
    testingData1(i+7200,:) = reshape(descent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+7200,:) = reshape(descent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+7200} = 'stair descent';
end

parfor i = 1:1200
    testingData1(i+8400,:) = reshape(dorsi_feat1(:,:,i+1200), 1, 80);
    testingData2(i+8400,:) = reshape(dorsi_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+8400} = 'dorsi';
end

parfor i = 1:1200
    testingData1(i+9600,:) = reshape(plantar_feat1(:,:,i+1200), 1, 80);
    testingData2(i+9600,:) = reshape(plantar_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+9600} = 'plantar';
end

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
%% Rethink how we separate training and testing data
%%
X = [trainingData; testingData]; % each column is a measurement type, each row is an observation
Xlabels = [trainingLabels; testingLabels];

for j = 1:10
    indexVector = randperm(21600)';

    Xtraining = X(indexVector(1:17280),:);
    XtrainingLabels = Xlabels(indexVector(1:17280));

    Xtesting = X(indexVector(17281:end),:);
    XtestingLabels = Xlabels(indexVector(17281:end));

%% SVD the Data
%%
%     % Scale and center
%     scaledTrain = -1 + 2.*(Xtraining - min(Xtraining))./(max(Xtraining) - min(Xtraining));
%     scaledTest = -1 + 2.*(Xtesting - min(Xtraining))./(max(Xtraining) - min(Xtraining));
    
%     [u,s,v] = svd(Xtraining','econ');
%     [u,s,v] = svd(scaledTrain','econ');

%     truncate
%     utrun = u(:,1:33); strun = s(1:50,1:50); vtrun = v(:,1:50);
    
%     new training data in SVD space
%     finalTrainingData = vtrun;
%     finalTrainingData = v;
    
%     cast testing data into SVD space and truncate
%     finalTestingData = inv(s)*u'*Xtesting';
%     finalTestingData = finalTestingData(1:50,:);
%     finalTestingData = finalTestingData';
%     finalTestingData = inv(s)*u'*scaledTest';
%     finalTestingData = finalTestingData';

finalTrainingData = Xtraining;
finalTestingData = Xtesting;
%% Create the classifier
%%
    % Can't believe it's this easy.
    LDAclassifier = fitcdiscr(finalTrainingData,XtrainingLabels);
%% Test Classifier
%%
    for i = 1:length(XtestingLabels)
        ourPredictions(i,1) = predict(LDAclassifier, finalTestingData(i,:));
        rightOrWrong(i) = strcmp(ourPredictions(i,1),XtestingLabels(i,1));
    end
    
    accuracy(j) = (sum(rightOrWrong)/length(rightOrWrong))*100;
    
end

mean(accuracy)
%%