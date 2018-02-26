function [ acc ] = evaluateClassifier_ASB(classifierObj, testingData, testingLabels)
%UNTITLED3 Summary of this function goes here
%  This function expects that the testing data is in the same format found
%  in classify_LDA_norm.m

%% Evaluate the classifier on the test data
% keyboard
ourPredictions = predict(classifierObj,testingData);
rightOrWrong = strcmp(ourPredictions, testingLabels);

acc = sum(rightOrWrong)/length(rightOrWrong);


end
