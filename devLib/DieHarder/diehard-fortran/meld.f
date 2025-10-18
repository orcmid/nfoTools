         integer b(4096),a(4096),c(4096)
         character*1 op
         character*15 file1,file2,file3
1      print*,' This program merges, via addition mod 2^32 or'
       print*,'  exclusive-or, the 32-bit integers in two binary files'
       print*,' Enter first file name (<= 15 characters):'
       read 845, file1
       print*,' Enter second file name (<= 15 characters):'
       read 845, file2
845    format(a15)
       print*,'  Now choose a name for your output file:'
       read 845,file3
      open(1,file=file1,form='unformatted',access='direct',recl=16384)
      open(2,file=file2,form='unformatted',access='direct',recl=16384)
       print*,' Choose your operation, + for add, x for exclusive-or:'
       print*,' Enter choice in column 1:'
      read 35,op
35     format(a1)
      open(3,file=file3,form='unformatted',access='direct',recl=16384)
       print*,'  Please wait...............'
       jk=0
         if(op.eq.'+') then
         do 2 i=1,610
         jk=jk+1
              read(1,rec=jk) a
              read(2,rec=jk) b
              do 3 k=1,4096
3             c(k)=a(k)+b(k)
2        write(3,rec=jk) c
         elseif(op.eq.'x') then
         do 92 i=1,610
          jk=jk+1
              read(1,rec=jk) a
              read(2,rec=jk) b
              do 93 k=1,4096
93             c(k)=xor(a(k),b(k))
92        write(3,rec=jk) c
          endif
       print 99,file1,file2,file3
99    format('  The files ',a15,' and ',a15,' have been merged',/,
     &'  and  9,994,240 bytes have been written to file ',a15) 
       end
