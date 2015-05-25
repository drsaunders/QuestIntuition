function varargout = QuestVisualize(varargin)
% QUESTVISUALIZE M-file for QuestVisualize.fig
%      QUESTVISUALIZE, by itself, creates a new QUESTVISUALIZE or raises the existing
%      singleton*.
%
%      H = QUESTVISUALIZE returns the handle to a new QUESTVISUALIZE or the handle to
%      the existing singleton*.
%
%      QUESTVISUALIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUESTVISUALIZE.M with the given input arguments.
%
%      QUESTVISUALIZE('Property','Value',...) creates a new QUESTVISUALIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QuestQuest_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QuestVisualize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QuestVisualize

% Last Modified by GUIDE v2.5 30-Jul-2013 17:42:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuestVisualize_OpeningFcn, ...
                   'gui_OutputFcn',  @QuestVisualize_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before QuestVisualize is made visible.
function QuestVisualize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuestVisualize (see VARARGIN)

% Choose default command line output for QuestVisualize
handles.output = hObject;

warning('off','MATLAB:log:logOfZero');

% set(handles.relative,'Value',1);
% set(handles.useLimits,'Value',1);

% Update handles structure
guidata(hObject, handles);

resetQuest(hObject, eventdata, handles);

handles = guidata(hObject);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using QuestVisualize.
if strcmp(get(hObject,'Visible'),'off')
    [tTest q] = updateDisplay(hObject, eventdata, handles);
    handles.tTest = tTest;
    handles.q = q;
    guidata(hObject, handles);
end

% UIWAIT makes QuestVisualize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QuestVisualize_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Correct.
function Correct_Callback(hObject, eventdata, handles)
% hObject    handle to Correct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
response = 1;
handles.q = QuestUpdate(handles.q,handles.tTest,response);
tTest = updateDisplay(hObject, eventdata, handles);
handles.tTest = tTest;
guidata(hObject, handles);

% --- Executes on button press in Incorrect.
function Incorrect_Callback(hObject, eventdata, handles)
% hObject    handle to Incorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
response = 0;
handles.q = QuestUpdate(handles.q,handles.tTest,response);
tTest = updateDisplay(hObject, eventdata, handles);
handles.tTest = tTest;
guidata(hObject, handles);


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)



function [tTest q] = updateDisplay(hObject, eventdata, handles)
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

set(handles.pdfStd, 'String',sprintf('%.3f',QuestSD(q)));

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



