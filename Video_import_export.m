%MAY ONLY WORK ON WINDOWS!!!

clear all
clc

% Check that script is running on Windows due to Codec problems. Matlab can
% read avi files only on windows
if ispc ~= 1
    error('Video Cutting due to codec problems only on Windows machines')
end

%%

% Prepare Input File
inputName = "test.avi";
vfr = vision.VideoFileReader(inputName, 'AudioOutputPort',true);

% Create Output files
outputName = "out.mp4";
vfw = vision.VideoFileWriter(outputName, 'FileFormat','MPEG4', 'AudioInputPort',true,'FrameRate',vfr.info.VideoFrameRate);
%vfw{j}.VideoCompressor='MJPEG Compressor';

% Write to Output Files
%img for counting frames
img = 1;
while ~isDone(vfr)
    [frame, audio] = step(vfr);
  
    step(vfw,frame, audio);

    img = img + 1;
end

clear img frame audio

% Release Input and Output Files
release(vfr);
release(vfw);
