function [intensities finalVal numAtFloor] = simulateQuestRun(tActual, upperLimit, lowerLimit, q, numTrials)

% Set up variables
logLowerLimit = log10(lowerLimit/upperLimit);
logUpperLimit = 0;
tActual = tActual / upperLimit;

tActual = log10(tActual);
numAtFloor = 0;

% Start new Quest instance
myq=QuestCreate(q.tGuess,q.tGuessSd,q.pThreshold,q.beta,q.delta,q.gamma);
myq=QuestRecompute(myq);
for k = 1:numTrials
    tTest = QuestMean(myq);
    tTest=min(logUpperLimit,max(logLowerLimit,tTest));
    
    response=QuestSimulate(myq,tTest,tActual);

    myq=QuestUpdate(myq,tTest,response);
end

% disp(sprintf('%d ',myq.response))

intensities = myq.intensity(1:myq.trialCount);
numAtFloor = numAtFloor + length(find(intensities >= 0));
intensities = 10 .^ intensities ;
intensities = intensities * upperLimit;

finalVal = QuestMean(myq);
finalVal=min(logUpperLimit,max(logLowerLimit,finalVal));
finalVal = 10 ^ finalVal;
finalVal = finalVal * upperLimit;

    
