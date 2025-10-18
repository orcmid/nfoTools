      real x(1000)
      character*15 filename,fileout
c**** converts binary file of 32-bit integers to
c**** single precision standard normal variables.
      print 12345
12345 format(10x,'This program will read a binary file of',/,
     &10x,'32-bit random integers and write a binary file',/,
     &10x,'of standard normal random variables, using the',/,
     &10x,'ziggurat method of Marsaglia and Tsang, ',/,
     &10x,'SIAM J. Scient. and Stat. Computing, v5, 349-359, 1984',/)
      print*,' Enter name of source file ( binary, 32-bit integers):'
      read 20,filename
20    format(a15)
      open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
      print*,' Enter name of output file:'
      read 20,fileout
      open(2,file=fileout,form='unformatted',access='direct',
     & recl=4000)
      print*,' Enter n for output of RNOR''S (in thousands):'
      read*,n
      print*,'           Please wait ...............'
      jk=0
      do 2 i=1,n
      do 3 k=1,1000
3     x(k)=zignor()
      jk=jk+1
2     write(2,rec=jk) x
      close(2)
      print*,'           Finished'
      print 25, n,fileout
25    format(i10,'000 standard normal random variables',/,
     &'      have been written to the file ',a15)
       go to 123
11111  print*,'  ERROR:  not enough integers in source file'
123       end
       function jtbl()
      integer b(4096)
      data j,jk/4097,1/
      if(j.gt.4096) then
      read(1,rec=jk) b
      j=1
      jk=jk+1
      endif
      jtbl=b(j)
      j=j+1
      return
      end
c***Ziggurat rnor. Takes 2.2 microsecs(Microsoft, 5.9 in Lahey)
c****************  takes 2.0 if jsr is only rng, 2.2 if jsr+icng
c***        mpynor takes 3.1, rnor92 takes 3.8
      function zignor()
      real v(0:64)
       parameter(aa=12.37586,b=.4878992,c=12.67706,rmax=.4656613e-9,
     +           c1=.9689279,c2=1.301198,pc=.1958303e-1,xn=2.776994)
      data v/.3409450,.4573146,.5397793,.6062427,.6631691,.7136975,
     +  .7596125,  .8020356,  .8417227,  .8792102,  .9148948, 0.9490791,
     +  .9820005, 1.0138492, 1.0447810, 1.0749254, 1.1043917, 1.1332738,
     + 1.1616530, 1.1896010, 1.2171815, 1.2444516, 1.2714635, 1.2982650,
     + 1.3249008, 1.3514125, 1.3778399, 1.4042211, 1.4305929, 1.4569915,
     + 1.4834527, 1.5100122, 1.5367061, 1.5635712, 1.5906454, 1.6179680,
     + 1.6455802, 1.6735255, 1.7018503, 1.7306045, 1.7598422, 1.7896223,
     + 1.8200099, 1.8510770, 1.8829044, 1.9155831, 1.9492166, 1.9839239,
     + 2.0198431, 2.0571356, 2.0959930, 2.1366450, 2.1793713, 2.2245175,
     + 2.2725186, 2.3239338, 2.3795008, 2.4402218, 2.5075117, 2.5834658,
     + 2.6713916, 2.7769942, 2.7769942, 2.7769942, 2.7769942/
      uni()=.5+jtbl()*.5**32
c--FAST PART
      i=jtbl()
      j=and(i,63)
      zignor=i*rmax*v(j+1)
      if(abs(zignor) .le. v(j)) return
c-------SLOW PART; aa is a*f(0)
      y=uni()
      s=x+y
      if(s .gt. c2) go to 11
      if(s .le. c1) return
      if(y .gt. c-aa*exp(-.5*(b-b*x)**2)) go to 11
      if(exp(-.5*v(j+1)**2)+y*pc/v(j+1) .le. exp(-.5*zignor**2)) return
c---------------TAIL PART; .3601016 is 1/xn
22      x=.3601016*alog(uni())
      if(-2.*alog(uni()) .le. x*x) go to 22
33    zignor=sign(xn-x,zignor)
      return
11    zignor=sign(b-b*x,zignor)
      return
      end
