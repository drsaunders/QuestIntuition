function drawPsychometricFunction(upperLimit, lowerLimit, q, threshold)

ytick = [ 0.5000      0.6000      0.7000    0.8000       0.9000   1];

figure;
x = q.x2+QuestMean(q);
subplot(2,1,1); plot(x,q.p2); grid on;
title('Estimated psychometric functions (Weibull)');
set(gca,'XLim', [-2 2]);
set(gca,'YTick',ytick);
logLowerLimit = log10(lowerLimit/upperLimit);
logUpperLimit = 0;
xlim = get(gca,'XLim');
xlim(2) = logUpperLimit;
set(gca,'XLim',xlim);
xlabel('Stimulus intensity (log, relative to max)')
ylabel('Percent correct');

x =  10 .^ x;
x = x * upperLimit;
subplot(2,1,2); plot(x,q.p2); grid on;
set(gca,'YTick',ytick);
xlim = get(gca,'XLim');
xlim(2) = upperLimit;
set(gca,'XLim',xlim);
xlabel('Stimulus intensity');
ylabel('Percent correct');

