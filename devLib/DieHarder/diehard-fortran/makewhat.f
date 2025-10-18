c****Makewhat.f: program to make random number files for DIEHARD
      print 123
123   format(
     &' This program makes a file of random integers ',/,
     &' for tests by DIEHARD.  Select one from this list:',/)
       print 124
124    format(
     &'  1.  A multiply-with-carry (MWC) generator x(n)=a*x(n-1)+carry
     &mod 2^32',/,
     &'  2.  A MWC generator on pairs of 16 bits',/,
     &'  3.  The "Mother of all random number generators"',/,
     &'  4.  The KISS  generator',/,
     &'  5.  The simple but very good generator COMBO',/,
     &'  6.  The lagged Fibonacci-MWC combination ULTRA',/,
     &'  7.  A combination MWC/subtract-with-borrow (SWB) generator, per
     &iod ~ 10^364',/,
     &'  8.  An extended congruential generator',/,
     &'  9.  The Super-Duper generator',/,
     &' 10.  A subtract-with-borrow generator',/,
     &' 11.  Any specified congruential generator',/,
     &' 12.  The 31-bit generator ran2 from Numerical Recipes',/,
     &' 13.  Any specified shift-register generator, 31 or 32 bits',/,
     &' 14.  The system generator in Sun Fortran f77',/,
     &' 15.  Any lagged-Fibonacci generator,  x(n)=x(n-r) op x(n-s)',/,
     &' 16.  An inverse congruential generator',/)
        open(4,file='makef.txt')
        print*,'  Enter your choice, 1 to 16:'
        read*,jch
       if(jch.eq.1 ) call MAKEMWC1
       if(jch.eq.2 ) call MAKE1616
       if(jch.eq.3 ) call MAKEMTHR
       if(jch.eq.4 ) call MAKEKISS
       if(jch.eq.5 ) call MAKECMBO
       if(jch.eq.6 ) call MAKELTRA
       if(jch.eq.7 ) call MAKESBMC
       if(jch.eq.8 ) call MAKEXCNG
       if(jch.eq.9 ) call MAKESUPR
       if(jch.eq.10) call MAKESWB
       if(jch.eq.11) call MAKECONG
       if(jch.eq.12) call MAKERAN2
       if(jch.eq.13) call MAKESHRG
       if(jch.eq.14) call MAKESUNR
       if(jch.eq.15) call MAKEFIBO
       if(jch.eq.16) call MAKEINVC
       end

        subroutine makemwc1
       implicit real*8 (a-h,o-z)
       integer*4 n(4096),x(2),a(2),w(4),c(4),t,b,xx,cc,z(4)
       character*80 text(22)
       character*15 filename
       character*1 op
        t(xx)=rshift(xx,16)
        b(xx)=and(xx,65535)
       read(4,845) text
       print 845,text
845    format(a78)
       print*,'  Pause:  enter any letter or number key to continue:'
679    format(a1)
       read 679,op
       print*,'  Enter filename (<=15 characters) for output:'
       read 2991,filename
2991   format(a15)
       open(2,file=filename,form='unformatted',access='direct',
     & recl=16384)
       print*,'      Select multiplier `a` from this list:'
       print*,'-------------------------------------------------------'
       print*,' 1791398085 1929682203 1683268614 1965537969 1675393560'
       print*,' 1967773755 1517746329 1447497129 1655692410 1606218150'
       print*,' 2051013963 1075433238 1557985959 1781943330 1893513180'
       print*,' 1631296680 2131995753 2083801278 1873196400 1554115554'
       print*,'-------------------------------------------------------'
       print 281
281   format(
     &' (In general, for any choice of `a`, let m=a*2^32-1. If both m',/
     &,' and (m-1)/2 are prime then the period will be (m-1)/2).')
       print*,'   Enter multiplier a:'
       read*,aa
        print*,'  Enter a seed integer x and initial carry c:'
        read*,xx,cc
        print*,'       Please wait..............'
         x(1)=b(xx)
         x(2)=t(xx)
         c(1)=b(cc)
         c(2)=t(cc)
         c(3)=0
         c(4)=0
         a(1)=b(aa)
         a(2)=t(aa)
          jk=0
           do 2 i=1,700
          jk=jk+1
              do 3 j=1,4096
              call prod(x,a,z)
              call sum(z,c,w)
              x(1)=w(1)
              x(2)=w(2)
              c(1)=w(3)
              c(2)=w(4)
              n(j)=lshift(x(2),16)+x(1)
3             continue
2        write(2,rec=jk) n
        print*,'            FINISHED'
      print 602,filename
