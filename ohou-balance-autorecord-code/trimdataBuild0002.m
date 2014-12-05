%% intro
% this script cutout the redundant data in scale csv
%write by chenming at 2013/1/28
clear all
fclose('all');
str = fileread('bftrim.dat');               %# read contents of file into string
str = strrep(str, '?', ' ');        %# Replace wordA with wordB

fid = fopen('bftrim2.dat', 'w');
fwrite(fid, str, '*char');              %# write characters (bytes)
fclose(fid);
 fprintf(1,'betrim2.dat created with no ? \n');
%% ---------read file---------------
scale=importdata('bftrim2.dat');
%% read scale.csv
% (W)eight from (6)0cm (C)olumn
w6c=scale.data(:,1);
% (W)eight from (6)0cm (M)ariott bottle
w6m=scale.data(:,2);
% (W)eight from (6)0cm (C)olumn
w9c=scale.data(:,3);
% (W)eight from (6)0cm (M)ariott bottle
w9m=scale.data(:,4);
% (D)ate and (T)ime for (S)cale stored by (S)tring
dtss=scale.textdata(1:size(scale.textdata,1),1);
% (D)ate and (T)ime for (S)cale stored by (D)igits
dtsd=datenum(dtss,'yyyy/mmm/dd HH:MM:SS');
% (N)umber of (R)eadings at (S)cale
nrs=size(dtsd,1);
fn=fopen('aftertrim.dat','w');

w6ct=w6c(1);w6mt=w6m(1);w9ct=w9c(1);w9mt=w9m(1);
for i=2:nrs
    if (w6c(i)~=w6ct || w6m(i)~=w6mt || w9c(i)~=w9ct || w9m(i)~=w9mt)
fprintf(fn,'%s','"',datestr(dtsd(i),'yyyy/mmm/dd HH:MM:SS'),'",',num2str(w6c(i)),',',num2str(w6m(i)),',',num2str(w9c(i)),',',num2str(w9m(i)));fprintf(fn,'\n');
    w6ct=w6c(i);w6mt=w6m(i);w9ct=w9c(i);w9mt=w9m(i);
    end
end
 fprintf(1,'JOB COMPLETE \n');
