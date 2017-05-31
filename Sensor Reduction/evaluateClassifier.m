function [ meanAccuracy ] = evaluateClassifier(classifierObj, testingData)
%UNTITLED3 Summary of this function goes here
%  This function expects that the testing data is in the same format found
%  in classify_LDA_norm.m

%% Evaluate the classifier on the test data

% Test crouching
parfor i = 1:1200
   ourCrouchPrediction(i) = predict(classifierObj, testingData(i,:));
end
ourCrouchPrediction = ourCrouchPrediction';
a = find(strcmp(ourCrouchPrediction,'crouch'));
accuracyCrouch = length(a)/1200;

% Test fastWalk
parfor i = 1:1200
    ourFastPrediction(i) = predict(classifierObj, testingData(i+1200,:));
end
ourFastPrediction = ourFastPrediction';
b = find(strcmp(ourFastPrediction,'fastWalk'));
accuracyFast = length(b)/1200;

% Test sitting
parfor i = 1:1200
    ourSittingPrediction(i) = predict(classifierObj, testingData(i+2400,:));
end
ourSittingPrediction = ourSittingPrediction';
c = find(strcmp(ourSittingPrediction,'sitting'));
accuracySitting = length(c)/1200; 

% Test slow walking
parfor i = 1:1200
    ourSlowPrediction(i) = predict(classifierObj, testingData(i+3600,:));
end
ourSlowPrediction = ourSlowPrediction';
d = find(strcmp(ourSlowPrediction,'slowWalk'));
accuracySlow = length(d)/1200;

% Test standing
parfor i = 1:1200
    ourStandingPrediction(i) = predict(classifierObj, testingData(i+4800,:));
end
ourStandingPrediction = ourStandingPrediction';
e = find(strcmp(ourStandingPrediction,'standing'));
accuracyStanding = length(e)/1200;

% Test stair ascent
parfor i = 1:1200
    ourAscentPrediction(i) = predict(classifierObj, testingData(i+6000,:));
end
ourAscentPrediction = ourAscentPrediction';
f = find(strcmp(ourAscentPrediction,'stair ascent'));
accuracyAscent = length(f)/1200;

% Test stair descent
parfor i = 1:1200
    ourDescentPrediction(i) = predict(classifierObj, testingData(i+7200,:));
end
ourDescentPrediction = ourDescentPrediction';
g = find(strcmp(ourDescentPrediction,'stair descent'));
accuracyDescent = length(g)/1200;

% Test dorsiflexion
parfor i = 1:1200
    ourDorsiPrediction(i) = predict(classifierObj, testingData(i+8400,:));
end
ourDorsiPrediction = ourDorsiPrediction';
h = find(strcmp(ourDorsiPrediction,'dorsi'));
accuracyDorsi = length(h)/1200;

% Test plantarflexion
parfor i = 1:1200
    ourPlantarPrediction(i) = predict(classifierObj, testingData(i+9600,:));
end
ourPlantarPrediction = ourPlantarPrediction';
j = find(strcmp(ourPlantarPrediction,'plantar'));
accuracyPlantar = length(j)/1200;

meanAccuracy = mean([accuracyCrouch; accuracyFast; accuracySitting;...
                        accuracySlow; accuracyStanding; accuracyAscent;...
                            accuracyDescent; accuracyDorsi; accuracyPlantar]);


end
