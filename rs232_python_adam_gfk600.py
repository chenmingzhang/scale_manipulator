# this script records scale readings from adam gfk 600
import serial
import time 
ser = serial.Serial('/dev/ttyUSB0')
rows_per_read=13  # it is found that adam scale comes with 13 lines of readings
no_of_readings=3  # totally how many readings will be done
sleep_time_seconds=2 # the interval of neighbouring readings.
#strs = [["" for x in range(rows_per_read)] for x in range(no_of_readings)]
temp=["" for x in range(rows_per_read)];
reading_scale=["" for x in range(no_of_readings)]
reading_time =["" for x in range(no_of_readings)]
# the '0' at the end of the script helps save instantly.
# http://stackoverflow.com/questions/18984092/python-2-7-write-to-file-instantly
fid= open('scale_record.dat','a',0)

for n in range(0, no_of_readings-1):
    ser.write('w\n\r')
    for i in range(0,rows_per_read):
        #strs[n][i] = ser.readline()
        temp[i]=ser.readline()
    reading_scale[n]=temp[8]
    reading_time[n]=temp[3]
    fid.write(time.strftime("%d/%b/%Y %I:%M:%S")+reading_time[n]+reading_scale[n])
    time.sleep(sleep_time_seconds)


fid.close()
ser.close()
        