function upperLimitUnlog_Callback(hObject, eventdata, handles)
% hObject    handle to upperLimitUnlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperLimitUnlog as text
%        str2double(get(hObject,'String')) returns contents of upperLimitUnlog as a double
updateDisplay(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function upperLimitUnlog_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperLimitUnlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to upperLimitUnlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperLimitUnlog as text
%        str2double(get(hObject,'String')) returns contents of upperLimitUnlog as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperLimitUnlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in useLimits.
function useLimits_Callback(hObject, eventdata, handles)
% hObject    handle to useLimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of useLimits
updateDisplay(hObject, eventdata, handles);

% --- Executes on button press in relative.
function relative_Callback(hObject, eventdata, handles)
% hObject    handle to relative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of relative
updateDisplay(hObject, eventdata, handles);

function lowerLimitUnlog_Callback(hObject, eventdata, handles)
updateDisplay(hObject, eventdata, handles);


% --- Executes on button press in drawPsychometricFunction.
function drawPsychometricFunction_Callback(hObject, eventdata, handles)
% hObject    handle to drawPsychometricFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = handles.q.x2+QuestMean(handles.q);
figure; subplot(2,1,1); plot(x,handles.q.p2); grid on;
set(gca,'XLim', [-2 2]);
ytick = [ 0.5000      0.6000      0.7000    0.8000  0.82     0.9000   1];
set(gca,'YTick',ytick);

relativeToUpperLimit  = 1; %get(handles.relative,'Value');
upperLimit = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimit = str2num(get(handles.lowerLimitUnlog,'String'));
if relativeToUpperLimit
    logLowerLimit = log10(lowerLimit/upperLimit);
    logUpperLimit = 0;
else
    logLowerLimit = log10(lowerLimit);
    logUpperLimit = log10(upperLimit);
end

xlim = get(gca,'XLim');
xlim(2) = logUpperLimit;
set(gca,'XLim',xlim);

x =  10 .^ x;
if relativeToUpperLimit 
    x = x * upperLimit;
end
subplot(2,1,2); plot(x,handles.q.p2); grid on;
set(gca,'YTick',ytick);
xlim = get(gca,'XLim');
xlim(2) = upperLimit;
set(gca,'XLim',xlim);


% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set up variables
tActual = str2num(get(handles.trueThres,'String'));
if isempty(tActual) return; end;
relativeToUpperLimit  = 1; %get(handles.relative,'Value');
upperLimit = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimit = str2num(get(handles.lowerLimitUnlog,'String'));
if relativeToUpperLimit
    logLowerLimit = log10(lowerLimit/upperLimit);
    logUpperLimit = 0;
else
    logLowerLimit = log10(lowerLimit);
    logUpperLimit = log10(upperLimit);
end
if relativeToUpperLimit
    tActual = tActual / upperLimit;
end
tActual = log10(tActual);


% Start new Quest instance
myq=QuestCreate(handles.q.tGuess,handles.q.tGuessSd,handles.q.pThreshold,handles.q.beta,handles.q.delta,handles.q.gamma);
myq=QuestRecompute(myq);
numTrials = str2num(get(handles.numTrials,'String'));
for k = 1:numTrials
    tTest = QuestMean(myq);
        tTest=min(logUpperLimit,max(logLowerLimit,tTest));
    
    response=QuestSimulate(myq,tTest,tActual);

    myq=QuestUpdate(myq,tTest,response);
end

disp(sprintf('%d ',myq.response))

intensities = myq.intensity(1:myq.trialCount);
intensities = 10 .^ intensities ;
if relativeToUpperLimit
    intensities = intensities * upperLimit;
end
figure;  plot(intensities,'.-'); axis tight;
finalVal = QuestMean(myq);
finalVal=min(logUpperLimit,max(logLowerLimit,finalVal));
finalVal = 10 ^ finalVal;
if relativeToUpperLimit
    finalVal = finalVal * upperLimit;
end

title(['Final threshold computation: ' num2str(finalVal)]);

function trueThres_Callback(hObject, eventdata, handles)
% hObject    handle to trueThres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trueThres as text
%        str2double(get(hObject,'String')) returns contents of trueThres as a double


% --- Executes during object creation, after setting all properties.
function trueThres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trueThres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in distOfEstimates.
function distOfEstimates_Callback(hObject, eventdata, handles)
% hObject    handle to distOfEstimates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


tActual = str2num(get(handles.trueThres,'String'));
if isempty(tActual) return; end;
relativeToUpperLimit  = 1; %get(handles.relative,'Value');
upperLimit = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimit = str2num(get(handles.lowerLimitUnlog,'String'));
if relativeToUpperLimit
    logLowerLimit = log10(lowerLimit/upperLimit);
    logUpperLimit = 0;
else
    logLowerLimit = log10(lowerLimit);
    logUpperLimit = log10(upperLimit);
end

if relativeToUpperLimit
    tActual = tActual / upperLimit;
end
tActual = log10(tActual);
numRuns = str2num(get(handles.numRuns,'String'));

finalVals = [];
numTrials = str2num(get(handles.numTrials,'String'));
numAtFloor = 0;
for i = 1:numRuns
    myq=QuestCreate(handles.q.tGuess,handles.q.tGuessSd,handles.q.pThreshold,handles.q.beta,handles.q.delta,handles.q.gamma);
    myq=QuestRecompute(myq);
    
    for k = 1:numTrials
        tTest = QuestMean(myq);
            tTest=min(logUpperLimit,max(logLowerLimit,tTest));

        response=QuestSimulate(myq,tTest,tActual);

        myq=QuestUpdate(myq,tTest,response);
    end
    intensities = myq.intensity(1:myq.trialCount);
    numAtFloor = numAtFloor + length(find(intensities >= 0));
    intensities = 10 .^ intensities ;
    if relativeToUpperLimit
        intensities = intensities * upperLimit;
    end
    finalVal = QuestMean(myq);
    finalVal=min(logUpperLimit,max(logLowerLimit,finalVal));
    finalVal = 10 ^ finalVal;
    if relativeToUpperLimit
        finalVal = finalVal * upperLimit;
    end
    finalVals = [finalVals finalVal];
end
figure; hist(finalVals); title(['Mean: ' num2str(mean(finalVals)) '  SD: ' num2str(std(finalVals)) ' At floor: ' num2str(numAtFloor)]);%'  SD/mean: ' num2str(std(finalVals)/mean(finalVals))]);
% disp(['Num at floor: ' num2str(numAtFloor) ' = ' num2str(numAtFloor
% /(numTrials * 100)) ' of the total' ]);

