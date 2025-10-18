        integer m(4096)
        character*1 dum
       character*15 ascfile,binfile
      print*,'  This program reads an ascii file of 32-bit integers'
      print*,'  and converts it to a binary file for use in DIEHARD.'
      print*,'      '
             print*,'  To continue, hit space ret'
             read 852,dum
 852  format( a1)          
      print*,'  You must first create the ascii file.  To do that,'
      print*,' generate your 32-bit integers and write them to a file,'
      print*,' in hex format, 80 characters (ten 32-bit integers) per'
      print*,' line.  For example, in Fortran, if your array is, say,'
      print*,' mran(5000), then the statements'
      print*,'            write(1,21) mran  '
      print*,'     21     format(10z8)'
      print*,' will cause your 5000 integers to be written to the'
      print*,' file designated unit 1.   Of course you must have first'
      print*,' opened that unit with a statement such as'
      print*,'             open(1,file=''whatever'')'
      print*,'      '
      print*,'  You must first create the ascii file.  To do that,'
             print*,'  To continue, hit space ret'
             read 852,dum
      print*,'  Since DIEHARD expects BIG files, you will get few'
      print*,'  results from a file of a mere 5000 integers.  You are'
      print*,'  presumably creating a file of random numbers to test,'
      print*,'  and you need about 2.9 million for DIEHARD.  This may'
      print*,'  be done with a double loop.  A (Fortran) program with'
      print*,'  this structure would do it:'
      print*,'             integer*4 m(4096)      '
      print*,'             open(1,file=''ascfile'') '
      print*,'             do 2 i=1,700           '
      print*,'                do 3 j=1,4096       '
      print*,'      3         m(j)=NEXTRANDOM32BIT     '
      print*,'      2      write(1,21)            '
      print*,'      21     format(10z8)           '
      print*,'             end                    '
      print*,'  OK, I assume you have created your ascii file. '
      print*,'  Now enter the name of that file (<=15 characters):'
      read 818, ascfile
       open(1,file=ascfile)
818   format(a15)
      print*,'  Next, enter the name of your binary file:'
      read 818, binfile
        open(2,file=binfile,form='unformatted',access='direct',
     & recl=16384)
       print*,'   Please wait...........'
         jk=0
              do 2 i=1,700
                 read(1,21) m
21       format(10z8)
          jk=jk+1
2             write(2,rec=jk) m
       print 23,binfile
5      close(2)
23     format( '  OK, binary file ',a15,' has been created.')
        end
