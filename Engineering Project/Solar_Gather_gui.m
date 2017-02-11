function varargout = Solar_Gather_gui(varargin)
% SOLAR_GATHER_GUI MATLAB code for Solar_Gather_gui.fig
%      SOLAR_GATHER_GUI, by itself, creates a new SOLAR_GATHER_GUI or raises the existing
%      singleton*.
%
%      H = SOLAR_GATHER_GUI returns the handle to a new SOLAR_GATHER_GUI or the handle to
%      the existing singleton*.
%
%      SOLAR_GATHER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOLAR_GATHER_GUI.M with the given input arguments.
%
%      SOLAR_GATHER_GUI('Property','Value',...) creates a new SOLAR_GATHER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Solar_Gather_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Solar_Gather_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Solar_Gather_gui

% Last Modified by GUIDE v2.5 17-Mar-2013 14:35:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Solar_Gather_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Solar_Gather_gui_OutputFcn, ...
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


% --- Executes just before Solar_Gather_gui is made visible.
function Solar_Gather_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Solar_Gather_gui (see VARARGIN)
global TRIAL %set the 'run' object to be a global object 
TRIAL=trial;%set the 'run' object equal to trial
global ALL_TRIALS
ALL_TRIALS={};%this will be structure in which all the run variables are stored
%solar_cell_dat in this variable

% Choose default command line output for Solar_Gather_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Solar_Gather_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Solar_Gather_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure

varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TRIAL;%make 'run' the object which contains the class 'trial'
global COM_STRING
COM_STRING=get(handles.com,'String');
%--Load Sweep Script
set(handles.message,'String','Data acquisition in progress…');
arduino_obj = arduino(COM_STRING);
solar_cell_dat_load=ones(1,255);%Preallocate for speed
for i=1:256;
arduino_obj.pWrite(0,i-1);
arduino_obj.pWrite(1,128);
    data_point = arduino_obj.analogRead(0);
    data_voltage = data_point*5/1024;
    solar_cell_dat_load(i) = data_voltage;
    
end
disp('Data acquisition complete! Choose next time of day.')
%delete(arduino_obj);
%---Load Sweep Script ended

%Toggle Time buttons incorporation (Time of day specification)
if get(handles.morning,'Value')==1
    TRIAL.morning_load=solar_cell_dat_load;%if what the user types in matches 
    %morning, than the store the vector 'solar_cell_dat' into the 'morning
    %data property of the object 'run'
elseif get(handles.noon,'Value')==1
    TRIAL.noon_load=solar_cell_dat_load;%similar process as above
elseif get(handles.late_afternoon,'Value')==1
    TRIAL.late_afternoon_load=solar_cell_dat_load;%similar process as above
end
%---End of the time of day specification
    

delete(arduino_obj);
set(handles.message,'String','Remove the open circuit jumper and click here to continue.')

if waitforbuttonpress==0
    %---Open Circuit Script
set(handles.message,'String','Data acquistion in progress…');
arduino_obj = arduino(COM_STRING);

arduino_obj.pWrite(-1,255);
solar_cell_dat_open=ones(1,256);%Preallocate for speed


for n=1:256
    data_point = arduino_obj.analogRead(0);
    data_voltage_open = data_point*5/1024;
    solar_cell_dat_open(n) = data_voltage_open;
    
    
end
 set(handles.message,'String','Data acquisition complete! Choose next time of day.')

%--open circuit script end

%Radio Button Group (Time of day specification)
if get(handles.morning,'Value')==1
    TRIAL.morning_open=solar_cell_dat_open;%if what the user types in matches 
    %morning, than the store the vector 'solar_cell_dat' into the 'morning
    %data property of the object 'run'
elseif get(handles.noon,'Value')==1
    TRIAL.noon_open=solar_cell_dat_open;%similar process as above
elseif get(handles.late_afternoon,'Value')==1
    TRIAL.late_afternoon_open=solar_cell_dat_open;%similar process as above
end
%---End of the time of day specification

%---Export Variables to the workspace

end
    
    

%--Arduino Script ended
    


    



function date_text_Callback(hObject, eventdata, handles)
% hObject    handle to date_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of date_text as text
%        str2double(get(hObject,'String')) returns contents of date_text as a double


% --- Executes during object creation, after setting all properties.
function date_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to date_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in map_button.
function map_button_Callback(hObject, eventdata, handles)
% hObject    handle to map_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TRIAL;
map=openfig('Map.fig');%open the UC Davis campus Map
[x_coordinate, y_coordinate]=ginput2(1);
coordinates=[x_coordinate, y_coordinate];
TRIAL.location_coordinates=coordinates;
pause(0.5);
close(map);

    





function time_of_day_Callback(hObject, eventdata, handles)
% hObject    handle to time_of_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_of_day as text
%        str2double(get(hObject,'String')) returns contents of time_of_day as a double


% --- Executes during object creation, after setting all properties.
function time_of_day_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_of_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in store_trial.
function store_trial_Callback(hObject, eventdata, handles)
% hObject    handle to store_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2double(get(handles.trial_number,'String'));%this will be the trial number index
global TRIAL;
%--Trial property: Date
TRIAL.date=get(handles.date_text,'String');%obtain the user input from the date edit box

%--Trial Property: Location Name
TRIAL.location_name=get(handles.location_name,'String');
%--Store a specific instance of TRIAL into structure called ALL_TRIALS
global ALL_TRIALS;
ALL_TRIALS{n}=TRIAL;




function location_name_Callback(hObject, eventdata, handles)
% hObject    handle to location_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of location_name as text
%        str2double(get(hObject,'String')) returns contents of location_name as a double


% --- Executes during object creation, after setting all properties.
function location_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to location_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trial_number_Callback(hObject, eventdata, handles)
% hObject    handle to trial_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trial_number as text
%        str2double(get(hObject,'String')) returns contents of trial_number as a double


% --- Executes during object creation, after setting all properties.
function trial_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trial_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in plot_interface.
function plot_interface_Callback(hObject, eventdata, handles)
% hObject    handle to plot_interface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Plots
 