% --- Executes on button press in showS2.
function showS2_Callback(hObject, eventdata, handles)
% hObject    handle to showS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showS2
updateDisplay(hObject, eventdata, handles);




% --- Executes on button press in reversePsychometric.
function reversePsychometric_Callback(hObject, eventdata, handles)
% hObject    handle to reversePsychometric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reversePsychometric
[tTest q] = updateDisplay(hObject, eventdata, handles);

handles.q = q;
% Update handles structure
guidata(hObject, handles);





% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.q = QuestCreate(handles.q.tGuess,handles.q.tGuessSd,handles.q.pThreshold,handles.q.beta,handles.q.delta,handles.q.gamma);
[tTest q] = updateDisplay(hObject, eventdata, handles);
handles.tTest = tTest;
handles.q = q;
guidata(hObject, handles);






function initialGuess_Callback(hObject, eventdata, handles)
% hObject    handle to initialGuess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of initialGuess as text
%        str2double(get(hObject,'String')) returns contents of initialGuess as a double


% --- Executes during object creation, after setting all properties.
function initialGuess_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialGuess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function priorStd_Callback(hObject, eventdata, handles)
% hObject    handle to priorStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of priorStd as text
%        str2double(get(hObject,'String')) returns contents of priorStd as a double


% --- Executes during object creation, after setting all properties.
function priorStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to priorStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function targetThres_Callback(hObject, eventdata, handles)
% hObject    handle to targetThres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of targetThres as text
%        str2double(get(hObject,'String')) returns contents of targetThres as a double


% --- Executes during object creation, after setting all properties.
function targetThres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to targetThres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Beta_Callback(hObject, eventdata, handles)
% hObject    handle to Beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Beta as text
%        str2double(get(hObject,'String')) returns contents of Beta as a double


% --- Executes during object creation, after setting all properties.
function Beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Delta_Callback(hObject, eventdata, handles)
% hObject    handle to Delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Delta as text
%        str2double(get(hObject,'String')) returns contents of Delta as a double


% --- Executes during object creation, after setting all properties.
function Delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Gamma_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gamma as text
%        str2double(get(hObject,'String')) returns contents of Gamma as a double


% --- Executes during object creation, after setting all properties.
function Gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ApplyButton.
function ApplyButton_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetQuest(hObject, eventdata, handles);


function resetQuest(hObject, eventdata, handles)

initialGuess = get(handles.initialGuess,'String');
tGuess = log10(str2num(initialGuess) / 200);
tGuessSd = str2num(get(handles.priorStd, 'String'));
pThreshold=str2num(get(handles.targetThres, 'String'));
beta=str2num(get(handles.Beta, 'String')); 
delta=str2num(get(handles.Delta, 'String')); 
gamma=str2num(get(handles.Gamma, 'String'));
q=QuestCreate(tGuess,tGuessSd,pThreshold,beta,delta,gamma);
q.normalizePdf=1;
handles.q = q;
handles.maxVal = -1;

% Update handles structure
guidata(hObject, handles);
Reset_Callback(hObject, eventdata, handles);



function numTrials_Callback(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numTrials as text
%        str2double(get(hObject,'String')) returns contents of numTrials as a double


% --- Executes during object creation, after setting all properties.
function numTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numRuns_Callback(hObject, eventdata, handles)
% hObject    handle to numRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numRuns as text
%        str2double(get(hObject,'String')) returns contents of numRuns as a double


% --- Executes during object creation, after setting all properties.
function numRuns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


