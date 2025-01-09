load handel.mat

filename = 'handel.wav';

audiowrite(filename,y,Fs);
clear y Fs

[wavedata freq] = audioread(filename);

InitializePsychSound(1);

pahandle = PsychPortAudio('Open', [], [], 1, freq, 1, 0);

PsychPortAudio('FillBuffer', pahandle, wavedata');

repitions=5;

PsychPortAudio('Start', pahandle, repitions, 0);

WaitSecs(20);

PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle)


%anschauen von randperm!

MakeBeep(500,2)