import sys

weekNum = sys.argv[1]
paperNum = sys.argv[2]

filename = 'Week'+str(weekNum).zfill(2)+'_Paper'+str(paperNum).zfill(2)+'_WenhanZhu.md'

open(filename, 'a').close()



