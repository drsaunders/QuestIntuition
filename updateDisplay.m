function [tTest q] = updateDisplay(handles)
tTest = QuestMean(handles.q);
%  tTest = QuestMode(handles.q);

q=QuestRecompute(handles.q);

relativeToUpperLimit  = 1; %get(handles.relative,'Value');
upperLimit = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimit = str2num(get(handles.lowerLimitUnlog,'String'));
% if lowerLimit <= 0
%     set(handles.lowerLimitLog,'String','-Inf');
% else
%     if relativeToUpperLimit
%         set(handles.lowerLimitLog,'String',num2str(log10(lowerLimit/upperLimit)));
%     else
%         set(handles.lowerLimitLog,'String',num2str(log10(lowerLimit)));
%     end
% end
% if relativeToUpperLimit
%     set(handles.upperLimitLog,'String','0');
% else
%     set(handles.upperLimitLog,'String',num2str(log10(upperLimit)));
% end

set(handles.testLevel,'String', ['Test level = ' sprintf('%.2f', tTest)]);

unlogTestLevel = 10 ^ tTest;
if relativeToUpperLimit
    unlogTestLevel  = unlogTestLevel  * upperLimit;
end
set(handles.unlogTestLevel,'String', ['Test level = ' sprintf('%.2f', unlogTestLevel)]);
set(handles.threshEst,'String', sprintf('%.2f', unlogTestLevel)); % The way this works now, the final threshold estimate is the same as the next test level.

if unlogTestLevel < lowerLimit
    unlogTestLevel = lowerLimit;
elseif unlogTestLevel > upperLimit
    unlogTestLevel = upperLimit;
end
set(handles.limitedUnlogTestLevel,'String', ['Limited test level = ' sprintf('%.2f', unlogTestLevel)]);
tTest = unlogTestLevel;
if relativeToUpperLimit
    tTest  = tTest / upperLimit;
end
tTest = log10(tTest);
set(handles.limitedLogTestLevel,'String', ['Limited test level = ' sprintf('%.2f', tTest)]);

set(handles.pdfStd, 'String',sprintf('%.3f',QuestSd(q)));

% Draw the pdf  
axes(handles.axes1);
hold off;
plot(q.x + q.tGuess, q.pdf,'k');
% Draw the functions that will be applied in the case of correct or
% incorrect
if get(handles.showS2,'Value')
    hold on;
    ii=size(q.pdf,2)+q.i-round((tTest-q.tGuess)/q.grain);
    plot(q.x + q.tGuess, max(q.pdf) * q.s2(1,ii),'r');
    plot(q.x + q.tGuess, max(q.pdf) * q.s2(2,ii),'b');
end
axis tight
xlabel('Trial');
ylabel('Intensity (log)');

% Draw the trial history
axes(handles.axes2);
plot([q.intensity(1:q.trialCount) tTest],'.-','MarkerSize',20);
xlabel('Trial');
ylabel('Intensity');


% Now the unlog versions
    

% Draw the trial history
axes(handles.axes4);
intensities = [q.intensity(1:q.trialCount) tTest];
intensities = 10 .^ intensities ;
if relativeToUpperLimit
    intensities = intensities * upperLimit;
end
plot(intensities,'.-','MarkerSize',20);
xlabel('Trial');
ylabel('Intensity (log)');

% Draw the posterior distribution function
axes(handles.axes3);
x = q.x + q.tGuess;
x =  10 .^ x;
if relativeToUpperLimit 
    x = x * upperLimit;
end
plot(x, q.pdf,'k');
axis tight
xlabel('Intensity (log)');
ylabel('Probability');

set(gca,'XLim',[lowerLimit upperLimit]);
