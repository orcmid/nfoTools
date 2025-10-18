!c************top of file
c  allbrank.obj cdosum.obj cdoperm5.obj asort.obj kstest.obj phi.obj
       character*25 filename,fileout
       print*,'   This program runs the full DIEHARD battery of tests,'
       print*,' giving the p-values but little explanation. '
       print*,' Enter name of file to be tested:'
       read 845,filename
 845   format(a25)
       open(1,file=filename,form='unformatted',access='direct',
     & recl=16384)
       print*,' Enter name of output file:'
       read 845, fileout
       open(3,file=fileout)
       call cdbday(filename)
       write(3,399)
       print 399
399    format('---------------------------------------------------------
     &-----------------------')
       call cdoperm5(filename)
       write(3,399)
       print 399
       call rank3132(filename)
       write(3,399)
       print 399
       call cdbinrnk(filename)
       write(3,399)
       print 399
       call cdbitst(filename)
       write(3,399)
       print 399
       call cdomso(filename)
       write(3,399)
       print 399
       call sknt1s(filename)
       write(3,399)
       print 399
       call wknt1s(filename)
       write(3,399)
       print 399
       call cdpark(filename)
       write(3,399)
       print 399
       call mindist(filename)
       write(3,399)
       print 399
       call d3sphere(filename)
       write(3,399)
       print 399
       call sqeez(filename)
       write(3,399)
       print 399
       call cdosum(filename)
       write(3,399)
       print 399
       call runtest(filename)
       write(3,399)
       print 399
       call craptest(filename)
       print 400,filename
       write(3,400) filename
400    format('  Test completed.  File ',a15,/,
     &':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     &::::::::::::::::')
88     continue
       end
      subroutine cdbitst(filename)
C     THE OVERLAPPING 20-tuples TEST  BITSTREAM, 20 BITS PER WORD, N words
c     If n=2^22, should be 19205.3 missing 20-letter words, sigma 167.
C     If n=2^21, should be 141909 missing 20-letter words, sigma   428.
C     If n=2^20, should be 385750 missing 20-letter words, sigma   512
      INTEGER W(0:32767),MBIT(0:31)
      character*25 filename
      real*4 mu,sigma
      jkk=jkreset()
      n=20
      kpow=21
      ntries=20
      sigma=428
C**** SET MASK BITS***************
      MBIT(0)=1
      DO 8 I=1,31
 8       MBIT(I)=2*MBIT(I-1)
c***********INITIALIZE*****************
         write(3,*)'      THE OVERLAPPING 20-tuples BITSTREAM TEST,'
         write(3,*)'           20 BITS PER WORD, 2^21 words.'
         print*,'      THE OVERLAPPING 20-tuples BITSTREAM TEST,'
         print*,'           20 BITS PER WORD, 2^21 words.'
         write(3,*)'   This test samples the bitstream 20 times.'
         print*,   '   This test samples the bitstream 20 times.'
         mu=2**20*EXP(-2.**(KPOW-20))
         write(3,2511) mu,sigma
         print 2511,mu,sigma
 2511    format( '  No. missing words should average',f9.0,
     &        ' with sigma=',f4.0,/,'------------------------------------------
     &        ---------------')
C*****MAIN LOOP*********
C**** GET INITIAL WORD
         j=jtbl()
         j=and(j,2**20-1)
         S=0
         SS=0
         nint=1024
         print 2345,filename
 2345    format(' BITSTREAM test results for',a15)
         DO 2 NT=1,NTRIES
C     ********SET W-TABLE TO ZEROS*******
            DO 9 I=0,32767
 9             W(I)=0
C**** GENERATE 2**kpow OVERLAPPING WORDS**********
               DO 3 IC=1,2**(KPOW-5)
                  num=jtbl()
                  do 3 ib=1,32
C     *** GET NEW J *****
                     j=lshift(and(j,2**19-1),1)+and(num,1)
                     num=rshift(num,1)
C     *** GET BIT INDEX FROM LAST 5 BITS OF J  ***
                     L=AND(J,31)
C     *** GET TABLE INDEX FROM LEADING 15 BITS OF J***
                     K=rshift(J,5)
C     *** SET BIT L IN W(K) ***
 3                   W(K)=OR(W(K),MBIT(L))
C     ********** COUNT NUMBER OF EMPTY CELLS *******
                     KOUNT=0
                     DO 4 K=0,32767
                        DO 4 L=0,31
 4                         IF(AND(W(K),MBIT(L)).EQ.0) KOUNT=KOUNT+1
C     ****END OF MAIN LOOP****
      x=(kount-mu)/sigma
      write(3,22) nt,kount,x,phi(x)
 2    PRINT 22,NT,KOUNT,x,phi(x)
 22   format(' tst no ',i2,': ',i7,' missing words, ',f7.2,
     &     ' sigmas from mean, p-value=',f7.5)
      jkk=jkreset()
      print 489
      write(3,489)
 489  format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      END
      subroutine d3sphere(filename)
      real x(4000),y(4000),z(4000),p(20)
      character*25 filename
      uni()=500.+.2328306e-6*jtbl()
      n=4000
          jkk=jkreset()
      write(3,841) filename
      print 841, filename
 841  format('               The 3DSPHERES test for file ',a15)
      do 6 ij=1,20
         dmin=10000000.
         do 2 i=1,n
 2          x(i)=uni()
            call  asort(x,n)
            do 3 i=1,n
               y(i)=uni()
 3             z(i)=uni()
               do 4 i=1,n
                  u=x(i)
                  v=y(i)
                  w=z(i)
                  do 5 j=i+1,n
                     d=(u-x(j))**2
                     if(d .ge. dmin) go to 4
           d=d+(v-y(j))**2+(w-z(j))**2
5          if(d.lt.dmin) dmin=d
4     continue
      r3=dmin*sqrt(dmin)
      p(ij)=1-exp(-r3/30.)
      write(3, 28) ij,r3,p(ij)
6      print 28,ij,r3,p(ij)
28    format(' sample no: ',i2,4x,' r^3= ',f7.3,4x,
     &' p-value=',f7.5)
      write(3,22)
      print 22
22    format('  A KS test is applied to those 20 p-values.',/,
     &'---------------------------------------------------------')
      call kstest(p,20,pv)
      print 25,filename,pv
      write(3,25) filename,pv
25    format(6x,' 3DSPHERES test for file ',a15,'      p-value=',f8.6,
     &/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',
     &/)
      jkk=jkreset()
      return
      end

      subroutine sqeez(filename)
c  SQUEEZE TEST.  How many iterations of k=k*uni()+1 are required
c  to squeeze k down to 1, starting with k=2147483647=2^31-1.
c  The exact distribution of the required j is used, with
c  a chi-square test based on 100,000 tries.
c  The mean of j is 23.064779, with variance 23.70971151.
      real ex(6:48), tbl(6:48)
      character*25 filename
      data (ex(i),i=6,48)/21.03,57.79,175.54,467.32,1107.83, 2367.84,
     &4609.44,8241.16,13627.81,20968.49,30176.12,40801.97,52042.03,
     &62838.28,72056.37,78694.51,82067.55,81919.35,78440.08,72194.12,
     &63986.79,54709.31,45198.52,36136.61,28000.28,21055.67,15386.52,
     &10940.20,7577.96,5119.56,3377.26,2177.87,1374.39,849.70,515.18,
     &306.66, 179.39, 103.24, 58.51, 32.69, 18.03,  9.82, 11.21/
c Put a one-line function here to provide the uni being tested:
      uni()=.5+jtbl()*.5**32
       
      jkk=jkreset()
1      do 7 i=6,48
7      tbl(i)=0
       do 2 i=1,100000
       j=0
       k=2147483647
11     k=k*uni()+1
       j=j+1
       if(k.gt.1) go to 11
       j=min(max(j,6),48)
2      tbl(j)=tbl(j)+1.
       chsq=0
       do 3 i=6,48
3     chsq=chsq+(tbl(i)-.1*ex(i))**2/(.1*ex(i))
      sig=sqrt(84.)
      write(3,345) filename
      print 345, filename
345   format('            RESULTS OF SQUEEZE TEST FOR ',a15)
      write(3,348)
      print 348
348   format('         Table of standardized frequency counts',/,
     &'     ( (obs-exp)/sqrt(exp) )^2',/,
     &'        for j taking values <=6,7,8,...,47,>=48:')
      write(3,25)((tbl(i)-.1*ex(i))/sqrt(.1*ex(i)),i=6,48)
      print 25,((tbl(i)-.1*ex(i))/sqrt(.1*ex(i)),i=6,48)
25    format(6f8.1)
      write(3,71)  chsq
      print 71,chsq
71    format(8x,'   Chi-square with 42 degrees of freedom:',f7.3)
      print 72,(chsq-42.)/sig,chisq(chsq,42)
      write(3,72) (chsq-42.)/sig,chisq(chsq,42)
72    format(8x,'      z-score=',f7.3,'  p-value=',f8.6,/,
     &'______________________________________________________________')
      jkk=jkreset()
      print 489
      write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      end
      subroutine cdpark(filename)
      real x(4000),y(4000),g(10)
      character*25 filename
      parameter(ntries=12000,sq=100.,nt=10)
      uni()=.5+.5**32*jtbl()
      jkk=jkreset()
      s=0.
      ss=0.
      write(3,2345) filename
      print 2345,filename
2345  format(10x,' CDPARK: result of ten tests on file ',a15,/,
     &10x,'  Of 12,000 tries, the average no. of successes',/,
     &15x,'  should be 3523 with sigma=21.9')
      do 8 ij=1,nt
      x(1)=sq*uni()
      y(1)=sq*uni()
      k=1
      do 3 n=1,ntries
      z=sq*uni()
      w=sq*uni()
      do 5 i=1,k
5       if(abs(x(i)-z).le.1. .and. abs(y(i)- w).le.1.) go to 3
      k=k+1
      x(k)=z
      y(k)=w
3     continue
      s=s+k
      ss=ss+k*k
      z=(k-3523.)/21.9
      g(ij)=phi(z)
      print 27,k,z,g(ij)
      write(3,27) k,z,g(ij)
27    format(10x,'  Successes:',i5,'    z-score:',f7.3,' p-value:',
     &f8.6)
8     continue
      av=s/nt
      sig=ss/nt-av**2
      write(3,*)
      print 25,sq,av,sqrt(sig)
      write(3,25) sq,av,sqrt(sig)
25    format(10x,' square size   avg. no.  parked   sample sigma',/,
     &10x,f7.0,f20.3,f13.3)
      call kstest(g,10,pp)
      print 26,pp
      write(3,26) pp
26    format('            KSTEST for the above 10: p= ',f8.6)
      jkk=jkreset()
      print 489
      write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      end
      subroutine mindist(filename)
c  minimum distance^2 between n  random points(x(i),y(i)).
c  mean is about .64 for 4000 points in a square of side 1000.
c  and .995 for 8000 points in a square of side 10000.
c Since distance^2 is approximately exponential with mean .04,
c 1.-exp(-d^2/.04) should be uniform on [0,1).  Thus a KS test.
      real xy(16000),g(100)
      real*8 qq(8000)
      character*25 filename
      equivalence(qq(1),xy(1))
c***** one line function to generate a random coordinate in [0,1000).
      uni()=5000.+jtbl()*.2328306e-5
      n=8000
      ns=100
      jkk=jkreset()
      print 441, filename
      write(3,441) filename
441   format('               This is the MINIMUM DISTANCE test',/,
     &'              for random integers in the file ',a15,/,
     &4x,' Sample no.    d^2     avg     equiv uni            ')
      do 345 ij=1,ns
      dmin=10000000.
      do 2 i=1,16000
2        xy(i)=uni()
      call dsort(qq,8000)
        do 4 i=2,16000,2
        u=xy(i)
        v=xy(i-1)
           do 5 j=i+2,16000,2
           d=(u-xy(j))**2
           if(d .ge. dmin) go to 4
           d=d+(v-xy(j-1))**2
           if(d.lt.dmin) then
           dmin=d
           endif
5          continue
4      continue
       d=dmin
       sum=sum+d
       g(ij)=1.-exp(-dmin/.995)
      if(mod(ij,5).eq.0) then
9      write(3,23) ij,d,sum/ij,g(ij)
      print 23, ij,d,sum/ij,g(ij)
      endif
23           format(i12,f10.4,f9.4,f12.6)
345     continue
      write(3,35) filename
      print 35,filename
35       format('     MINIMUM DISTANCE TEST for ',a15)
      write(3,445)
      print 445
445   format(10x,'Result of KS test on 20 transformed mindist^2''s:')
      call kstest(g,ns,p)
      write(3,31) p
      print 31,p
31       format(10x,'                        p-value=',f8.6)
      write(3,409)
      print 409
409   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
     &',/)
      jkk=jkreset()
      return
      end

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
      entry jkreset()
      jk=1
      jkreset=1
      end
      subroutine runtest(filename)
      real x(10000),up(100),dn(100)
      character*25 filename
c**** up and down runs test******************
      ch(x)=1.-exp(-.5*x)*(1.+.5*x+.125*x**2)
      ns=10
      nxs=10000
      jkk=jkreset()
      write(3,2181) filename
      print 2181,filename
2181  format('           The RUNS test for file ',a15,/,
     & '     Up and down runs in a sample of 10000',/,
     &'_________________________________________________ ')
      do 93 ijkn=1,2
1     do 3 ij=1,ns
      do 2 i=1,nxs
2     x(i)=jtbl()*2.328306e-10
      call udruns(x,nxs,uv,dv,ifault)
      up(ij)=ch(uv)
      dn(ij)=ch(dv)
3      continue
      call kstest(up,ns,p)
      print 234,filename
      write(3,234) filename
234   format(15x'  Run test for ',a15,':')
      write(3,812) p
      print 812,p
812   format(4x,'   runs up; ks test for 10 p''s:',f8.6)
      call kstest(dn,ns,p)
      write(3,813) p
      print 813,p
813   format(4x,' runs down; ks test for 10 p''s:',f8.6)
93    continue
      jkk=jkreset()
      print 489
      write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      end
      subroutine udruns(x,n,uv,dv,ifault)
C     Algorithm AS 157 Appl. Statist. (1981) vol. 30, No. 1
C     The Runs-up and Runs-down test.
      integer ucount, dcount, ru, rd
      dimension x(10000), a(6,6), b(6), ucount(6), dcount(6)
C     Set up the A and B matrices.
      data
     * a(1,1), a(1,2), a(1,3), a(1,4), a(1,5), a(1,6),
     * a(2,2), a(2,3), a(2,4), a(2,5), a(2,6),
     * a(3,3), a(3,4), a(3,5), a(3,6),
     * a(4,4), a(4,5), a(4,6), a(5,5), a(5,6), a(6,6)
     */4529.4, 9044.9, 13568., 18091., 22615., 27892., 18097.,
     * 27139., 36187., 45234., 55789., 40721., 54281., 67852.,
     * 83685., 72414., 90470., 111580., 113262., 139476.,
     * 172860./
      ifault = 0
      if (n .lt. 4000) goto 500
      do 1 j= 2,6
        j1 = j-1
        do 1 i=1,j1
          a(j,i) = a(i,j)
 1    continue
      b(1) = 1./6.
      b(2) = 5./24.
      b(3) = 11./120.
      b(4) = 19./720.
      b(5) = 29./5040.
      b(6) = 1./840.
      do 100 i = 1,6
          ucount(i) = 0
          dcount(i) = 0
 100  continue
C     The loop that ends at line 300 determines the number of
C     runs-up and runs-down of length i for i = 1(1)5 and the number
C     of runs-up and runs-down of length greater than or equal to 6.
      ru = 1
      rd = 1
      do 300 j=2,n
      if (x(j) - x(j-1)) 150, 600, 200
 600  uni=.4
      if(uni.lt..5)  then
      go to 150
      else
      go to 200
      end if
 150  ucount(ru) = ucount (ru) + 1
      ru = 1
      if(rd.lt.6) rd = rd+1
      goto 300
 200  dcount(rd) = dcount(rd) + 1
      rd = 1
      if (ru.lt.6) ru= ru + 1
 300  continue
      ucount(ru) = ucount(ru) + 1
      dcount(rd) = dcount(rd) + 1
c      print 21,ucount,dcount
 21   format(1x,6i5,i10,6i5)
C     Calculate the test statistics uv and dv.
      uv = 0.
      dv = 0.
      rn = float(n)
      do 400 i=1, 6
          do 400 j= 1,6
              uv = uv + (float(ucount(i)) - rn*b(i)) *
     *             (float(ucount(j)) - rn * b(j)) * a(i,j)
              dv = dv + (float(dcount(i)) - rn*b(i)) *
     *             (float(dcount(j)) - rn * b(j)) * a(i,j)
 400  continue
      uv = uv /rn
      dv = dv/rn
      goto 700
 500  ifault = n
 700  return
      end
               subroutine craptest(filename)
       real e(21)
       integer nt(21)
       character*25 filename
       parameter(cc=6.*.5**32)
       kthrow()=2+int(cc*jtbl()+3.)+int(cc*jtbl()+3.)
       jkk=jkreset()
       e(1)=1./3.
       sum=e(1)
       do 3 k=2,20
       e(k)=(27.*(27./36.)**(k-2)+40.*(26./36.)**(k-2)
     & +55.*(25./36.)**(k-2))/648.
3      sum=sum+e(k)
       e(21)=1.-sum
       ng=200000
       nwins=0
       do 2 i=1,21
2      nt(i)=0
       do 7 i=1,ng
      lp=kthrow()
      nthrows=1
      if(lp.eq.7 .or. lp.eq.11) then
        iwin=1
        goto 444
      end if
      if(lp.eq.2 .or. lp.eq.3 .or. lp.eq.12) then
         iwin=0
         goto 444
      endif
4       k=kthrow()
        nthrows=nthrows+1
        if(k.eq.7) then
          iwin=0
          goto 444
        end if
        if(k.eq.lp) then
           iwin=1
           goto 444
        endif
       go to 4
444     m=min(21,nthrows)
       nt(m)=nt(m)+1
7      nwins=nwins+iwin
       av=244.*ng/495.
       sd=sqrt(av*251./495.)
       t=(nwins-av)/sd
       print 2345,filename
       write(3,2345) filename
2345   format(15x,' Results of craps test for ',a15,/,
     &'  No. of wins:  Observed Expected')
       print 546,nwins,av
       write(3,546) nwins,av
546    format(15x,'          ',i12,f12.2)
       pwins=phi(t)
       print 25,nwins,t,pwins
       write(3,25) nwins,t,pwins
25     format(15x,i8,'= No. of wins, z-score=',f6.3,' pvalue=',f7.5,/,
     &'   Analysis of Throws-per-Game:')
       sum=0.
       do 8 i=1,21
       ex=ng*e(i)
8      sum=sum+(nt(i)-ex)**2/ex
       pthrows=chisq(sum,20)
       write(3,24) sum,pthrows
       print 24,sum,pthrows
24     format(' Chisq=',f7.2,' for 20 degrees of freedom, p=',f8.5,/,
     &15x,'Throws Observed Expected  Chisq     Sum')
       sum=0
       do 9 i=1,21
       ex=ng*e(i)
       sum=sum+(nt(i)-ex)**2/ex
       write(3,23) i,nt(i),ex,(nt(i)-ex)**2/ex,sum
9      print 23,i,nt(i),ex,(nt(i)-ex)**2/ex,sum
23     format(i19,i9,f11.1,f8.3,f9.3)
       write(3,2346) filename
       print 2346,filename
2346   format('            SUMMARY  FOR ',a15)
       write(3,77) pwins
       print 77,pwins
77     format(15x,' p-value for no. of wins:',f8.6)
       write(3,78) pthrows
       print 78,pthrows
78     format(15x,' p-value for throws/game:',f8.6)
       jkk=jkreset()
        print 489
        write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
       end


            SUBROUTINE CDOMSO(filename)
C***** NUMBER OF MISSING WORDS IN A STRING OF 2**21 k-LETTER WORDS,****
C***** EACH LETTER 20/k BITS. THERE ARE 2**20 POSSIBLE WORDS**************
C***** EACH OF THE 32 BITS IN THE 2**15 W-TABLE IDENTIFIES A WORD*******
c******** mean should be 141,909 with sigma=290
      INTEGER W(0:32767),MBIT(0:31)
       real sigs(3)
       character*4 ctest(3)
       character*25,filename
       data ctest/'OPSO','OQSO',' DNA'/
       data sigs/290.,295.,339./
C** ONE-LINE FUNCTION TO GENERATE 5-BIT LETTER IN CONVENIENT POSITION
          ikbit()=and(rshift(jtbl(),kr),mk)
                  j=1232456789
                  do 879 i=1,1000000
879               j=69069*j
       do 2001 jk=1,3
       k=2*jk
       if(jk.eq.3) k=10
       index=(73-(k-9)**2)/24
      print*,ctest(index),' test for generator ',filename
      print*,' Output: No. missing words (mw), equiv normal variate (z),
     & p-value (p)'
      print*,'
     &mw     z     p'
      write(3,*) ctest(index),' test for generator ',filename
      write(3,*)' Output: No. missing words (mw), equiv normal variate (
     &z), p-value (p)'
      write(3,*)'
     &   mw     z     p'
        ntries=1
        kpow=21
       do 2001 krk=33-20/k,1,-1
      jkk=jkreset()
       kr=33-20/k-krk
       mk=2**(20/k)-1
       mkk=2**(20-20/k)-1
       lk=20/k
        do 2001 kij=1,ntries
        kpow=21
C                                  ****SET MASK BITS***************
                                      MBIT(0)=1
                                      DO 8 I=1,31
8                                     MBIT(I)=2*MBIT(I-1)
c*********** INITIALIZE*****************
       TRUE=2**20*EXP(-2.**(KPOW-20))
C*****MAIN LOOP*********
      DO 2 NT=1,NTRIES
C                  ********SET W-TABLE TO ZEROS*******
                           DO 9 I=0,32767
9                          W(I)=0
C**** GET INITIAL WORD
         j=ikbit()
         do 46 i=1,k-1
46       j=2**(20/k)*j+ikbit()
C****  GENERATE 2**kpow OVERLAPPING WORDS********
             DO 3 IC=1,2**KPOW
C         *** GET NEW J *****
              j=lshift(and(j,mkk),lk)+ikbit()
C         *** GET BIT INDEX FROM LAST 5 BITS OF J  ***
             L=AND(J,31)
C         *** GET TABLE INDEX FROM LEADING 15 BITS OF J***
             Kk=rSHiFT(J,5)
C         *** SET BIT L IN W(Kk) ***
3           W(Kk)=OR(W(Kk),MBIT(L))
C                    ********** COUNT NUMBER OF EMPTY CELLS *******
                      KOUNT=0
                      DO 4 kk=0,32767
                      DO 4 L=0,31
4                     IF(AND(W(kk),MBIT(L)).EQ.0) KOUNT=KOUNT+1
C ****END OF MAIN LOOP****
      x=(kount-true)/sigs(jk)
      write(3,22) ctest(index),filename,33-20/k-kr,32-kr,KOUNT,x,phi(x)
2     PRINT 22,ctest(index),filename,33-20/k-kr,32-kr,KOUNT,x,phi(x)
22    format(a8,' for ',a15,' using bits ',i2,
     &' to ',i2,i14,f7.3,f7.4)
          jkk=jkreset()
2001   continue
        print 489
        write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      END

        subroutine base5(w)
        integer w,L(0:4)
        j=w
        do 2 i=4,0,-1
        L(i)=mod(j,5)
2       j=j/5
        print 21,w,L
21      format(i12,i3,4i1)
        return
        end
          subroutine wknt1s(filename)
c            OBC: overlapping-bit-count in specified bytes
      integer*4 w,t(0:3124),s(0:624),k(0:255),p(0:4)
      character*25 filename
      data p/37,56,70,56,37/
      data k/
     &0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,2,0,0,0,1,0,1,1,2,0,1,1,2,1,2,2,3,
     &0,0,0,1,0,1,1,2,0,1,1,2,1,2,2,3,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,
     &0,0,0,1,0,1,1,2,0,1,1,2,1,2,2,3,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,
     &0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,4,
     &0,0,0,1,0,1,1,2,0,1,1,2,1,2,2,3,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,
     &0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,4,
     &0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,4,
     &1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,4,2,3,3,4,3,4,4,4,3,4,4,4,4,4,4,4/
c******one-line function to return no. of 1's in 8 random bits
c******that is, this function provides a random keystoke, unequal p's.
        m8()=k(and(rshift(jtbl(),25-jk),255))
        n=10
      print 2345, filename
2345   format('   Test results for ',a15)
      do 888 jk=1,25
      jkk=jkreset()
      do 64 i=0,624
64     s(i)=0
      do 65 i=0,3124
65     t(i)=0
c***** generate initial word with 5 random keystrokes:
127     w=625*m8()+125*m8()+25*m8()+5*m8()+m8()
      do 2 i1=1,25600
      do 2 i2=1,n
c******Erase leftmost letter of w:
      w=mod(w,5**4)
c******Boost count for that 4-letter word:
      s(w)=s(w)+1
c******Shift w left, add new letter, boost 5-letter word count:
      w=5*w+m8()
      t(w)=t(w)+1
2     continue
c****  Find q4: sum(obs-exp)**2/exp for 4-letter words
      q4=0
      do 4 ii=0,5**4-1
      i=ii
      e=25600*n
      do 41 j=1,4
      e=e*p(mod(i,5))*2.**(-8)
41     i=i/5
4      q4=q4+(s(ii)-e)**2/e
c****  Find q5: sum(obs-exp)**2/exp for 5-letter words
      q5=0
      do 5 ii=0,5**5-1
      i=ii
      e=25600*n
      do 51 j=1,5
      e=e*p(mod(i,5))*2.**(-8)
51    i=i/5
5      q5=q5+(t(ii)-e)**2/e
      chsq=q5-q4
      z=(chsq-2500.)/sqrt(5000.)
      if(jk.eq.1) then
      write(3,819) 25600*n
      print 819,25600*n
819   format(' Chi-square with 5^5-5^4=2500 d.of f. for sample size:',
     &i7,/,9x,'             chisquare  equiv normal  p value')
      print*,'  Results for COUNT-THE 1''s in specified bytes:'
      write(3,*)' Results for COUNT-THE-1''s in specified bytes:'
      endif
      write(3,821) jk,jk+7,chsq,z,phi(z)
      print 821,jk,jk+7,chsq,z,phi(z)
821    format('           bits ',i2,' to ',i2,f9.2,f11.3,f13.6)
888   jkk=jkreset()
      print 489
      write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
      end
                subroutine cdbinrnk(filename)
c*******Test ranks of 100,000 6x8 binary matrices**************
c*******Each row a byte from a RNG, overlapping rows*************
      real p(2:6),pp(0:25)
      character*25 filename
      character *6 rk(4:6)
      integer r(6),k(2:6),rankb
      data rk/' r<=4 ',' r =5 ',' r =6'/
      data p/0.149858E-06,0.808926E-04,0.936197E-02,0.2 17439,0.773118/
c*** rank 2 to 6 with prob p(2),...,p(6); 2,3,4 pooled.
c************ one-line function to get random byte:*************
         i8bit()=and(rshift(jtbl(),kr),255)
       write(3,37) filename
       print 37,filename
37     format('         Binary Rank Test for ',a15)
371    format('        Rank of a 6x8 binary matrix,',/,
     &'     rows formed from eight bits of the RNG ',a15)
       do 55 ij=25,1,-1
      jkk=jkreset()
       print 371, filename
       write(3,371) filename
       kr=ij-1
               do 88 kk=2,6
88             k(kk)=0
       print 27,25-kr,32-kr
       write(3,27) 25-kr,32-kr
27     format('     b-rank test for bits ',i2,' to ',i2)
       print 372
       write(3,372)
372    format(15x,'      OBSERVED   EXPECTED     (O-E)^2/E      SUM')
      do 2 L=1,100000
             do 1 i=1,6
1           r(i)=i8bit()
      mr=max(4,rankb(r,6,8))
2      k(mr)=k(mr)+1
       s=0
       do 5 L=4,6
          if(L.gt.4) then
          E=100000*p(L)
          else
          E=100000*(p(2)+p(3)+p(4))
          end if
          t=(k(L)-E)**2/E
       s=s+t
       write(3,29) rk(L),k(L),E,(k(L)-E)**2/E,s
5      print 29,rk(L),k(L),E,(k(L)-E)**2/E,s
29     format(6x,a9,i12,f12.1,f12.3,f12.3)
        pp(kr)=1.-exp(-s/2)
        print 23,pp(kr)
        write(3,23) pp(kr)
55     jkk=jkreset()
23     format(12x,'            p=1-exp(-SUM/2)=',f7.5)
       print 373
       write(3,373)
373   format('   TEST SUMMARY, 25 tests on 100,000 random 6x8 matrices'
     &,/,' These should be 25 uniform [0,1] random variables:')
       print 21,(pp(i),i=24,0,-1)
       write(3,21) (pp(i),i=24,0,-1)
21     format(5f12.6)
        call asort(pp(0),25)
        print 2345,filename
        write(3,2345) filename
2345    format('   brank test summary for ',a15,/,
     &'       The KS test for those 25 supposed UNI''s yields')
        call kstest(pp(0),25,pks)
        print 31,pks
       write(3,31) pks
31     format('                    KS p-value=',f8.6)
       print 312
312    format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
       write(3,312)
       return
       end
       function rankb(r,m,n)
       implicit integer(a-z)
       integer r(31),msk(31)
      data msk/1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,
     &32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,
     &16777216,33554432,67108864,134217728,268435456,536870912,
     & 1073741824/
       rankb=0
       j=n
       i=1
33          do 3 ii=i,m
          if(and(r(ii),msk(j)).eq.msk(j)) then
          x=r(ii)
          r(ii)=r(i)
          r(i)=x
               do 13 k=i+1,m
13           if(and(r(k),msk(j)).eq.msk(j)) r(k)=xor(r(k),x)
            rankb=rankb+1
           if(i.eq.m .or. j.eq.1) return
           j=j-1
           i=i+1
           go to 33
          endif
3       continue
         j=j-1
         if(j.eq.0) return
         go to 33
            end
        subroutine rank3132(filename)
c see original file \f\bprint.for that displays each step in the
c  rank reduction.
c  finds rank of 31x31 and 32x32 matrices.
c For the 31x31, uses 31 leftmost bits of a 32-bit integer
c to form a row of the binary matrix.
c For the 32x32, uses 32 full integer words for each of 32 rows
c      function mrank(r,m,n)
c   for nxn matrices, to at least 6 places,
c  the probability of rank n-2,n-1,n are all virtually the same.
c    r          p
c  <=29    .0052854502
c    30    .1283502644
c    31    .5775761902
c    32    .2887880952
cc**** Finds binary rank of m rows, n trailing bits each**********
      integer row(32),rank,tbl(0:3)
      real p(0:3)
      character*25 filename
      data p/.2887880952,.5775761902,.1283502644,.0052854502/
11       do 999 m=31,32
       jkk=jkreset()
       n=m
       print 2345,filename
       write(3,2345) filename
2345   format('    Binary rank test for ',a15)
       print 29,m,n
       write(3,29) m,n
29    format(7x,'  Rank test for ',i2,'x',i2,' binary matrices:')
       print 291,m
       write(3,291) m
291   format(7x,' rows from leftmost ',i2,
     &' bits of each 32-bit integer')
          do 71 i=0,3
71        tbl(i)=0
9        ntries=40000
       do 888 ij=1,ntries
         do 42 i=1,m
42       row(i)=rshift(jtbl(),32-m)
       ntry=ntry+1
       k=min(n-rank(row,m,n),3)
       tbl(k)=tbl(k)+1
888    continue
       s=0
       print 2457
       write(3,2457)
2457   format('      rank   observed  expected (o-e)^2/e  sum')
       do 7 i=3,0,-1
        e=p(i)*ntries
        d=(tbl(i)-e)**2/e
        s=s+d
        write(3,22) n-i,tbl(i),e,d,s
7       print 22,n-i,tbl(i),e,d,s
22     format(2i10,f10.1,f10.6,f9.3)
       print 23,s,chisq(s,3)
       write(3,23) s,chisq(s,3)
23    format('  chisquare=',f6.3,' for 3 d. of f.; p-value=',f8.6,/,
     &'--------------------------------------------------------------')
       jkk=jkreset()
999    continue
      jkk=jkreset()
       jkk=jkreset()
       print 2348
       write(3,2348)
2348   format(/,
     &'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
       return
       end
       function rank(r,m,n)
       implicit integer(a-z)
       integer r(32),msk(32)
      data (msk(i),i=1,30)/1,2,4,8,16,32,64,128,256,512,1024,2048,4096,
     & 8192,16384,32768,65536,131072,262144,524288,1048576,2097152,
     & 4194304,8388608,16777216,33554432,67108864,134217728,268435456,
     & 536870912/
       msk(31)=2*msk(30)
       msk(32)=65536*32768
       rank=0
       j=n
       i=1
33     continue
c33        call mprint(r,m,n)
c*****   find row that starts with a 1 in current column (33-j)
          do 3 ii=i,m
          if(and(r(ii),msk(j)).eq.msk(j)) then
          x=r(ii)
          r(ii)=r(i)
          r(i)=x
               do 13 k=i+1,m
13           if(and(r(k),msk(j)).eq.msk(j)) r(k)=xor(r(k),x)
            rank=rank+1
c           print*,' good row',rank,i,x
           if(i.eq.m .or. j.eq.1) return
           j=j-1
           i=i+1
           go to 33
          endif
3       continue
         j=j-1
         if(j.eq.0) return
         go to 33
         end

            subroutine cdbday(filename)
c          PROGRAM BDAYTST
C A PROGRAM TO DO  THE BIRTHDAY-SPACINGS TEST ON NBITS OF A UNI
      INTEGER B(4096),C(4096),MSPACE(1000)
      real pks(64)
      character*25 filename
       inbits()=and(rshift(jb,kr),mask)
       lw=32
       nbits=24
       m=512
       nsampl=500
      ALAM=(m+0.)**3/2d0**(nbits+2)
      print 22, M,NBITS,ALAM
      write(3,22) M,NBITS,ALAM
      write(3,2345) filename
      print 2345,filename
2345  format('           Results for ',a15)
22    FORMAT(' BIRTHDAY SPACINGS TEST, M=',I4,' N=2**',I2,
     &' LAMBDA=',F8.4)
c      is=lw-nbits
      is=8
      mask=2**(nbits-1)+2**(nbits-1)-1
      do 2001 kr=32-nbits,0,-1
      s=0.
      jkk=jkreset()
      DO 1 J=1,NSAMPL
      DO 2 I=1,M
        jb=jtbl()
2      b(i)=inbits()
9        CALL ISORT(B,M)
         C(1)=B(1)
         DO 3 I=2,M
3         C(I)=B(I)-B(I-1)
         CALL ISORT(C,M)
         L=0
         DO 4 I=2,M
         lk=0
         IF(C(I).ne.C(I-1)) go to 4
         lk=lk+1
         L=L+1
4       continue
        s=s+L
1        MSPACE(J)=L
      write(3,432) nsampl
      print 432,nsampl
       write(3,331) filename,33-nbits-kr,32-kr,s/nsampl
       print 331,filename,33-nbits-kr,32-kr,s/nsampl
331     format(10x,a16,' using bits ',i2,' to ',i2,f8.3,f10.6)
432     format(17x,'  For a sample of size',i4,':     mean   ')
        CALL CHSQTS(ALAM,MSPACE,NSAMPL,pp)
        pks(9-kr)=pp
        jkk=jkreset()
2001    continue
        print 652, (pks(im),im=1,9)
        write(3,652) (pks(im),im=1,9)
652   format('   The 9 p-values were',/,f15.6,4f10.6,/,f15.6,4f10.6)
        call kstest(pks,9,pp)
        print 38,pp
        write(3,38) pp
38    format('  A KSTEST for the 9 p-values yields ',f8.6)
        print 489
       write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
       return
       end
C  A SUBROUTINE TO DO A CHISQUARE TEST ON N VALUES FROM
C   A DISCRETE DISTRIBUTION.  SET UP FOR POISSON.  CHANGE P'S FOR OTHERS.
C  REQUIRES ARRAY MSPACE(NSAMPL) THAT GIVES NO. OF DUPLICATE SPACINGS
C  IN EACH OF NSAMPL YEARS.
       SUBROUTINE CHSQTS(LAMBDA,MSPACE,NSAMPL,pp)
      INTEGER K(0:500),MSPACE(1000)
      REAL LAMBDA,EX(0:500),OBS(0:500),PS(0:500)
      DO 18 I=0,LAMBDA+4*SQRT(LAMBDA)
      EX(I)=0
      K(I)=0
 18   PS(I)=0
      P=EXP(-LAMBDA)
      PS(0)=P*NSAMPL
      K(0)=0
      J=0
      S=P*NSAMPL
      IF(S.GT.5.) THEN
      J=1
      EX(0)=S
      S=0.
      END IF
      DO 2 I=1,LAMBDA+4*SQRT(LAMBDA)
      P=LAMBDA*P/I
      PS(I)=PS(I-1)+P*NSAMPL
      S=S+P*NSAMPL
      K(I)=J
      IF(PS(I).GT.NSAMPL-5 ) THEN
      EX(J)=S+NSAMPL-PS(I)
          do 874 L=i+1,nsampl
874       K(L)=j
      GO TO 12
      END IF
      IF(S.LT.5.) GO TO 2
      EX(J)=S
      J=J+1
      S=0.
  2   CONTINUE
 12    DO 42 I=0,100
  42   OBS(I)=0.
      DO 43 I=1,NSAMPL
      L=K(MSPACE(I))
 43   OBS(L)=OBS(L)+1
      S=0.
      DO 44 M=0,J
  44  S=S+(OBS(M)-EX(M))**2/EX(M)
      lb=0
      m=k(0)
      write(3,*) ' duplicate ','      number       number '
      write(3,*) ' spacings  ','     observed     expected'
      print*, ' duplicate ','      number       number '
      print*, ' spacings  ','     observed     expected'
      do 62 i=1,100
      if(k(i).eq.m) go to 62
      lt=i-1
      if(lb.ne.lt) print 28, lb,lt,obs(m),ex(m)
      if(lb.ne.lt) write(3,28) lb,lt,obs(m),ex(m)
 28   format(' ',i2,' to ',i2,f13.0,f13.3)
      if(lb.eq.lt) print 29, lb,obs(m),ex(m)
      if(lb.eq.lt) write(3,29) lb,obs(m),ex(m)
 29   format(3x,i6,f13.0,f13.3)
      m=k(i)
      lb=i
      if(m.eq.j) go to 63
  62  continue
  63  print 27, lb,obs(m),ex(m)
      write(3,27) lb,obs(m),ex(m)
  27  format(' ',i2,' to INF',f12.0,f13.3)
      pp=chisq(s,j)
       print 31, j,s,pp
      write(3,31) j,s,pp
  31  format(' Chisquare with ',i2,' d.o.f. = ',f8.2,' p-value= ',f8.6)
      write(3,*) ' :::::::::::::::::::::::::::::::::::::::::'
      print*, ' :::::::::::::::::::::::::::::::::::::::::'
c      print 32,pp
c      write(3,32) pp
c  32  format(' UNI = ',f8.5,' (Probability of a better fit.)')
      RETURN
      END
            subroutine cdosum(filename)
      real x(100),y(100),t(199),u(100),w(10),f(0:100)
      character*25 filename
      data f/0.,
     &.0017,.0132,.0270,.0406,.0538,.0665,.0787,.0905,.1020,.1133,
     &.1242,.1349,.1454,.1557,.1659,.1760,.1859,.1957,.2054,.2150,
     &.2246,.2341,.2436,.2530,.2623,.2716,.2809,.2902,.2995,.3087,
     &.3180,.3273,.3366,.3459,.3552,.3645,.3739,.3833,.3928,.4023,
     &.4118,.4213,.4309,.4406,.4504,.4602,.4701,.4800,.4900,.5000,
     &.5100,.5199,.5299,.5397,.5495,.5593,.5690,.5787,.5882,.5978,
     &.6073,.6167,.6260,.6354,.6447,.6540,.6632,.6724,.6817,.6910,
     &.7003,.7096,.7189,.7282,.7375,.7468,.7562,.7657,.7752,.7848,
     &.7944,.8041,.8140,.8239,.8340,.8442,.8545,.8650,.8757,.8867,
     &.8980,.9095,.9214,.9337,.9464,.9595,.9731,.9868,.9983, 1./
      uni()=jtbl()*.806549e-9
       m=100
      jkk=jkreset()
       
11       do 89       ik=1,10
      qmax=0
      do 88 ij=1,100
      s=0.
      do 2 i=1,199
       t(i)=uni()
2     if(i.le. m) s=s+t(i)
      y(1)=s
      do 3 j=2,m
3     y(j)=y(j-1)-t(j-1)+t(m+j-1)
c***now y(j)=z(j)+...+z(99+j)
c*** They are virtually normal, mean 0, variance 100, but correlated.
c**** Now a matrix transformation of the y's: x=yM, will make the
c*** x's independent normal.
c***The y's covariance matrix T is Toeplitz with diagonals 100,99,...2,1
c***A Cholesky factorization of T: V'V=T provides M=V^(-1).  The
c***covariance of x=yM is M'TM=I.
c*** The columns of M have at most 3 non-zero elements.
      x(1)=y(1)/sqrt(m+0.)
      x(2)=-(m-1.)*y(1)/sqrt(m*(m+m-1.))+y(2)*sqrt(m/(m+m-1.))
      qq=x(1)**2+x(2)**2
      do 4 i=3,m
      a=m+m+2-i
      b=4*m+2-i-i
      x(i)=y(1)/sqrt(a*b)-sqrt((a-1.)/(b+2.))*y(i-1)+sqrt(a/b)*y(i)
4     qq=qq+x(i)**2
c****now the x's are a bunch of iid rnors with mean 0, variance 1.
c***Does sum(x(i)^2) behave as chisquare with m deg. freedom?
c****now convert  x(1),...,x(m) to uni's.
       do 7 i=1,m
       p=phi(x(i))
       h=100.*p
       j=h
7      x(i)=f(j)+(h-j)*(f(j+1)-f(j))
c***test to see if the transformed x's are uniforms.
       call kstest(x,m,p)
88     u(ij)=p
c***Now do a KSTEST on the 100 p's from the tests for normality.
       call kstest(u,100,pk)
c***And a KSTEST on the 100 p's from the chisquare tests.
c       call kstest(uu,100,pq)
       w(ik)=pk
c       uq(ik)=pq
       print 39, ik,pk
89      write(3,39) ik,pk
      write(3,2345) filename
      print 2345,filename
2345  format('   Results of the OSUM test for ',a15)
39     format(15x,' Test no. ',i2,'      p-value ',2f8.6)
c     &'  Q p-value ',f8.6)
       call kstest(w,10,p)
c      call kstest(uq,10,pq)
       write(3,27) p
       print 27,p
27     format(7x,' KSTEST on the above 10 p-values: ',2f8.6)
       jkk=jkreset()
        print 489
        write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
       end
c********dummy line
c********dummy line
c********dummy line

         function jtbl8()
         integer  b(4096),nleft
         data j,nleft,jk/4097,0,1/
         if(j.gt.4096) then
         read(1,rec=jk) b
         j=1
         jk=jk+1
         endif
            if(nleft.eq.0) then
            k=b(j)
            j=j+1
            nleft=4
            endif
            jtbl8=and(rshift(k,24),255)
            k=lshift(k,8)
            nleft=nleft-1
            return
         end

          subroutine sknt1s(filename)
c            OBC: overlapping-bit-count from stream of bytes
      integer*4 w,t(0:3124),s(0:624),kbits(0:255),p(0:4)
      character*25 filename
      character*80 text(18)
      data p/37,56,70,56,37/
c******one-line function to return (truncated) no. of 1's in 8 random bits
c******that is, this function provides a random keystoke, unequal p's.
        m8()=kbits(jtbl8())
       open(4,file='tests.txt')
       read(4,766) (dum,j=1,113)
       read(4,766) (text(j),j=1,18)
       print 766,(text(j),j=1,18)
       write(3,766) (text(j),j=1,18)
766    format(a80)
       close(4)
c******Create kbits table: kbits(j)=truncated no of bits in j, -128<=j<=127
c****Filename reads one byte at a time, as integer*1, so -128 to 127*****
             do 234 jj=0,255
                j=jj
                ks=0
                do 233 i=1,8
                ks=ks+and(j,1)
233             j=rshift(j,1)
                if(ks.lt.2) ks=2
                if(ks.gt.6) ks=6
234           kbits(jj)=ks-2
        n=100
      jkk=jkreset()
       write(3,2345) filename
       print 2345, filename
2345   format('   Test results for ',a15)
       do 888 jk=1,2
        do 64 i=0,5**4-1
64     s(i)=0
       do 65 i=0,5**5-1
65     t(i)=0
c***** generate initial word with 5 random keystrokes:
127       w=5**4*m8()+5**3*m8()+5**2*m8()+5*m8()+m8()
       do 2 i2=1,n
       do 2 i1=1,25600
c******Erase leftmost letter of w:
       w=mod(w,5**4)
c******Boost count for that 4-letter word:
       s(w)=s(w)+1
c******Shift w left, add new letter, boost 5-letter word count:

        w=5*w+m8()
        t(w)=t(w)+1
2       continue
c****  Find q4: sum(obs-exp)^2/exp for 4-letter words
       q4=0
       do 4 ii=0,5**4-1
       i=ii
       e=25600*n
           do 41 j=0,3
           e=e*p(mod(i,5))/256.
41         i=i/5
4       q4=q4+(s(ii)-e)**2/e
c****  Find q5: sum(obs-exp)^2/exp for 5-letter words
       q5=0
       do 5 ii=0,5**5-1
       i=ii
       e=25600*n
           do 51 j=0,4
        e=e*p(mod(i,5))/256.
51         i=i/5
5      q5=q5+(t(ii)-e)**2/e
       chsq=q5-q4
       z=(chsq-2500.)/sqrt(5000.)
       if(jk.eq.1) then
       print 819,25600*n
       write(3,819) 25600*n
819   format(' Chi-square with 5^5-5^4=2500 d.of f. for sample size:',
     &i7,/,31x,'chisquare  equiv normal  p-value')
      print*,'  Results for COUNT-THE-1''s in successive bytes:'
      write(3,*)' Results fo COUNT-THE-1''s in successive bytes:'
       endif
       write(3,821) filename,chsq,z,phi(z)
       print 821,filename,chsq,z,phi(z)
821    format(' byte stream for ',a15,f9.2,f11.3,f13.6)
888     continue
        jkk=jkreset()
        print 489
        write(3,489)
489   format(/,'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$',/)
      return
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

      subroutine isort(list, n)
      integer list(n),t,tt
      dimension iu(33), il(33)
      m=1
      i=1
      j=n
5      if(i.ge.j) goto 70
10      k=i
      ij= (i+j)/2
      t= list(ij)

      if(list(i).le.t) goto 20
      list(ij)= list(i)
      list(i)= t
      t= list(ij)
20      l=j
      if(list(j).ge.t) goto 40
      list(ij)= list(j)
      list(j)= t
      t= list(ij)
      if(list(i).le.t) goto 40
      list(ij)= list(i)
      list(i)= t
      t= list(ij)
      goto 40
30      list(l)= list(k)
      list(k)=tt
40      l=l-1
      if(list(l).gt.t) goto 40
      tt= list(l)
50      k= k+1
      if(list(k).lt.t) goto 50
      if(k.le.l) goto 30
      if(l-i.le.j-k) goto 60
      il(m)=i
      iu(m)=l
      i=k
      m=m+1
      goto 80
60      il(m)=k
      iu(m)=j
      j=l
      m=m+1
      goto 80
70      m=m-1
      if(m.le.0) return
      i=il(m)
      j=iu(m)
80      if(j-i.ge.11) goto 10
      if(i.eq.1) goto 5
      i=i-1
90      i=i+1
      if(i.eq.j) goto 70
      t= list(i+1)
      if(list(i).le.t) goto 90
      k=i
100      list(k+1)=list(k)
      k=k-1
      if(t.lt.list(k)) goto 100
      list(k+1)=t
      goto 90
      end

       subroutine dsort(list, n)
       real*8 list(n),t,tt
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


      function Phi(x)
      implicit real*8(a-h,o-z)
      real*4 x,phi
      real*8 v(0:14)
      data v/
     &1.253314137315500d0,.6556795424187985d0,.4213692292880545d0,
     &.3045902987101033d0,.2366523829135607d0,.1928081047153158d0,
     &.1623776608968675d0,.1401041834530502d0,.1231319632579329d0,
     &.1097872825783083d0,.9902859647173193d-1,.9017567550106468d-1,
     &.8276628650136917d-1,.764757610162485d-1,.7106958053885211d-1/
      phi=.5+sign(.5,x)
      if(abs(x).gt.7) return
      cPhi=.5d0-sign(.5d0,x)
      j=abs(x)+.5d0
      j=min(j,14)
      z=j
      h=abs(x)-z
      a=v(j)
      b=z*a-1d0
      pwr=1d0
      sum=a+h*b
      do 2 i=2,24-j,2
      a=(a+z*b)/i
      b=(b+z*a)/(i+1)
      pwr=pwr*h**2
2     sum=sum+pwr*(a+h*b)
      cPhi=sum*dexp(-.5d0*x*x-.918938533204672d0)
      phi=1d0-cphi
      if(x.lt.0d0) phi=cPhi
      return
      end
      FUNCTION CHISQ (X,N)
      CHISQ = 0.
      IF (X.LE.0.) RETURN
      IF (N.GT.20) THEN
            T = ((X/N)**.33333 - 1 + (.22222/N)) / SQRT(.22222/N)
            CHISQ = PHI(min(t,8.))
            RETURN
      ENDIF
      L = 4 - MOD(N,2)
      D = MIN0(1,N/3)
      DO 2 I=L,N,2
            D = D*X/(I-2)
            CHISQ = CHISQ + D
2      CONTINUE
      IF (L.EQ.3) then
       S = SQRT(AMIN1(.5*X,50.))
      CHISQ=PHI(S/.7071068)-EXP(-MIN(.5*X,50.))*.564189*CHISQ/S
      return
      endif
      CHISQ = 1.-EXP(-AMIN1(.5*X, 50.))*(1.+CHISQ)
      return
      end
      subroutine cdoperm5(filename)
c*** overlapping 5-permutations.  Uses 120x120 weak inverse *******
c*** of covariance matrix (in 60x60 blocks).
c***  69069 passes, Randu fails, Weyl fails, SR(15,17),SR(13,18) fail.
c***  F(2,1,*) and F(3,1,*) pass
      integer r(60,60),s(60,60),t(120)
      integer u(1005)
      character*25 filename
c**** divide r and s elements by (200000*n) for proper cov. inverse
c****    the rank is 99=50+49.
       open(4,file='operm5d.ata')
       read(4,212) ((r(i,j),j=i,60),i=1,60)
       read(4,212) ((s(i,j),j=i,60),i=1,60)
212    format(8i10)
       close(4)
      jkk=jkreset()
      DO 8888 ijkm=1,2
       do 2 i=1,59
       do 2 j=i+1,60
       r(j,i)=r(i,j)
2      s(j,i)=s(i,j)
c**********************get counts t(1),...,t(120)******************
      n=1000
      do 11 i=1,120
11    t(i)=0
      do 4 i=1001,1005
4     u(i)=jtbl()
      do 5 i=1,n
            do 6 j=1,5
6           u(j)=u(1000+j)
                 do 7 j=1,1000
                 k=kp(u(j))+1
                 t(k)=t(k)+1
7                u(j+5)=jtbl()
5     continue
c*********************evalute quadratic form in weak inverse*******
       chsq=0.
       av=n*2000./120.
       do 3 i=1,60
       x=t(i)+t(i+60)-av
       y=t(i)-t(i+60)
       do 3 j=1,60
3      chsq=chsq+x*r(i,j)*(t(j)+t(j+60)-av)+y*s(i,j)*(t(j)-t(j+60))
       chsq=chsq/(2.e08*n)
       write(3,271) filename
       print 271,filename
271    format('           OPERM5 test for file ',a15,/,
     &'     For a sample of 1,000,000 consecutive 5-tuples,')
       write(3,273) chsq,chisq(chsq,99)
       print 273,chsq,chisq(chsq,99)
273    format(' chisquare for 99 degrees of freedom=',f7.3,'; p-value=',
     &f8.6)
8888  continue
      jkk=jkreset()
      return
       end
         function kp(c)
         integer map(0:59)
c         real b(5),c(5)
         integer b(5),c(5)
      data map/39,38,37,36,41,40,54,55,56,57,58,59,49,48,52,53,50,
     & 51,42,43,44,45,46,47,33,32,31,30,35,34,12,13,14,15,16,17,29,
     & 28,24,25,27,26,21,20,19,18,23,22,2,3,5,4,1,0,10,11,9,8,6,7/
         do 7 i=1,5
7        b(i)=c(i)
         kp=0
         do 2 i=5,2,-1
               t=b(1)
               L=1
               do 3 j=2,i
               if(b(j).lt.t) go to 3
               t=b(j)
               L=j
   3           continue
              kp=i*kp+L-1
              s=b(i)
              b(i)=b(L)
   2          b(L)=s
              if(kp.lt.60) kp=map(kp)
              return
              end




