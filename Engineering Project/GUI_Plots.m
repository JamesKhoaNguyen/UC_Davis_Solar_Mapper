function varargout = GUI_Plots(varargin)
% GUI_PLOTS MATLAB code for GUI_Plots.fig
%      GUI_PLOTS, by itself, creates a new GUI_PLOTS or raises the existing
%      singleton*.
%
%      H = GUI_PLOTS returns the handle to a new GUI_PLOTS or the handle to
%      the existing singleton*.
%
%      GUI_PLOTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLOTS.M with the given input arguments.
%
%      GUI_PLOTS('Property','Value',...) creates a new GUI_PLOTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Plots_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Plots_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Plots

% Last Modified by GUIDE v2.5 08-Mar-2013 13:03:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Plots_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Plots_OutputFcn, ...
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

% --- Executes just before GUI_Plots is made visible.
function GUI_Plots_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for GUI_Plots
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI_Plots.


% UIWAIT makes GUI_Plots wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Plots_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Update.
function Update_Callback(hObject, eventdata, handles)
% hObject    handle to Update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global TRIAL
global ALL_TRIALS
%load('ALL_TRIALS_3.mat')
%global ALL_TRIALS


        
    
    %Code for button groups (selecting which data to plot)
    rawdata=get(handles.rawdata,'Value');
    averagedata=get(handles.averagedata,'Value');
    voltagebutton=get(handles.voltage,'Value');
    maxbutton=get(handles.maxpower,'Value');
    
    figure(1);
    if maxbutton==1
        res_code=0:255;
        resistance=60 + res_code.*43;
        if averagedata==1
            
            trial_morning=[];
            trial_noon=[];
            trial_late_afternoon=[];
            for n=1:length(ALL_TRIALS);
           trial_morning(n)=max(((ALL_TRIALS{n}.morning_load).^2)./resistance);
           trial_noon(n)=max(((ALL_TRIALS{n}.noon_load).^2)./resistance);
           trial_late_afternoon(n)=max(((ALL_TRIALS{n}.late_afternoon_load).^2)./resistance);
            end
            
            plot_data=(trial_morning+trial_noon+trial_late_afternoon)./3;
            %Interpolation of Values
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            z=plot_data;%We multiply by 65 because our data is very close together, we get 
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
           caxis([min(plot_data), max(plot_data)]);
            colorbar;
            
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Average Power');
            legend(' Interpolated Power','Survey Location','Location','SouthEast');
            hold off;
            
        elseif rawdata==1%button pressed
            
           
        
        trial_morning=[];
            trial_noon=[];
            trial_late_afternoon=[];
            for n=1:length(ALL_TRIALS);
           trial_morning(n)=max(((ALL_TRIALS{n}.morning_load).^2)./resistance);
           trial_noon(n)=max(((ALL_TRIALS{n}.noon_load).^2)./resistance);
           trial_late_afternoon(n)=max(((ALL_TRIALS{n}.late_afternoon_load).^2)./resistance);
            end
            plot_data_morning=trial_morning;
             plot_data_noon=trial_noon;
              plot_data_late_afternoon=trial_late_afternoon;
            
            
           %Interpolation of Morning
           figure(1);
           plot_data=trial_morning;
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            z=plot_data; %Instead of multiplying by 255, we manually change the axis using caxis to yeild better differentiation of color in out map
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data_morning), max(plot_data_morning)]);
            colorbar,
           
            
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Morning Power');
            legend(' Interpolated Power','Survey Location','Location','SouthEast');
            hold off;
        
        
        
            
            %Interpolation of Noon
            figure(2);
            plot_data=trial_noon;
            
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            z=plot_data;
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data_noon), max(plot_data_noon)]);
            colorbar,
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Noon Power');
            legend(' Interpolated Power','Survey Location','Location','SouthEast');
            hold off;
            
            
            
            %Interpolation of Late Afternoon
            figure(3);
            plot_data=trial_late_afternoon;
            
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            z=plot_data;
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data_late_afternoon), max(plot_data_late_afternoon)]);
            colorbar,
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Late Afternoon Power');
            legend(' Interpolated Power','Survey Location','Location','SouthEast');
            hold off;
            
            
        
        end
        
        
        
    elseif voltagebutton==1%button pressed
        if rawdata==1;
          
            trial_morning=[];
            trial_noon=[];
            trial_late_afternoon=[];
          for n=1:length(ALL_TRIALS);
           trial_morning(n)=mean(ALL_TRIALS{n}.morning_open);
           trial_noon(n)=mean(ALL_TRIALS{n}.noon_open);
           trial_late_afternoon(n)=mean(ALL_TRIALS{n}.late_afternoon_open);
          end
          
          plot_data_morning=trial_morning;
          plot_data_noon=trial_noon;
          plot_data_late_afternoon=trial_late_afternoon;
          
         %Interpolation of Morning
         figure(1);
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end
            

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            
            z_morning=plot_data_morning;
            F_morning=TriScatteredInterp(x,y,z_morning');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz_morning=F_morning(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold on;
            contour(qx,qy,qz_morning,'linewidth',2.5);%makes a contour plot for the interpolated data
           caxis([min(plot_data_morning), max(plot_data_morning)]);
            colorbar;
            hold on;
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Morning Voltage');
            legend(' Interpolated Voltage','Survey Location','Location','SouthEast');
            hold off;
            
            figure(2);
            %Interpolation of noon
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end
            

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            
            z=plot_data_noon;
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data_noon), max(plot_data_noon)]);
            colorbar,
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Noon Voltage');
            legend(' Interpolated Voltage','Survey Location','Location','SouthEast')
            hold off;
            
            
            figure(3);
            %Interpolation of Late Afternoon
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end
            

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            
            z=plot_data_late_afternoon;
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data_late_afternoon), max(plot_data_late_afternoon)]);
            colorbar;
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Late Afternoon Voltage');
            legend(' Interpolated Voltage','Survey Location','Location','SouthEast');
            hold off;
            
            
        
    

         elseif averagedata==1;
          
          plot_data=[]; 
           for n=1:length(ALL_TRIALS);
           trial_morning=ALL_TRIALS{n}.morning_open;
           trial_noon=ALL_TRIALS{n}.noon_open;
           trial_late_afternoon=ALL_TRIALS{n}.late_afternoon_open;
           plot_data(n)=(mean(trial_morning(n))+mean(trial_noon(n))+mean(trial_late_afternoon(n)))./3;
           end
           
           figure(1);
           %Interpolation of Values
           i=imread('campus_map.jpg');
           imshow(i);
           %coordinate_matrix=ones((length(ALL_TRIALS)),2)

            for n=1:length(ALL_TRIALS);
            trial=ALL_TRIALS{n};
            coordinate_matrix(n,:)=trial.location_coordinates;
            end

            %average solar value at each point(x,y) **average of 256 open voltage points**
            x=(coordinate_matrix(:,1));
            y=(coordinate_matrix(:,2));
            z=plot_data;%We multiply by 65 because our data is very close together, we get 
            F=TriScatteredInterp(x,y,z');%interpolates values in x-y plane given values of data
            vector1=0:10:1933;%width of map
            vector2=0:10:1668;%height of map
            [qx,qy]=meshgrid(vector1,vector2);%sets mesh for interpolation
            qz=F(qx,qy);%gets interpolated values from xy-coordinates
            
            
            hold on;
            contour(qx,qy,qz,'linewidth',2.5);%makes a contour plot for the interpolated data
            caxis([min(plot_data), max(plot_data)]),
            colorbar,
           
            plot(x,y,'k.','linewidth',5);%plots the coordinates of the original data
            title('Average Voltage');
            legend(' Interpolated Voltage','Survey Location','Location','SouthEast')
            hold off;
      end
    end
    
       
   

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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Contour',  'Bar Graph (Output Given Time) ', 'Resistance vs. Output'});
