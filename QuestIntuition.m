function varargout = QuestIntuition(varargin)




% Edit the above text to modify the response to help QuestIntuition

% Last Modified by GUIDE v2.5 30-Mar-2016 21:26:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QuestIntuition_OpeningFcn, ...
                   'gui_OutputFcn',  @QuestIntuition_OutputFcn, ...
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



% --- Executes just before QuestIntuition is made visible.
function QuestIntuition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QuestIntuition (see VARARGIN)

% Choose default command line output for QuestIntuition
handles.output = hObject;

warning('off','MATLAB:log:logOfZero');

% set(handles.relative,'Value',1);
% set(handles.useLimits,'Value',1);

% Update handles structure
guidata(hObject, handles);

resetQuest(hObject, handles);

handles = guidata(hObject);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using QuestIntuition.
if strcmp(get(hObject,'Visible'),'off')
    [tTest q] = updateDisplay(handles);
    handles.tTest = tTest;
    handles.q = q;
    guidata(hObject, handles);
end



% --- Outputs from this function are returned to the command line.
function varargout = QuestIntuition_OutputFcn(hObject, eventdata, handles)
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

correct = 1;
% [q, tTest] = manualQuestStep(q, correct);
handles.q = QuestUpdate(handles.q, handles.tTest, correct);
tTest = updateDisplay(handles);
handles.tTest = tTest;
guidata(hObject, handles);



% --- Executes on button press in Incorrect.
function Incorrect_Callback(hObject, eventdata, handles)
% hObject    handle to Incorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
correct = 0;
handles.q = QuestUpdate(handles.q, handles.tTest, correct);
tTest = updateDisplay(handles);
handles.tTest = tTest;
guidata(hObject, handles);



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

% Do one simulated run of quest, with the true psychophysical parameters
% set in the various fields
[intensities finalVal] = simulateQuestRun(tActual, upperLimitUnlog, lowerLimitUnlog, handles.q, numTrials);

% Plot the trials for the simulated run
plotQuestRun(intensities, finalVal);


function trueThres_Callback(hObject, eventdata, handles)
% hObject    handle to trueThres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




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

% Simulate multiple quest runs, and plot the distribution of estimates that
% are achieved
runMultipleQuestEstimates(tActual, handles.q, upperLimitUnlog, lowerLimitUnlog, numTrials, numRuns);



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

[tTest q] = updateDisplay(handles);

handles.q = q;
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Reset the quest procedure, by recreating the Quest object.
handles.q = QuestCreate(handles.q.tGuess,handles.q.tGuessSd,handles.q.pThreshold,handles.q.beta,handles.q.delta,handles.q.gamma);
[tTest q] = updateDisplay(handles);
handles.tTest = tTest;
handles.q = q;
guidata(hObject, handles);



function initialGuess_Callback(hObject, eventdata, handles)
% hObject    handle to initialGuess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function initialGuess_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialGuess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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



% --- Executes during object creation, after setting all properties.
function Gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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

resetQuest(hObject, handles);
handles = guidata(hObject);
Reset_Callback(hObject, eventdata, handles);



function numTrials_Callback(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function numTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numRuns_Callback(hObject, eventdata, handles)
% hObject    handle to numRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function numRuns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


