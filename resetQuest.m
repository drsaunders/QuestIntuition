function handles = resetQuest(hObject, handles)

initialGuess = get(handles.initialGuess,'String');
tGuess = log10(str2num(initialGuess) / str2num(get(handles.upperLimitUnlog,'String')));
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