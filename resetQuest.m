function handles = resetQuest(hObject, handles)
% handles = resetQuest(hObject, handles)
%
% Restart a QUEST procedure, using the parameters in the dialogue.
%
% INPUT
%  hObject  Pointer to the dialogue
%  handles  Object holding persistent values associated with the dialogue.

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