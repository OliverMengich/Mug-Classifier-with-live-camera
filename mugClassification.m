
negativeImages = fullfile(matlabroot,'toolbox','vision','visiondata',...
    'NonMugs');

trainCascadeObjectDetector('Mugs_11_100%.xml',Mugs1,negativeImages...
    ,'NumCascadeStages'...
    ,11,'FalseAlarmRate',1.0);
detector = vision.CascadeObjectDetector('Mugs.xml');
%% Verify the ideal conditions
image = imread('MugImageTest10.jpg');
image1 = imread('MugImageTest8.jpg');
bbox = step(detector,image);
bbox1 = step(detector,image1);

detected =insertObjectAnnotation(image,'rectangle',bbox,'Coffe Mug');
detected1= insertObjectAnnotation(image1,'rectangle',bbox1,'Coffe');

figure; %subplot(1,2,1);
imshow(detected);
%subplot(1,2,2);
%imshow(detected1);

%% Now to test the detector with a live image acquisition
camera = webcam;
videoplayer = vision.DeployableVideoPlayer();
 while true

  image = camera.snapshot;
  boundingbox = step(detector,image);

detectedImage = insertObjectAnnotation(image,'rectangle',boundingbox,'Coffe Mug');
 step(videoplayer,detectedImage); 
 end
 
