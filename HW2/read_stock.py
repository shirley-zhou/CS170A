import numpy as np
import matplotlib.pyplot as plt
import csv

def read_stock(CSV_Filename):
    csv_file_object = csv.reader( open(CSV_Filename, 'rb') )
    header = csv_file_object.next()        # extract the header line
    rows = [ row for row in csv_file_object ] 
    adjusted_close = np.array([x[6] for x in rows], dtype='double')   #  7th column = adjusted closing price
    import datetime
    def year_time_value(datestring):
         datetime_tuple = datetime.datetime.strptime(datestring,'%Y-%m-%d')
         year = datetime_tuple.year
         year_start = datetime.datetime( year, 1, 1 ).toordinal()
         day_of_year = float( datetime_tuple.toordinal() - year_start )
         number_of_days_in_year = float( datetime.datetime( year, 12, 31 ).toordinal() - year_start + 1 )
         return  float(year) + day_of_year / number_of_days_in_year
    time = np.array([year_time_value(x[0]) for x in rows], dtype='double')   #  1st column = time (yyyy-mm-dd)
    plt.plot(time, adjusted_close, 'b-')
    plt.title(CSV_Filename)
    plt.show()
    return (time, adjusted_close)

if __name__ == "__main__":
    read_stock( 'IXIC.csv' )

