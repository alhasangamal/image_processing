function varargout = fig2(varargin)
% FIG2 MATLAB code for fig2.fig
%      FIG2, by itself, creates a new FIG2 or raises the existing
%      singleton*.
%
%      H = FIG2 returns the handle to a new FIG2 or the handle to
%      the existing singleton*.
%
%      FIG2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIG2.M with the given input arguments.
%
%      FIG2('Property','Value',...) creates a new FIG2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fig2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fig2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fig2

% Last Modified by GUIDE v2.5 16-Dec-2019 20:06:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fig2_OpeningFcn, ...
                   'gui_OutputFcn',  @fig2_OutputFcn, ...
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


% --- Executes just before fig2 is made visible.
function fig2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fig2 (see VARARGIN)

% Choose default command line output for from
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('colors.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes fig2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fig2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[a b]=uigetfile({'*.*','All Files'});
comp = strcat(b,a);
set(handles.edit1,'string',comp);
img=imread([b a]);
imshow(img,'parent',handles.axes1);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');
else
    state=get(handles.uibuttongroup1,'selectedobject');
    selc=get(state,'string');
    switch (selc)
        case 'Rgb 2 Binary'
            I=imread(a);
            x=rgbTobinary ( I , 127 );
            imshow(x,'parent',handles.axes2);
        case 'Rgb 2 Gray'
            I=imread(a);
            x=rgbTogray(I);
            imshow(x,'parent',handles.axes2);
        case 'Gray 2 Binary'
            I=imread(a);
            x=grayTobinary ( I , 127 );
            imshow(x,'parent',handles.axes2);
        case 'Brightness'
            I=imread(a);
            [w h l]=size(I);
            op= get(handles.edit2,'String');
            e5= get(handles.edit3,'String');
            if isempty(op) || isempty(e5)
                msgbox({'Invalid' 'please fall empty space'}, 'Error','error');  
            else
                off=str2num(e5);
                if l==3
                    NR=RGBbright( I , op , off );
                    imshow(NR,'parent',handles.axes2);
                else
                     NG=graybright( I , op , off );
                     imshow(NG,'parent',handles.axes2);
                end
            end
        case 'Contrast Streching'
            s= get(handles.edit2,'String');
            if isempty(s)  
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                n=str2num(s);
                I=imread(a);
                x=contrast(I,n);
                imshow(x,'parent',handles.axes2);
            end
        case 'Histogram'
            I=imread(a);
            [w h l]=size(I);
            if l==3
                [r g b]=hist(I);
                % mybutton = uicontrol;
                % set(mybutton,'Visible','off');
                fig3;
                subplot(3,1,1);bar(r,'r');
                subplot(3,1,2);bar(g,'g');
                subplot(3,1,3);bar(b,'b');
                %bar(ni,'parent',handles.axes2);
                % subplot(3,1,2);bar(g,'parent',handles.axes2),title('green');
                % subplot(3,1,3);bar(b,'parent',handles.axes2),title('blue');
                %bar(r,'parent',handles.axes2);
            else
                [r2]=hist(I);
                %disp('2');
                bar(r2,'parent',handles.axes2);
            end
        case 'Histogram Equalization'
            I=imread(a);
            his_eq(I);
        case 'Log'
            I=imread(a);
            NG=Log(I);
            imshow(NG,'parent',handles.axes2);
        case 'Gamma'
            I=imread(a);
            e2= get(handles.edit2,'String');
            if isempty(e2)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                g=str2num(e2);
                NG=Gama(I,g );
                imshow(NG,'parent',handles.axes2);
            end
        case 'Negitive'
            I=imread(a);
            [w h l]=size(I);
            isBinaryImage = all( I(:)==0 | I(:)==1);
            if l==3
                NR=negative_rgb( I );
                imshow(NR,'parent',handles.axes2);
            elseif isBinaryImage==1
                NB=negative_binary( I );
                imshow(NB,'parent',handles.axes2);
            elseif l==1 && isBinaryImage==0
                NG=negative_gray( I );
                imshow(NG,'parent',handles.axes2);
            end
        case 'Bluring'
            I=imread(a);
            s=get(handles.edit2,'string');
            switch (s)   
                case 'w'
                    N=Weight(I);
                    imshow(N,'parent',handles.axes2);
                case 'm'
                    N=Mean(I);
                    imshow(N,'parent',handles.axes2);
            end
        case'Sharping'
            I=imread(a);
            f= get(handles.edit2,'string') ;
            if f=='p'
                 N=point_sharp(I);
                 imshow(N,'parent',handles.axes2);
            end
            if f=='l'
                 switch get(handles.edit3,'string')   
                    case 'v'
                        N=line_sharp(I,'V');
                        imshow(N,'parent',handles.axes2);
                    case 'h'
                         N=line_sharp(I,'H');
                         imshow(N,'parent',handles.axes2);
                    case 'dr'
                         N=line_sharp(I,'DR');
                         imshow(N,'parent',handles.axes2);
                    case 'dl'
                        N=line_sharp(I,'DL');
                        imshow(N,'parent',handles.axes2);
                 end
            end
        case 'Edge Detection'
            I=imread(a);
            f= get(handles.edit2,'string') ;
            if f=='p'
                N=point_edge(I);
                imshow(N,'parent',handles.axes2);
            end
            if f=='l'
                switch get(handles.edit3,'string')   
                    case 'v'
                      N=line_edge(I,'V');
                      imshow(N,'parent',handles.axes2);
                    case 'h'
                      N=line_edge(I,'H');
                      imshow(N,'parent',handles.axes2);
                    case 'dr'
                      N=line_edge(I,'DR');
                      imshow(N,'parent',handles.axes2);
                    case 'dl'
                      N=line_edge(I,'DL');
                      imshow(N,'parent',handles.axes2);
                end
            end
        case 'Linear'
            I=imread(a);
            e2= get(handles.edit2,'String');
            if isempty(e2)  
                msgbox({'Invalid' 'please enter your mask'}, 'Error','error');  
            else
                mask=str2num(e2);
                N=linear_filter(I,mask);
                imshow(N,'parent',handles.axes2);
            end
        case 'Min'
            I=imread(a) ;
            mask_w1 = get(handles.edit2,'String');
            mask_h1 = get(handles.edit3,'String');
            if isempty(mask_w1)  || isempty(mask_h1)
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                mask_w=str2num(mask_w1);
                mask_h=str2num(mask_h1);
                N=NonlinearMinFilter( I,mask_h,mask_w);
                imshow(N,'parent',handles.axes2);
            end
        case 'Max'
            I=imread(a) ;
            mask_w1 = get(handles.edit2,'String');
            mask_h1 = get(handles.edit3,'String');
            if isempty(mask_w1)  | isempty(mask_h1)
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                mask_w=str2num(mask_w1);
                mask_h=str2num(mask_h1);
                N=NonlinearMaxFilter( I,mask_h,mask_w);
                imshow(N,'parent',handles.axes2);
            end
        case 'Median'
            I=imread(a) ;
            mask_w1 = get(handles.edit2,'String');
            mask_h1 = get(handles.edit3,'String');
            if isempty(mask_w1)  | isempty(mask_h1)
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                mask_w=str2num(mask_w1);
                mask_h=str2num(mask_h1);
                N= NonlinearMedianFilter( I,mask_h,mask_w);
                imshow(N,'parent',handles.axes2);
            end
        case 'Mid Point'
            I=imread(a) ;
            mask_w1 = get(handles.edit2,'String');
            mask_h1 = get(handles.edit3,'String');
            if isempty(mask_w1)  | isempty(mask_h1)
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                mask_w=str2num(mask_w1);
                mask_h=str2num(mask_h1);
                N= NonlinearMidFilter( I,mask_h,mask_w);
                imshow(N,'parent',handles.axes2);
            end
        case 'Geometeric'
            I=imread(a) ;
            mask_w1 = get(handles.edit2,'String');
            mask_h1 = get(handles.edit3,'String');
            if isempty(mask_w1)  | isempty(mask_h1)
                msgbox({'Invalid' 'please fall space'}, 'Error','error');  
            else
                mask_w=str2num(mask_w1);
                mask_h=str2num(mask_h1);
                N= NonlinearGeometricFilter( I,mask_h,mask_w);
                imshow(N,'parent',handles.axes2);
            end
        case 'Fourier'
            I=imread(a);
            [w h l]=size(I);
            if l==3
                %    [ image new_image new_image1 y ]=
                fourier_transfomation_rgb( I );
                %     subplot(2,2,1);imshow(image,'parent',handles.axes2);
                %     subplot(2,2,2);imshow(new_image,'parent',handles.axes2);
                %     subplot(2,2,3);imshow(new_image1,'parent',handles.axes2);
                %     subplot(2,2,4);imshow(y,'parent',handles.axes2);
            elseif l==1 
                %   [ image new_image new_image1 y ]=
                fourier_transfomation_gray( I );
                %     subplot(2,2,1);imshow(image,'parent',handles.axes2);
                %     subplot(2,2,2);imshow(new_image,'parent',handles.axes2);
                %     subplot(2,2,3);imshow(new_image1,'parent',handles.axes2);
                %     subplot(2,2,4);imshow(y,'parent',handles.axes2)
            end
        case 'Ideal Pass Filter'
            I=imread(a);
            e5= get(handles.edit3,'String');
            if isempty(e5)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                d0=str2num(e5);
                [w h l]=size(I);
                if l==1
                    switch get(handles.edit2,'string')  
                        case 'l'
                             % disp('1');
                             N=ilpf( I,d0);
                             imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=ihpf( I,d0 );
                            imshow(N,'parent',handles.axes2);
                    end
                else
                    switch get(handles.edit2,'Value')  
                        case 'l'
                            N=ilpf_RGB( I,d0 );
                            imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=ihpf_RGB( I,d0 );
                            imshow(N,'parent',handles.axes2);
                    end
                end
            end
        case 'Guassin'
            I=imread(a);
            e5= get(handles.edit3,'String');
            if isempty(e5)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                d0=str2num(e5);
                [w h l]=size(I);
                if l==1
                    switch get(handles.edit2,'string')  
                        case 'l'
                             % disp('1');
                             N=gaussian_low( I,d0);
                             imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=gaussian_high( I,d0 );
                            imshow(N,'parent',handles.axes2);
                    end
                else
                    switch get(handles.edit2,'Value')  
                        case 'l'
                            N=gaussian_l_RGB( I,d0 );
                            imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=gaussian_h_RGB( I,d0 );
                            imshow(N,'parent',handles.axes2);
                    end
                end
            end
        case 'Butterworth'
            I=imread(a);
            e4= get(handles.edit3,'String');
            e3= get(handles.edit5,'String');
            if isempty(e4)  || isempty(e3) 
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                d0=str2num(e4);
                n=str2num(e3);
                [w h l]=size(I);
                if l==1
                    switch get(handles.edit2,'string')  
                        case 'l'
                             % disp('1');
                             N=butterworth_low( I,d0,n);
                             imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=butterworth_high( I,d0,n);
                            imshow(N,'parent',handles.axes2);
                    end
                else
                    switch get(handles.edit2,'Value')  
                        case 'l'
                            N=butterworth_l_RGB( I,d0 ,n);
                            imshow(N,'parent',handles.axes2);
                        case 'h'
                            N=butterworth_h_RGB( I,d0 ,n);
                            imshow(N,'parent',handles.axes2);
                    end
                end
            end
        case 'Salt&Papper'
            I=imread(a);
            e2= get(handles.edit3,'String');
            if isempty(e2)  
                msgbox({'Invalid' 'please enter type value'}, 'Error','error');  
            else
                s=str2num(e2);
                switch get(handles.edit2,'string')  
                    case 's'
                        N=saltnoise(I,s);
                        imshow(N,'parent',handles.axes2);
                    case 'p'
                        N=Peppernoise(I,s);
                        imshow(N,'parent',handles.axes2);
                end
            end
        case 'Uniform'
            I=imread(a);
            e3= get(handles.edit2,'String');
            e4= get(handles.edit3,'String');
            if isempty(e3) | isempty(e4) 
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                s=str2num(e3);
                [a]=str2num(e4);
                % disp(a(1));
                % disp(a(2));
                N=uniformNoise( I,s,a(1),a(2));
                % N=Peppernoise(I,s);
                imshow(N,'parent',handles.axes2);
            end
        case 'Gaussian'
            I=imread(a);
            e7= get(handles.edit2,'String');
            e8= get(handles.edit3,'String');
            if isempty(e7) || isempty(e8) 
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                s=str2num(e7);
                [a]=str2num(e8);
                % disp(a(1));
                % disp(a(2));
                %range M & Segma
                N=gaussianNoise( I,s,a(1),a(2));
                % N=Peppernoise(I,s);
                imshow(N,'parent',handles.axes2);
            end
        case 'Rayligh'
            I=imread(a);
            e9= get(handles.edit2,'String');
            if isempty(e9)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                [a]=str2num(e9);
                % disp(a(1));
                % disp(a(2));
                %range M & Segma
                N=rayligh_noise( I,a(1),a(2));
                % N=Peppernoise(I,s);
                imshow(N,'parent',handles.axes2);
            end
        case 'Exponentiel'
            I=imread(a);
            e10= get(handles.edit2,'String');
            if isempty(e10)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                a=str2num(e10);
                % disp(a(1));
                % disp(a(2));
                %range M & Segma
                N=exp_noise(I,a);
                % N=Peppernoise(I,s);
                imshow(N,'parent',handles.axes2);
            end
        case 'Gamma_Noise'
            I=imread(a);
            e11= get(handles.edit2,'String');
            if isempty(e11)  
                msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
            else
                [a]=str2num(e11);
                % disp(a(1));
                % disp(a(2));
                %range M & Segma
                N=gamma_noise(I,a(1),a(2));
                % N=Peppernoise(I,s);
                imshow(N,'parent',handles.axes2);
end
        
            
    end
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state=get(handles.uibuttongroup1,'selectedobject');
selc=get(state,'string');
switch (selc)
    case 'Rgb 2 Binary'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Rgb 2 Gray'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Gray 2 Binary'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Brightness'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Operator');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Offset');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Contrast Streching'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Number of bits');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Histogram'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Histogram Equalization'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Log'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Gamma'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Gamma Value');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Negitive'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
    case 'Bluring'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Sharping'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Type');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case'Edge Detection'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Type');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Linear'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
    case 'Min'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask Width');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Mask Hight');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Max'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask Width');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Mask Hight');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Median'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask Width');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Mask Hight');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Mid Point'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask Width');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Mask Hight');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Geometeric'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Mask Width');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Mask Hight');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Fourier'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'off');
        set(handles.edit2,'visible' ,'off');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Ideal Pass Filter'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'D0');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Guassin'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'D0');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Butterworth'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'D0');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'on');
        set(handles.text12,'string' ,'N');
        set(handles.edit5,'visible' ,'on');
        set(handles.edit3,'string' ,'');
    case 'Salt&Papper'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Type');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Rate');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Uniform'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Rate');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Range');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Gaussian'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Rate');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'on');
        set(handles.text11,'string' ,'Range');
        set(handles.edit3,'visible' ,'on');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Rayligh'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Range');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Exponentiel'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'exp_value');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
    case 'Gamma_Noise'
        set(handles.text9,'string',selc);
        set(handles.text10,'visible' ,'on');
        set(handles.text10,'string' ,'Gamma_range');
        set(handles.edit2,'visible' ,'on');
        set(handles.edit2,'string' ,'');
        set(handles.text11,'visible' ,'off');
        set(handles.edit3,'visible' ,'off');
        set(handles.edit3,'string' ,'');
        set(handles.text12,'visible' ,'off');
        set(handles.edit5,'visible' ,'off');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
