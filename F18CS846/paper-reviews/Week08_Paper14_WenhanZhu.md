### Automatic Identification of Load Testing Problems

#### Summary

This paper discussed the problems with load testing and analysing the log file corresponds to the load testing. Then purposed a new method using anomaly detection with z-stats that would report anomaly behavior and therefore discover problems with both the software and the load testing tool. The authors conducted case study on both open source and industrial settings and discovered a >50% precision rate for detecting problems in both software and load testing. Also the speed of the purposed method is extremely fast comparing to traditional methods (minutes vs hours).

#### Things I would like to see discussed

- What happens if a huge problem occurs that it's considered the norm by the anomaly detection? The authors mentions segmenting but it would imply that anomaly would be different across settings and the scale will be vastly different if the segments are small and produce z-stats that may not reflect the entire picture.

- How to see if there are any problems not detected by the method purposed? To me this seems like an addition to other methods just by looking at it.

- The method seems also to work on existing log files to determine problems of the software. 
