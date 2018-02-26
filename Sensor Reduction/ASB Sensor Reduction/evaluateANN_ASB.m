function [acc] = evaluateANN_ASB(net,testingData,testingTargets)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

outputs = net(testingData);
outRound = round(outputs);

rightOrWrong = zeros([size(outRound,2), 1]);
    for i = 1:size(outRound,2)
        rightOrWrong(i) = isequal(outRound(:,i), testingTargets(:,i));
    end
    
acc = (sum(rightOrWrong)/length(rightOrWrong))*100;
end

