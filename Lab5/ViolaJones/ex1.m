function [] = ex1(filename)

ConvertHaarcasadeXMLOpenCV('HaarCascades/haarcascade_frontalface_alt.xml');
Options = struct();
Options.Resize=false ;
Objects=ObjectDetection ( filename , 'HaarCascades/haarcascade_frontalface_alt.mat',Options);
I = imread(filename); ShowDetectionResult(I,Objects);    

end