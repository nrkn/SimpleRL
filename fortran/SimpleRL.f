      program simplerl
      character map(10)
      integer width, height, x, y, pX, pY
      parameter (width = 10, height = 10)
      
      map(1) = '####  ####'
      map(2) = '#  ####  #'
      map(3) = '#        #'
      map(4) = '##      ##'
      map(5) = ' #      # '
      map(6) = ' #      # '
      map(7) = '##      ##'
      map(8) = '#        #'
      map(9) = '#  ####  #'
      map(10) = '####  ####'

      write '////////////////////////'
      
      do 10 y = 1, 10
        print map(y)
10    continue      
      end