602   format('  2,867,200 32-bit random integers (11,468,800 bytes)',/
     &,'  have been written to the file ',a15)
        print*,'  The period is', aa*2d0**31-1d0
        end

       subroutine make1616
       integer*4 n(4096),a,b,x,y
       character*80 text(27),dum
       open(2,file='mwc1616.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,846) (dum,j=1,22 )
       read(4,846) text
       print 846,(text(j),j=1,21)
846    format(a78)
       pause
       print 846,(text(j),j=22,27)
       print*,'      Select multipliers a and b, a<>b, from this list:'
       read(4,846) (text(j),j=1,10)
       print 846, (text(j),j=1,10)
       print*,'      Enter a and b: (my favorites are 18000 and 30903)'
       read*,a,b
        print*,' Enter two (<=31 bit) seed integers, not zero'
        read*,x,y
        print*,'       Please wait..............'
           jk=0
           do 2 i=1,700
           jk=jk+1
              do 3 j=1,4096
              x=a*and(x,65535)+rshift(x,16)
              y=b*and(y,65535)+rshift(y,16)
3             n(j)=lshift(x,16)+and(y,65535)
2        write(2,rec=jk) n
        print*,'            FINISHED'
        print*,'  2,867,200 32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file mwc1616.32          '
        print*,'  They are the concatenated output of two 16-bit'
        print*,'  multiply-with-carry generators.  The period is'
        print 800, (a*2d0**15-1d0)*(b*2d0**15-1d0)
800     format(f40.0)
        print*,'  (the last 4 digits may be lost to roundoff).'
801     format('  The correct last 4 digits are',i8)
        print 801,mod(mod(a*32768-1,10000)*mod(b*32768-1,10000),10000)
        return
        end

       subroutine makemthr
       implicit real*8 (a-h,o-z)
       integer*4 n(4096), x,y,z,w,v,a,b,c,d,carry
       character*80  text(23),dum
       parameter(dm=2d0**32)
       data a,b,c,d/2111111111,1492,1776,5115/
       data da,db,dc,dd/2111111111d0,1492d0,1776d0,5115d0/
       read(4,845) (dum,j=1,59)
       read(4,845) text
       print 845,text
845    format(a78)
745    format(a15)
      open(2,file='mthr.32',form='unformatted',access='direct',
     & recl=16384)
        print*,' Enter four seed integers:'
        read*,x,y,z,w
        print*,'       Please wait..............'
      jk=0
      do 3 ij=1,700
      jk=jk+1
      do 2 i=1,4096
      if(x.lt.0) then
      dx=x+dm
      else
      dx=x
      endif
      if(y.lt.0) then
      dy=y+dm
      else
      dy=y
      endif
      if(z.lt.0) then
      dz=z+dm
      else
      dz=z
      endif
      if(w.lt.0) then
      dw=w+dm
      else
      dw=w
      endif
      v=a*x+b*y+c*z+d*w+carry
      x=y
      y=z
      z=w
      w=v
      dv=da*dx+db*dy+dc*dz+dd*dw+carry
      carry=dint(dv/dm)
2     n(i)=w
3     write(2,rec=jk) n
        print*,'              '
        print*,'            FINISHED'
      print 602,filename
602   format('  2,867,200 32-bit random integers (11,468,800 bytes)',/
     &,'  have been written to the file ',a15)
      print*,'  The period is about 2^158.97'
        return
        end

       subroutine makekiss
       integer*4 b(4096),x,y,z,w,carry
       character*80 text(22),dum
       open(2,file='kiss.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,82)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' Enter four seed integers, not zero'
        read*,x,y,z,w
        carry=0
        print*,'       Please wait..............'
        jk=0
           do 2 i=1,700
           jk=jk+1
              do 33 jj=1,4096
              x=69069*x+1
              y=xor(y,lshift(y,13))
              y=xor(y,rshift(y,17))
              y=xor(y,lshift(y,5))
              k=rshift(z,2)+rshift(w,3)+rshift(carry,2)
              m=w+w+z+carry
              z=w
              w=m
              carry=rshift(k,30)
33              b(jj)=x+y+w
2        write(2,rec=jk) b
        print*,'            FINISHED'
        print*,'  2,867,200 32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file kiss.32          '
        return
        end
       subroutine makecmbo
c****Simple combo, period> 2^60.5
c***x(n)=x(n-1)*x(n-2) mod 2^32 added to
c*****period of x(n)=x(n-1)*x(n-2) is 3*2^29 if seeds odd, and one is +or-3 mod
c*****easy to ensure: replace seed x with 3*x*x.
c****mwc z=30903*iand(z,65535)+ishft(z,-16)
        implicit integer(a-z)
        integer b(4096)
        character*80 text(16),dum
        read(4,845) (dum,j=1,104)
        read(4,845) text
845     format(a78)
        print 845,text
        print*,'              '
        print*,'  Enter three seed integers:'
        read*,x,y,z
        x=x+x+1
        x=3*x*x
        y=y+y+1
       open(1,file='combo.32',form='unformatted',access='direct',
     & recl=16384)
         print*,'   Please wait..................'
        jk=0
        do 3 i=1,700
        jk=jk+1
        do 2 j=1,4096
        v=x*y
        x=y
        y=v
        z=30903*and(z,65535)+rshift(z,16)
2       b(j)=y+z
3       write(1,rec=jk) b
        print*,'            FINISHED'
        print*,'  2,867,200 32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file combo.32          '
        return
        end
       subroutine makeltra
      integer*4 bb(4096), r,s,ju(99)
      real xx(607)
      character*80 text(15),dum
      data r,s/99,33/
      read(4,845) (dum,j=1,120)
      read(4,845) text
      print 845,text
845   format(a78)
       open(1,file='ultra.32',form='unformatted',access='direct',
     & recl=16384)
       print*, '   Enter four positive integers for seeds:'
        read*,i,j,k,l
        mwcs=i+j+k+l
           DO 92 II=1,r
            i=18273*and(i,65535)+rshift(i,16)
            j=23163*and(j,65535)+rshift(j,16)
            k=24984*and(k,65535)+rshift(k,16)
            l=28854*and(l,65535)+rshift(l,16)
           js=lshift(i,16)+and(j,65535)+lshift(k,16)+and(l,65535)
           js=or(js,1)
           xx(ii)=.5+js*.5**32
92    jU(II)=jS
       print*,'    The seed table:'
       print 25, (jU(ig),ig=1,r)
25     format(5i12)
       call kstest(xx,r,px)
       print 271,px
271    format(' p-value for KSTEST on uniformity of seeds: ',f8.6)
        print*,'    Please wait................'
         IP=r
         JP=s
             jk=0
             do 2 i=1,700
             jk=jk+1
             do 3 j=1,4096
                jUNI=jU(IP)*jU(JP)
             jU(IP)=jUNI
            IP=IP-1
           IF(IP.EQ.0) IP=97
            JP=JP-1
            IF(JP.EQ.0) JP=97
            mwcs=30903*and(mwcs,65535)+rshift(mwcs,16)
3           bb(j)=juni+mwcs
2      write(1,rec=jk) bb
       print*,'     '
       print*,'     FINISHED'
      print*,' 2,867,200  32-bit random integers (11,468,800 bytes)'
      print*,'  have been written to the file ultra.32  '
       print*,'::::::::::::::::::::::::::::::::::::::::::::::'
        return
        end
      subroutine makesbmc
      integer*4 bb(4096), r,s,ju(37),x,y
      character*80 text(9),dum
      real xx(37)
      data r,s/37,24/
      read(4,845) (dum,j=1,135)
      read(4,845) text
      print 845,text
845   format(a78)
      print*,'    Enter four positive integers for seeds:'
        read*,i,j,k,l
      open(1,file='swbmwc.32',form='unformatted',access='direct',
     & recl=16384)
        print*,'    Please wait................'
         mwcs=i+j+k+l
           DO 92 II=1,r
           jS=0.
           DO 93 JJ=1,32
           M=MOD(MOD(I*J,179)*K,179)
           I=J
           J=K
           K=M
           L=MOD(53*L+1,169)
           jS=2*jS
           IF(MOD(L*M,64).GE.32) jS=jS+1
93    continue
      xx(ii)=.5+.5**32*jS
 92    jU(II)=jS
       print*,'    The seed table:'
       print 25, (jU(ig),ig=1,r)
25     format(5i12)
       call kstest(xx,r,px)
       print 271,px
271    format(' p-value for KSTEST on uniformity of seeds: ',f8.6)
         IP=r
         JP=s
          jk=0
             do 2 i=1,700
             jk=jk+1
             do 3 j=1,4096
             x=ju(ip)
             y=ju(jp)
             juni=x-y
           if(rshift(x,1).gt.rshift(y,1)) juni=juni-1
             jU(IP)=jUNI
            IP=IP-1
            IF(IP.EQ.0) IP=r
            JP=JP-1
            IF(JP.EQ.0) JP=r
             mwcs=30903*and(mwcs,65535)+rshift(mwcs,16)
 3       bb(j)=mwcs+juni
2      write(1,rec=jk) bb
       print*,'     '
       print*,'     FINISHED'
       print 349
349    format('     The binary file swbmwc.32'
     &/,'     has been created with 32-bit integers'
     &,/,'     from the subtract-with-borrow sequence'
     &,/,'    x(n)=x(n-24)-x(n-37)-borrow mod 2^32'
     &,/,'   combined with the multiply-with-carry sequence'
     &,/,'   y(n)=30903*y(n-1)+carry mod 2^16,'
     &,/,'  the overall sequence having period about 10^364.')
          return
          end

       subroutine makexcng
       integer*4 n(4096)
       real*8 a,b,c,p,x
       character*80 text(17),dum
       parameter(p=2d0**32-5d0,s=2d0**31)
       open(2,file='excong.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,144)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' Enter three seed integers, not all zero:'
        read*,a,b,c
        print*,'       Please wait..............'
        r3=2d0**32/34359737519d0
        r4=2d0**32/34359736739d0
       jk=0
      do 3 ij=1,700
      jk=jk+1
      do 2 i=1,4096
         go to(51,52,53,54),jch
51         x=dmod(1776d0*a+1476d0*b+1176d0*c,4294967291d0)
           go to 166
52         x=dmod(8192*(a+b+c),4294967291d0)
           go to 166
53         x=dmod(2001d0*a+1998d0*b+1995d0*c,34359737519d0)
           x=x*r3
           go to 166
54         x=dmod(524288d0*(a+b+c),34359736739d0)
           x=x*r4
166   a=b
      b=c
      c=x
      if(x.lt.s) then
      n(i)=x
      else
      n(i)=x-2d0**32
      endif
2      continue
3      write(2,rec=jk) n
        print*,'              '
        print*,'            FINISHED'
        print*,'  2,867,200 32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file excong.32          '
        return
        end
       subroutine makesupr
       integer*4 n(4096),x,y
       character*80 text(20),dum
       character*1 op
       open(2,file='suprdupr.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,161)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' Enter two  seed integers, the second not zero:'
        read*,x,y
        print*,'  Choose your method of combination,'
        print*,'  + for addition, x for exclusive-or, in column 1:'
        read 821,op
821     format(a1)
        print*,'       Please wait..............'
        jk=0
        if(op.eq.'+') then
           do 2 i=1,700
           jk=jk+1
              do 3 j=1,4096
              x=69069*x+1
              y=xor(y,lshift(y,13))
              y=xor(y,rshift(y,17))
              y=xor(y,lshift(y,5))
3             n(j)=x+y
2        write(2,rec=jk) n
         end if
         if(op.eq.'x') then
           do 72 i=1,700
           jk=jk+1
              do 73 j=1,4096
              x=69069*x+1
              y=xor(y,lshift(y,13))
              y=xor(y,rshift(y,17))
              y=xor(y,lshift(y,5))
73             n(j)=xor(x,y)
72        write(2,rec=jk) n
         endif
        print*,'            FINISHED'
        print*,'  2,867,200 32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file suprdupr.32  '
        return
        end
       subroutine  makeswb
       integer*4 bb(4096), r,s,ju(48),rc(5),sc(5),x,y,jix(5)
      character*15 filename
      character*80 text(17),dum
      character*42 swb(5),period(5)
      data rc,sc/43,37,24,21,48,22,24,19,6,8/
      data jix/-6,0,0,0,2147483647/
       read(4,845) (dum,j=1,181)
       read(4,845) text
       print 845,text
845    format(a78)
       print*,'    Choose your generator from this list:'
       print 945,swb
945    format(10x,a42)
       data swb/
     &'   1:   x(n)=x(n-43)-x(n-22)-c mod 2^32-5',
     &'   2:   x(n)=x(n-37)-x(n-24)-c mod 2^32  ',
     &'   3:   x(n)=x(n-24)-x(n-19)-c mod 2^32  ',
     &'   4:   x(n)=x(n-21)-x(n- 6)-c mod 2^32  ',
     &'   5:   x(n)=x(n-48)-x(n- 8)-c mod 2^31  '/
      print*,'(Choice 5 provides 31-bit integers that are left-justified
     &.)'
       print*,' enter 1,2,3,4 or 5:'
       read*, jchoice
       r=rc(jchoice)
       s=sc(jchoice)
        print*,'     Enter output file name (<=15 characters):'
        read 645,filename
645     format(a15)
      open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
        print 348
348     format('    Enter four positive integers for seeds:')
        read*,i,j,k,l
        print*,'    Please wait................'
              do 90 ijk=1,i
c 90              jjn=1
90            jjn=irand(1)
           DO 92 II=1,r
           jS=0.
           DO 93 JJ=1,32
           M=MOD(MOD(I*J,179)*K,179)
           I=J
           J=K
           K=M
           L=MOD(53*L+1,169)
           jS=2*jS
           IF(MOD(L*M,64).GE.32) jS=jS+1
93    continue
      if(jchoice.eq.5) js=xor(js,1)
92    jU(II)=jS
         IP=r
         JP=s
         jk=0
             do 2 i=1,700
             jk=jk+1
             do 3 j=1,4096
             x=ju(ip)
             y=ju(jp)
             juni=x-y
           if(rshift(x,1).lt.rshift(y,1)) juni=juni+jix(jchoice)
             jU(IP)=jUNI
            IP=IP-1
           IF(IP.EQ.0) IP=r
            JP=JP-1
            IF(JP.EQ.0) JP=r
            if(jchoice.eq.5) juni=juni+juni
3           bb(j)=juni
2      write(1,rec=jk) bb
       print*,'     '
       print*,'     FINISHED'
       print 349, filename,swb(jchoice)
349    format('     The binary file ',a15,
     &/,'     has been created with 32-bit integers'
     &,/,'     from the subtract-with-borrow sequence',/,a41)
       print 350,period(jchoice)
350    format(15x, 'The period is',/,a41)
       data period/
     &'  (2^32-5)^43 - (2^32-5)^22, about 10^414',
     &'  2^1178 - 2^762, about 10^354           ',
     &'  (2^759 - 2^599)/3, about 10^228        ',
     &'  (2^666 - 2^186)/3, about 10^200        ',
     &'  (2^1478 - 2^247)/105, about 10^445     '/
       print*,'+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
       return
       end
      subroutine makecong
      implicit real*8(a-h,o-z)
      integer*4 bb(4096), a,b,r,s
      real*4 x(2000),y(2000)
       character*80 text(13)
       character*1 op
       character*15 filename
       read(4,845) (dum,j=1,198)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' Enter a,b,r and s for the generator'
        print*,'  x(n)=a*x(n-1)+b mod 2^r+s'
      print*,' To avoid overflow, make sure a*2^r < 2^53) '
        read*,a,b,r,s
        print*,' Enter a seed integer:'
        read*,jseed
        da=a
        db=b
        dm=2d0**r+s
        print*,' If you want the 2-lattice without generating'
      print*,' the binary file, enter 0, else enter 1:'
      print*,'   Create binary file? 0 for NO, 1 for YES:'
      read*, jlat
            if (jlat.eq.1) then
            print*,'     Enter output file name (<=15 characters):'
            read 645,filename
645         format(a15)
      open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
         print*,'   Please wait................'
            dj=jseed
            dr=2d0**(32-r)
             jk=0
            do 2 i=1,700
             jk=jk+1
               do 3 j=1,4096
               dj=dmod(da*dj+db,dm)
               dx=dr*dj
                   if(dx.lt.2d0**31) then
                   bb(j)=dx
                   else
                   bb(j)=dx-2d0**32
                   endif
3             continue
2           write(1,rec=jk) bb
            endif
        print 221,filename
221   format('  2,867,200 32-bit random integers (11,468,800 bytes)',/,
     &'  have been written to the file ',a15)
         print*,' To display the 2-lattice of this generator, '
         print*,'  hit any letter or number key:'
          read 983,op
 983     format(a1)
         dL=2d0**(20+r-32)
         kount=0
         klim=da*dL/dm
            do 29 k=1,klim
            j1=max(0,(k*dm-b)/da)
            j2=(k*dm-b+dL)/da
                 do 39 j=j1,j2
                 yy=dmod(da*j+db,dm)
                 if(yy .lt. dL)  then
                 kount=kount+1
                 x(kount)=j/dm
                 y(kount)=yy/dm
                 endif
39                continue
29            continue
          call plot1(x,y,kount,54)
      return
      end
       subroutine makeran2
       integer*4 b(4096)
       character*80 text(16),dum
       open(2,file='ran2.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,211)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' enter a seed integer'
        read*,jseed
          idum=-iabs(jseed)
          jk=0
           do 3 ij=1,700
          jk=jk+1
       do 2  i=1,4096
2       b(i)=lshift(iran2(idum),1)
3        write(2,rec=jk) b
        print*,'  Now 2,867,200 left-adjusted integers from ran2'
        print*,'  (11,486,800 bytes) have been written to ran2.32'
        return
        end

      FUNCTION iran2(idum)
      INTEGER idum,IM1,IM2,IMM1,IA1,IA2,IQ1,IQ2,IR1,IR2,NTAB,NDIV
      REAL AM,EPS,RNMX
      PARAMETER (IM1=2147483563,IM2=2147483399,AM=1./IM1,IMM1=IM1-1,
     *IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211,IR2=3791,
     *NTAB=32,NDIV=1+IMM1/NTAB,EPS=1.2e-7,RNMX=1.-EPS)
      INTEGER idum2,j,k,iv(NTAB),iy
      SAVE iv,iy,idum2
      DATA idum2/123456789/, iv/NTAB*0/, iy/0/
      if (idum.le.0) then
        idum=max(-idum,1)
        idum2=idum
        do 11 j=NTAB+8,1,-1
          k=idum/IQ1
          idum=IA1*(idum-k*IQ1)-k*IR1
          if (idum.lt.0) idum=idum+IM1
          if (j.le.NTAB) iv(j)=idum
11      continue
        iy=iv(1)
      endif
      k=idum/IQ1
      idum=IA1*(idum-k*IQ1)-k*IR1
      if (idum.lt.0) idum=idum+IM1
      k=idum2/IQ2
      idum2=IA2*(idum2-k*IQ2)-k*IR2
      if (idum2.lt.0) idum2=idum2+IM2
      j=1+iy/NDIV
      iy=iv(j)-idum2
      iv(j)=idum
      if(iy.lt.1)iy=iy+IMM1
       iran2=iy
c      ran2=min(AM*iy,RNMX)
      return
      END
        subroutine makeshrg
c*** creates shift register random number file
c  use 13,18 or 7,24 or 6,25 or 3,28 or reverse for 31 bits
c use 15,17 or 13,17,5 for 32 bits
      integer b(4096),L,R
      character*80 text(12),dum
      character*15 filename
      m(k,n)=xor(k,lshift(k,n))
      mr(k,n)=xor(k,rshift(k,n))
       read(4,845) (dum,j=1,227)
       read(4,845) text
       print 845,text
845    format(a78)
      print*,'  Enter output file name (<= 15 characters):'
      read 645,filename
645   format(a15)
      open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
      print*,'   Choose number of bits, 31 or 32:'
      read*,nbits
      jk=0
      if(nbits.eq.31) then
      print*,'  Choose Left,Right shifts from these choices:'
      print*,'    13,18  18,13  24,7  7,24 6,25  25,6  28,3  3,28'
      print*,'  enter two integers, L and R, in free format:'
      read*,L,R
      mask=2**31-1
      print*,' Enter seed integer, not zero:'
      read*,j
        print*,'  Please wait..............'
          do 2 i1=1,700
           jk=jk+1
             do 3 i=1,4096
              j=mr(and(m(j,L),mask),R)
3              b(i)=j+j
2         write(1,rec=jk) b
      endif
      if(nbits.eq.32) then
      print*,' For 32 bit integers, you have three choices.'
      print*,'  two shifts: (L,R)=(17,15) or (15,17) and'
      print*,'  three shifts (L1,R,L2)=(13,17,5).'
      print*,' Enter three integers, 17 15 0 or 15 17 0 or 13 17 5:'
      read*,L,R,L2
      print*,' Enter seed integer, not zero:'
      read*,j
        print*,'  Please wait..............'
          if(L2.eq.0) then
          do 4 i1=1,700
           jk=jk+1
               do 5 i=1,4096
               j=mr(m(j,L),R)
5              b(i)=j
4         write(1,rec=jk) b
          elseif (L2.eq.5)then
          do 6 i1=1,700
           jk=jk+1
               do 7 i=1,4096
               j=m(mr(m(j,L),R),L2)
7              b(i)=j
6         write(1,rec=jk) b
          endif
        endif
        print*,'      FINISHED'
        print 221,filename
221   format('  2,867,200 32-bit random integers (11,468,800 bytes)',/,
     &'  have been written to the file ',a15)
       if(nbits.eq.31 .or. L2.eq.5) print 225,nbits
225   format(' The period of your generator is 2^',i2,'-1.')
         if(L.eq.15 .or. L.eq.17) print 226
226   format(' The period of your generator is 2^32-2^21-2^11+1.')
          return
          end
       subroutine makesunr
       integer*4 b(4096)
       character*80 text(18),dum
       open(2,file='sunran.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,239)
       read(4,845) text
       print 845,text
845    format(a78)
        print*,' Enter one  seed integer:'
        read*,jseed
        print*,'       Please wait..............'
       ijk=irand(jseed)
         ijk=1
        jk=0
       do 3 j=1,700
       jk=jk+1
       do 2 i=1,4096
c 2           b(i)=1
2      b(i)=irand(1)
3      write(2,rec=jk) b
        print*,'            FINISHED'
        print*,' 2,867,200  32-bit random integers (11,468,800 bytes)'
        print*,'  have been written to the file sunran.32  '
        print*,'  Note: the rightmost bit is always 0'
        return
        end
        subroutine makefibo
        integer*4 bb(4096), r,s,op,ju(607)
        character*80 text(9),dum
      real*8 period
      character*15 filename
       read(4,845) (dum,j=1,257)
       read(4,845) text
       print 845,text
845    format(a78)
          print 346
346   format(' Enter lags r and s from this list:',/,
     &'    17,5  33,13  39,14  55,24  63,31  73,25  97,33 607,273',/,
     &'     and op code: 1 for + , 2 for -, 3 for *, 4 for xor:')
      read*,r,s,op
            print*,'     Enter output file name (<=15 characters):'
            read 645,filename
645         format(a15)
      open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
        print 348
348     format('    Enter four positive integers for seeds:')
        read*,i,j,k,l
        print*,'    Please wait................'
              do 90 ijk=1,i
90            jjn=irand(1)
           DO 92 II=1,97
           jS=0.
           DO 93 JJ=1,32
           M=MOD(MOD(I*J,179)*K,179)
           I=J
           J=K
           K=M
           L=MOD(53*L+1,169)
           jS=2*jS
           IF(MOD(L*M,64).GE.32) jS=jS+1
93    continue
      if(op.eq.3) js=xor(js,1)
92    jU(II)=jS
         IP=r
         JP=s
         jk=0
             do 2 i=1,700
             jk=jk+1
             do 3 j=1,4096
                if(op.eq.1) then
                jUNI=jU(IP)+jU(JP)
                else if(op.eq.2) then
                jUNI=jU(IP)-jU(JP)
                else if(op.eq.3) then
                jUNI=jU(IP)*jU(JP)
                else
                jUNI=xor(jU(IP),jU(JP))
                endif
             jU(IP)=jUNI
            IP=IP-1
           IF(IP.EQ.0) IP=97
            JP=JP-1
            IF(JP.EQ.0) JP=97
3           bb(j)=juni
2      write(1,rec=jk) bb
       period=(2d0**r-1)*2d0**32
       if(op.eq.3) period=.25*period
       if(op.eq.4) period=(2d0**r-1)
       print*,'     '
       print*,'     FINISHED'
       print 349, filename
349    format('     The binary file ',a15
     &,/,'     has been created with 32-bit integers'
     &,/,'     from the lagged-Fibonacci sequence')
       if(op.eq.1) then
       print*,'+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
       print 351,r,s
351    format(15x,'x(n) = x(n-',i3,') + x(n-',i3,') mod 2^32')
       else if(op.eq.2) then
       print 352,r,s
352    format(15x,'x(n) = x(n-',i3,') - x(n-',i3,') mod 2^32')
       else if(op.eq.3) then
       print 353,r,s
353    format(15x,'x(n) = x(n-',i3,') * x(n-',i3,') mod 2^32')
       else
       print 354,r,s
354    format(15x,'x(n) = x(n-',i3,') xor x(n-',i3,')')
       endif
       print 355
355    format('   The period of the sequence is ')
       print*,'     ',period
       return
       end
        subroutine prod(x,y,z)
        integer*4 x(2),y(2),z(4),t,b,r(4),s(4)
        integer*4 d
        t(d)=rshift(d,16)
        b(d)=and(d,65535)
        d=x(1)*y(1)
        z(1)=b(d)
        d=t(d)+x(1)*y(2)
        r(2)=b(d)
        r(3)=t(d)
        d=x(2)*y(1)
        s(2)=b(d)
        d=t(d)+x(2)*y(2)
        s(3)=b(d)
        s(4)=t(d)
        d=r(2)+s(2)
        z(2)=b(d)
        d=t(d)+r(3)+s(3)
        z(3)=b(d)
        z(4)=t(d)+s(4)
        return
        end
        subroutine sum(x,y,z)
        integer*4 x(4),y(4),z(4),t,b
        integer*4 d
        t(d)=rshift(d,16)
        b(d)=and(d,65535)
        d=x(1)+y(1)
        z(1)=b(d)
        d=t(d)+x(2)+y(2)
        z(2)=b(d)
        d=t(d)+x(3)+y(3)
        z(3)=b(d)
        d=t(d)+x(4)+y(4)
        z(4)=b(d)
        return
        end

      subroutine makeinvc
      integer*4 n(4096),a,b,icong
      character*80 text(15),dum
      real*8 b0,b1,b2,a0,a1,a2,dz
      data a,b,dz/69069,362436069,123456789d0/
      b0=4294967296d0
       open(1,file='invcong.32',form='unformatted',access='direct',
     & recl=16384)
       read(4,845) (dum,j=1,266)
       read(4,845) text
       print 845,text
845    format(a78)
      print*,'  Enter a and b and seed integer, free format:'
      read*, a,b,dz
      print*,'    This may take a long time, as this is a very'
      print*,'    very slow generator.  Please wait ...........'
      jk=0
      do 3 ij=1,700
       jk=jk+1
       do 2 i=1,4096
      b1=dz
      a0=0
      a1=1
      b0=4294967296d0
      do while(b1.gt.0)
      b2=dmod(b0,b1)
      a2=a0-a1*((b0-b2)/b1)
      b0=b1
      b1=b2
      a0=a1
      a1=a2
      end do
      dz=dmod(a*b0*a0+b,4294967296d0)
      if(dz.lt.0) dz=dz+4294967296d0
      if(dz.gt.2d0**31) then
      icong=dz-4294967296d0
      else
      icong=dz
      endif
2     n(i)=icong
3     write(1,rec=jk) n
      print 471
 471  format(
     &' The file invcong.32 now contains 11,428,800 bytes of 32-bit',/,
     &' integers from the inverse congruential generator.')
      end

       subroutine asort(list, n)
       real list(n)
       dimension iu(33), il(33)
       m=1
       i=1
       j=n
5       if(i.ge.j) goto 70
10       k=i
       ij= (i+j)/2
       t= list(ij)
       if(list(i).le.t) goto 20
       list(ij)= list(i)
       list(i)= t
       t= list(ij)
20       l=j
       if(list(j).ge.t) goto 40
       list(ij)= list(j)
       list(j)= t
       t= list(ij)
       if(list(i).le.t) goto 40
       list(ij)= list(i)
       list(i)= t
       t= list(ij)
       goto 40
30       list(l)= list(k)
       list(k)=tt
40       l=l-1
       if(list(l).gt.t) goto 40
       tt= list(l)
50       k= k+1
       if(list(k).lt.t) goto 50
       if(k.le.l) goto 30
       if(l-i.le.j-k) goto 60
       il(m)=i
       iu(m)=l
       i=k
       m=m+1
       goto 80
60       il(m)=k
       iu(m)=j
       j=l
       m=m+1
       goto 80
70       m=m-1
       if(m.le.0) return
       i=il(m)
       j=iu(m)
80       if(j-i.ge.11) goto 10
       if(i.eq.1) goto 5
       i=i-1
90       i=i+1
       if(i.eq.j) goto 70
       t= list(i+1)
       if(list(i).le.t) goto 90
       k=i
100       list(k+1)=list(k)
       k=k-1
       if(t.lt.list(k)) goto 100
       list(k+1)=t
       goto 90
       end
      SUBROUTINE KSTEST(Y,N,P)
C      TO TEST WHETHER A SET OF N REAL NUMBERS IS DRAWN
C      FROM A UNIFORM DISTRIBUTION (KOLMOROGOV-SMIRNOV METHOD)
C      THE TEST IS BASED ON THE DISTANCE BETWEEN THE EMPIRICAL
C      AND THEORETICAL DISTRIBUTION FUNCTIONS
C       USAGE: CALL KSTEST(Y,N,P)
C      Y ...   ARRAY OF REAL NUMBERS HYPOTHETICALLY DRAWN
C              FROM A UNIFORM DISTRIBUTION ON (0,1)
C      N ...   NUMBER OF ELEMENTS IN 'Y'
C      P IS THE PROBABILITY ASSOCIATED WITH THE OBSERVED VALUE
C      OF THE ANDERSON-DARLING STATISTIC: N TIMES THE INTEGRAL
C      OF (FN(X)-X)**2/(X*(1-X))
      DIMENSION Y(N)
      integer l(8,10)
      DATA L/40,46,37,34,27,24,20,20,88,59,43,37,29,27,20,
     &22,92,63,48,41,30,30,25,24,82,59,42,37,26,28,26,22,62,48,33,30
     &,23,23,22,18,49,34,22,20,16,17,17,12,17,17,7,8,4,7,5,1,40,18,
     &19,14,16,13,10,9,59,20,10,4,1,1,0,-1,41,43,36,112,15,95,32,58/
      CALL ASORT(Y,N)
      Z=-N*(N+0.)
      DO 2 I=1,N
      T=Y(I)*(1.-Y(N+1-I))
      IF(T.LT.1.E-20)T=1.E-20
  2   Z=Z-(I+I-1)*ALOG(T)
      Z=Z/N
      P=0.
      IF(Z .LT. .01) GO TO 5
      IF(Z .GT. 2.) GO TO 3
      P=2.*EXP(-1.2337/Z)*(1.+Z/8.-.04958*Z*Z/(1.325+Z))/SQRT(Z)
      GO TO 5
  3   IF(Z .GT. 4.) GO TO 4
      P=1.-.6621361*EXP(-1.091638*Z)-.95059*EXP(-2.005138*Z)
      GO TO 5
  4   P=1.-.4938691*EXP(-1.050321*Z)-.5946335*EXP(-1.527198*Z)
  5   M=MIN0(N-2,8)
      E=0.
      DO 6 J=1,10
  6   E=E+L(M,J)*SP(P,J)*.0001
      IF(N .GT. 10) E=10.*E/N
      A=P+E
      RETURN
      END
      FUNCTION SP(X,I)
      SP=0.
      GO TO (7,7,7,7,7,7,7,8,9,10),I
  7   T=ABS(10.*X-.5-I)
      IF(T.GT.1.5) RETURN
      IF(T.LE. .5) THEN
                   SP=1.5-2.*T*T
      ELSE
                   SP=2.25-T*(3.-T)
      ENDIF
      RETURN
  8   IF(X .LE. .8 .OR. X .GE. 1.) RETURN
      SP=100.*(X-.9)**2 -1.
      RETURN
  9   IF(X .LE. 0. .OR. X .GE. .05) RETURN
      IF(X .LE. .01) THEN
                     SP=-100.*X
      ELSE
                     SP=25.*(X-.05)
      ENDIF
      RETURN
  10  IF(X .LE. .98 .OR. X .GE. 1.) RETURN
      SP=.1-10.*ABS(X-.99)
      RETURN
      END

      SUBROUTINE PLOT1(X,Y,N,NC)
      REAL X(1),Y(1),Z(1)
      CHARACTER*1 C(90,54),STAR,BLANK,PLUS,ZERO,F(4860)
      CHARACTER*4860 D,E
      LOGICAL    P2
      EQUIVALENCE (C,D),(E,F)
      PARAMETER(STAR='*',BLANK=' ',PLUS='+',ZERO='0')
      DATA F/4860*' '/
      P2=.FALSE.
      GO TO 1
      ENTRY PLOT2(X,Y,Z,N,NC)
      P2=.TRUE.
  1   NR=48*NC/100
      IF(NC.GT.60) NR=6*NC/10
      XL=X(1)
      XR=XL
      YB=Y(1)
      YT=YB
      DO 2 I=1,N
      XL=AMIN1(XL,X(I))
      XR=AMAX1(XR,X(I))
      IF(P2) YB=AMIN1(YB,Z(I))
      IF(P2) YT=AMAX1(YT,Z(I))
      YB=AMIN1(YB,Y(I))
  2   YT=AMAX1(YT,Y(I))
      PRINT 22,XL,XR,YB,YT
 22   FORMAT('   X RANGE:',G12.3,' TO ',G12.3,'  Y,Z RANGE:',G12.3,'  TO
     + ',G12.3)
      XD=1.
      IF(XL.NE.XR) XD=NC/(XR-XL)
      YD=1.
      IF(YB.NE.YT) YD=NR/(YT-YB)
      D=E
      DO 4 M=1,N
      I=1.+(X(M)-XL)*XD
      J=1.+(Y(M)-YB)*YD
      C(I,J)=STAR
      IF(.NOT. P2) GO TO 4
      K=1.+(Z(M)-YB)*YD
      C(I,K)=PLUS
      IF(J.EQ.K) C(I,K)=ZERO
  4   CONTINUE
      DO 5 J=NR,1,-1
  5   PRINT 21,(C(I,J),I=1,NC)
  21  FORMAT(10X,90A1)
      RETURN
      END
