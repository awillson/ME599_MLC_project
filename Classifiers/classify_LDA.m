%% Try Out LDA on our Data Set

clear; close all; clc;

%% Import
load crouch_featurized1.mat
load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat

load crouch_featurized2.mat
load fastWalk_featurized2.mat
load slowWalk_featurized2.mat
load sitting_featurized2.mat
load standing_featurized2.mat
%% Reshape the training data into the same format as in the example code

for i = 1:1200
    trainingData1(i,:) = reshape(crouch_feat1(:,:,i), 1, 80);
    trainingData2(i,:) = reshape(crouch_feat2(:,:,i), 1, 80);
    trainingLabels{i} = 'crouch';
end


for i = 1:1200
    trainingData1(i+1200,:) = reshape(fastWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+1200,:) = reshape(fastWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    trainingData1(i+2400,:) = reshape(sitting_feat1(:,:,i), 1, 80);
    trainingData2(i+2400,:) = reshape(sitting_feat2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    trainingData1(i+3600,:) = reshape(slowWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+3600,:) = reshape(slowWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    trainingData1(i+4800,:) = reshape(standing_feat1(:,:,i), 1, 80);
    trainingData2(i+4800,:) = reshape(standing_feat2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'standing';
end
trainingData = vertcat(trainingData1,trainingData2);
trainingLabels = trainingLabels';
trainingLabels = vertcat(trainingLabels,trainingLabels);

%% Reshape the testing data 

for i = 1:1200
    testingData1(i,:) = reshape(crouch_feat1(:,:,i+1200), 1, 80);
    testingData2(i,:) = reshape(crouch_feat2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'crouch';
end

for i = 1:1200
    testingData1(i+1200,:) = reshape(fastWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+1200,:) = reshape(fastWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    testingData1(i+2400,:) = reshape(sitting_feat1(:,:,i+1200), 1, 80);
    testingData2(i+2400,:) = reshape(sitting_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    testingData1(i+3600,:) = reshape(slowWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+3600,:) = reshape(slowWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    testingData1(i+4800,:) = reshape(standing_feat1(:,:,i+1200), 1, 80);
    testingData2(i+4800,:) = reshape(standing_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'standing';
end

testingData = vertcat(testingData1,testingData2);
testingLabels = testingLabels';
testingLabels = vertcat(testingLabels,testingLabels);


%% Create the classifier

% Can't believe it's this easy.
LDAclassifier = fitcdiscr(trainingData,trainingLabels);

%% Evaluate the classifier on the test data

% Test crouching
for i = 1:1200
   ourCrouchPrediction(i) = predict(LDAclassifier, testingData(i,:));
end
ourCrouchPrediction = ourCrouchPrediction';
a = find(strcmp(ourCrouchPrediction,'crouch'));
accuracyCrouch = length(a)/1200;

% Test fastWalk
for i = 1:1200
    ourFastPrediction(i) = predict(LDAclassifier, testingData(i+1200,:));
end
ourFastPrediction = ourFastPrediction';
b = find(strcmp(ourFastPrediction,'fastWalk'));
accuracyFast = length(b)/1200;

% Test sitting
for i = 1:1200
    ourSittingPrediction(i) = predict(LDAclassifier, testingData(i+2400,:));
end
ourSittingPrediction = ourSittingPrediction';
c = find(strcmp(ourSittingPrediction,'sitting'));
accuracySitting = length(c)/1200; 

% Test slow walking
for i = 1:1200
    ourSlowPrediction(i) = predict(LDAclassifier, testingData(i+3600,:));
end
ourSlowPrediction = ourSlowPrediction';
d = find(strcmp(ourSlowPrediction,'slowWalk'));
accuracySlow = length(d)/1200;

% Test standing
for i = 1:1200
    ourStandingPrediction(i) = predict(LDAclassifier, testingData(i+4800,:));
end
ourStandingPrediction = ourStandingPrediction';
e = find(strcmp(ourStandingPrediction,'standing'));
accuracyStanding = length(e)/1200;

meanAccuracy = mean([accuracyCrouch; accuracyFast; accuracySitting;...
                        accuracySlow; accuracyStanding]);

