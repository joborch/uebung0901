%Working Directory setzen
currentFilePath = mfilename('fullpath'); %speichern vom Pfad der genutzten Datei
[currentFolderPath, ~, ~] = fileparts(currentFilePath); %rausspeichern vom Ordner-Pfad 
cd(currentFolderPath); %Aktuelles Working Directory setzen!

%% Definition der Gerätespezifika

myScreen = 0; %Define Screen

white  = WhiteIndex(myScreen); %Color Index White
black = BlackIndex(myScreen); %Color Index Black
gray = (white+black)/2; %Color Index Gray

color = white; %Definition of Color for myWindow

[width, height] = Screen('WindowSize', myScreen); %Reads indivdual Screen Size
ratioFactor = 0.75; %Factor for Screen: 1 is Fullscreen

ratio = [0 0 width*ratioFactor height*ratioFactor]; %Definition of Ratio for myWindow

myWindow = Screen('OpenWindow', myScreen, color, ratio);

%% Einlesen der Bilder
gruen = imread('./gruen.jpg');
rot = imread('./rot.jpg');

textureGruen = Screen('MakeTexture', myWindow, gruen);
textureRot = Screen('MakeTexture', myWindow, rot);
%Fixationskreuz erstellen.
fixCross = ones(50,50)*255;
fixCross(23:27,:) = 0;
fixCross(:,23:27) = 0;
fixcrossTexture = Screen('MakeTexture', myWindow, fixCross); %Textur für Fixationskreuz definieren

%% Experiments-Anzeige
KeyIsDown = 0;
timeout = 5;

for i = 1:5
    Screen('DrawTexture', myWindow, textureGruen); %grüne Ampel anzeigen
    Screen('Flip', myWindow);
    Screen('DrawTexture', myWindow, textureRot); %grüne Ampel anzeigen
    WaitSecs(randi([1 5]));
    [~, startRT] = Screen('Flip', myWindow);
    while (KeyIsDown == 0) && (GetSecs - startRT)<=timeout
        [KeyIsDown, endRT, KeyCode, ~] = KbCheck();
        WaitSecs(0.001);
    end
    rt(i) = endRT-startRT;
    KeyIsDown = 0; %reset KeyIsDown

end

KbWait;
Screen('CloseAll');