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
% gruen = imread('./gruen.jpg');
% rot = imread('./rot.jpg');
famous = imread('./famous.jpg');
nonfam = imread('./nonfam.jpg');
noise = imread('./noise.jpg');

textureFam = Screen('MakeTexture', myWindow, famous);
textureNon = Screen('MakeTexture', myWindow, nonfam);
textureNoise = Screen('MakeTexture', myWindow, noise)

% textureGruen = Screen('MakeTexture', myWindow, gruen);
% textureRot = Screen('MakeTexture', myWindow, rot);
%Fixationskreuz erstellen.
fixCross = ones(50,50)*255;
fixCross(23:27,:) = 0;
fixCross(:,23:27) = 0;
fixcrossTexture = Screen('MakeTexture', myWindow, fixCross); %Textur für Fixationskreuz definieren

%% Experiments-Anzeige Übung 1
% KeyIsDown = 0;
% timeout = 5;

% for i = 1:5
%     Screen('DrawTexture', myWindow, textureGruen); %grüne Ampel anzeigen
%     Screen('Flip', myWindow);
%     Screen('DrawTexture', myWindow, textureRot); %grüne Ampel anzeigen
%     WaitSecs(randi([1 5]));
%     [~, startRT] = Screen('Flip', myWindow);
%     while (KeyIsDown == 0) && (GetSecs - startRT)<=timeout
%         [KeyIsDown, endRT, KeyCode, ~] = KbCheck();
%         WaitSecs(0.001);
%     end
%     rt(i) = endRT-startRT;
%     KeyIsDown = 0; %reset KeyIsDown

% end

% KbWait;
% Screen('CloseAll');


%use a array where you predefine "random" times in an Array
%Noise macht er mit einem Bild noise.jpg :D
%When Beispiel auf Folien. Immer den letzten Onset-Punkt von einem Flip als Referenzpunkt + vordefinierten Zeitpunkt als "When" nutzen bei Screen('Flip')

%%Experimentsanzeige Übung 2

tPre = 0.5;
tMask = 0.5;
tFace = 0.05;
tINI = 4;

try
    for i = 1:10
        if i==1
            Screen('DrawTexture', myWindow, fixcrossTexture);
            tFixOnset = Screen('Flip', myWindow);
            Screen('DrawTexture', myWindow, textureNoise);
            tNoiseOnset = Screen('Flip', myWindow, tFixOnset+tPre);
            Screen('DrawTexture', myWindow, textureNon);
            tFaceOnset = Screen('Flip', myWindow, tNoiseOnset+tMask);
            tBlankOnset = Screen('Flip', myWindow, tFaceOnset+tFace);
        else
            Screen('DrawTexture', myWindow, fixcrossTexture);
            tFixOnset = Screen('Flip', myWindow, tBlankOnset+tINI);
            Screen('DrawTexture', myWindow, textureNoise);
            tNoiseOnset = Screen('Flip', myWindow, tFixOnset+tPre);
            Screen('DrawTexture', myWindow, textureNon);
            tFaceOnset = Screen('Flip', myWindow, tNoiseOnset+tMask);
            tBlankOnset = Screen('Flip', myWindow, tFaceOnset+tFace);
        end
    end
catch
    KbWait();
    Screen('CloseAll')
end
