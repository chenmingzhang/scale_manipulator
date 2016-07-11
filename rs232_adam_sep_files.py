# this script records scale readings from adam gfk 600
import serial
import time
import datetime
import numpy as np

ser = serial.Serial('/dev/ttyUSB0')
no_of_readings=60000  # totally how many readings will be done
sleep_time_seconds=10 # the interval of neighbouring reading
separator=' , '  # the string to separate the results
print_cmd='w\n\r'  # the command to print from the scale.
   # ohaus nvl20000 instant result ------ 'IP\n\r'
   # ohaus nvl20000 stable result  ------ 'P\n\r'
   # ohaus ranger   same as nvl20000
   # adam scales                   ------ 'w\n\r'
temp=["" for x in range(no_of_readings)]
reading_scale=["" for x in range(no_of_readings)]
#reading_scale=np.arange(no_of_readings,dtype=float)
reading_stable=np.arange(no_of_readings,dtype=int)
reading_time =["" for x in range(no_of_readings)]

file_name_today=datetime.date.today().strftime('%Y_%b_%d')
# the '0' at the end of the script helps save instantly.
# http://stackoverflow.com/questions/18984092/python-2-7-wr

fid= open('scale_'+file_name_today+'.dat','a',0)
ser.write(print_cmd)
ser.readline()

for n in range(0, no_of_readings-1):
    ser.write(print_cmd)
    tem=ser.readline()
    # usually the result looks like '2110 g' when it is stable
    # while it is '2010 ' when it is not stable
    tmp=tem.split()
    reading_scale[n]=tmp[0]
    if len(tmp)==2:
        if tmp[1]=='g':
            reading_stable[n]=1
        else:
            reading_stable[n]=0
    else:
        reading_stable[n]=0

    fid.write(time.strftime("%d/%b/%Y %H:%M:%S")+separator
    +reading_scale[n]+separator+str(reading_stable[n])+'\n')

    time.sleep(sleep_time_seconds)


fid.close()
ser.close()
