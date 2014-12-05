%% -------------Program using matlab to auto record weight result--------
% check if it is working
% --measured by Ohause NVL20000/2 scale----------------------------------
%----written by Chenming Zhang on 10-09-2012------------------------------
% the time interval for output is used by pause command in matlab rather than
% the auto print function from the scale. this is because RS232 has a buffer
% with lots of dataset recorded. if reading the data in the buffer at some 
% interval, there is a risk of have several time step lagging off. the safest
% way would be using the pause command and PV command to obtain the results
% scale preset:
% usb->
%      baud    -> 9600
%      parity  -> 8-none
%      handsh  -> none
%      
%clear all the variables and close all of the opening files
clear all;fclose('all');

% define serial. in windows xp, the number of the series port can be
% found in devmgmt.msc->ports(COM & LPT)->something named USB serial port
% (COM?)
s1=serial('COM9');
%s2=serial('COM11');
s3=serial('COM6');
%s4=serial('COM8');
% open serial port s
         
fopen(s1);
%fopen(s2);
fopen(s3);
%fopen(s4);
% change baud rate as 9600. this can be set by ging to the menu of the
% scale USB->baud. 
% if the semicolumn is supressed, the following output will be shown:
%
%   Serial Port Object : Serial-COM3
%
%   Communication Settings 
%      Port:               COM3
%      BaudRate:           9600
%      Terminator:         'CR'
%
%   Communication State 
%      Status:             open
%      RecordStatus:       off
%
%   Read/Write State  
%      TransferStatus:     idle
%      BytesAvailable:     1
%      ValuesReceived:     3122
%      ValuesSent:         18
%
% Port: portname; Terminator: should be 'CR' or 'CRLF' specified at the
% USB manual;

s1.BaudRate = 9600;   
s1.Terminator = 'CR'; 
s2.BaudRate = 9600;   
s2.Terminator = 'CR'; 
s3.BaudRate = 9600;   
s3.Terminator = 'CR'; 
s4.BaudRate = 9600;   
s4.Terminator = 'CR'; 
%d1 = zeros(10,1) this is used for digits not strings
%get(s,{'OutputBufferSize','BytesToOutput'})


fn=fopen('output.dat','a+');
a=1;
while a<=10000
  for i=1:10
      
%   send command to scale for immediate printing of desplayed weight. this
%   command validates when s.Terminator = 'CR'; all of the other commands
%   can be found from the manual of USB interface kit
    fprintf(s1,'IP');
   % fprintf(s2,'IP');
    fprintf(s3,'IP');
   % fprintf(s4,'IP');
    
    d1(i)= {fscanf(s1)};
 %   d2(i)= {fscanf(s2)};
    d3(i)= {fscanf(s3)};
  %  d4(i)= {fscanf(s4)};
%   print out the result to fn. it is found that the output from scale is
%   in the form of "LF    -55 g    CR", and both LF and CR will restart a
%   new line, which is annoying. to supress this effect, regexprep is used
%   to remove LF(\n) from the string and keep the CR(\r) at the end of the
%   line
 %   fprintf(fn,'%s',datestr(clock,'mm/dd HH:MM:SS'),regexprep(char(d1(i)),'\n',''));
 %   fprintf(fn,'%s',datestr(clock,'mm/dd/yy HH:MM:SS'),regexprep(regexprep(  regexprep(  char(d1(i)),'g','') ,'\n',''),'\r',''),regexprep(regexprep(regexprep(  char(d2(i)),'g',''),'\n',''),'\r',''),...
 %     regexprep(regexprep(  char(d4(i)),'g',''),'\n',''));
%   stop interval, this should be corresponded with the interval of the 
%   scale output
    fprintf(fn,'%s',datestr(clock,'mm/dd/yy HH:MM:SS'),regexprep(regexprep(  regexprep(  char(d1(i)),'g','') ,'\n',''),'\r',''),...
      regexprep(regexprep(  char(d3(i)),'g',''),'\n',''));
    pause(30)
  end
  a=a+1;
  %fprintf(fn,'%g\n',a);
end

%% - to close the serial port, this line of commands has to be executed:--
% fclose(s1);delete(s1);clear s1;clear all;fclose('all');
% fclose(s2);delete(s2);clear s2;clear all;fclose('all');
% fclose(s3);delete(s3);clear s3;clear all;fclose('all');
% fclose(s4);delete(s4);clear s4;clear all;fclose('all');
