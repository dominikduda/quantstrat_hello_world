source('lib/load_packages.r')
source('lib/input_utils.r')
source('lib/chart_utils.r')

time_series <- normalized_time_series('AUDUSD_5min.csv')
plot_candles(time_series)

print('--------> Done!!')