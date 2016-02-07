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
    [tTest q] = updateDisplay(handles);
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
tTest = updateDisplay(handles);
handles.tTest = tTest;
guidata(hObject, handles);

% --- Executes on button press in Incorrect.
function Incorrect_Callback(hObject, eventdata, handles)
% hObject    handle to Incorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
response = 0;
handles.q = QuestUpdate(handles.q,handles.tTest,response);
tTest = updateDisplay(handles);
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






function upperLimitUnlog_Callback(hObject, eventdata, handles)
% hObject    handle to upperLimitUnlog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperLimitUnlog as text
%        str2double(get(hObject,'String')) returns contents of upperLimitUnlog as a double
updateDisplay(handles);



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
updateDisplay(handles);

% --- Executes on button press in relative.
function relative_Callback(hObject, eventdata, handles)
% hObject    handle to relative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of relative
updateDisplay(handles);

function lowerLimitUnlog_Callback(hObject, eventdata, handles)
updateDisplay(handles);


% --- Executes on button press in drawPsychometricFunction.
function drawPsychometricFunction_Callback(hObject, eventdata, handles)
% hObject    handle to drawPsychometricFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

upperLimit = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimit = str2num(get(handles.lowerLimitUnlog,'String'));

drawPsychometricFunction(upperLimit, lowerLimit, handles.q)

% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tActual = str2num(get(handles.trueThres,'String'));
if isempty(tActual) return; end;
upperLimitUnlog = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimitUnlog = str2num(get(handles.lowerLimitUnlog,'String'));
numTrials = str2num(get(handles.numTrials,'String'));

[intensities finalVal] = simulateQuestRun(tActual, upperLimitUnlog, lowerLimitUnlog, handles.q, numTrials);

% Plot the trials
figure;  
plot(intensities,'.-'); 
axis tight;
xlabel('Trial');
ylabel('Test level');
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
upperLimitUnlog = str2num(get(handles.upperLimitUnlog,'String'));
lowerLimitUnlog = str2num(get(handles.lowerLimitUnlog,'String'));
numTrials = str2num(get(handles.numTrials,'String'));
numRuns = str2num(get(handles.numRuns,'String'));

totalNumAtFloor = 0;
finalVals = [];
for i = 1:numRuns
    [intensities finalVal numAtFloor] = simulateQuestRun(tActual, upperLimitUnlog, lowerLimitUnlog, handles.q, numTrials);
    
    finalVals = [finalVals finalVal];
    totalNumAtFloor = totalNumAtFloor + numAtFloor;
end
figure; 
hist(finalVals); 
title(['Mean: ' num2str(mean(finalVals)) '  SD: ' num2str(std(finalVals)) '   Mean trials at floor: ' sprintf('%.1f',totalNumAtFloor/numRuns)]);%'  SD/mean: ' num2str(std(finalVals)/mean(finalVals))]);
xlabel('Final estimate of threshold');
ylabel('Frequency')

% --- Executes on button press in showS2.
function showS2_Callback(hObject, eventdata, handles)
% hObject    handle to showS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showS2
updateDisplay(handles);




% --- Executes on button press in reversePsychometric.
function reversePsychometric_Callback(hObject, eventdata, handles)
% hObject    handle to reversePsychometric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reversePsychometric
[tTest q] = updateDisplay(handles);

handles.q = q;
% Update handles structure
guidata(hObject, handles);





% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.q = QuestCreate(handles.q.tGuess,handles.q.tGuessSd,handles.q.pThreshold,handles.q.beta,handles.q.delta,handles.q.gamma);
[tTest q] = updateDisplay(handles);
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


