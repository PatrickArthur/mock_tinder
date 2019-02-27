const DateFormat = (time) => {
  var time_stamp = new Date(time);
  return time_stamp.toLocaleString(undefined, {
                                                day: 'numeric',
                                                month: 'numeric',
                                                year: 'numeric',
                                                hour: '2-digit',
                                                minute: '2-digit',
                                  })

}

export default DateFormat;
