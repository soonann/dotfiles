### with special device
$ time find . 
real    0m16.128s
user    0m2.851s
sys     0m10.076s

### without special device
$ time find .
real    1m53.928s
user    0m3.116s
sys     0m14.062s

### small files
$ find . -type f -print0 | xargs -0 ls -l | awk '{ n=int(log($5)/log(2)); if (n<10) { n=10; } size[n]++ } END { for (i in size) printf("%d %d\n", 2^
i, size[i]) }' | sort -n | awk 'function human(x) { x[1]/=1024; if (x[1]>=1024) { x[2]++; human(x) } } { a[1]=$1; a[2]=0; human(a); printf("%3d%s: %6d\n", a[1],substr("kMGTEPYZ",a[2]+1,1),$
2) }'
  1k: 310882
  2k:  65271
  4k:  43749
  8k:  38880
 16k:  41536
 32k:  24112
 64k:  36360
128k:  14096
256k:   6776
512k:   4590
  1M:   4747 < 
  2M:   4799
  4M:   2555
  8M:   1995
 16M:   1476
 32M:   3548
 64M:   1019
128M:    405
256M:    221
512M:    182
  1G:     92
  2G:     80
  4G:     25
  8G:      2
 16G:      3
 32G:      3
 64G:      1

given the above histogram, we can see most of the files are slightly below 128kb
therefore, I kept the recordsize for datasets as 128kb and smaller blocks than that to 128kb


$ zdb -Lbbbs potatopool

Traversing all blocks ...

1.79T completed (14701MB/s) estimated time remaining: 0hr 01min 53sec
        bp count:              10671882
        ganged count:                 0
        bp logical:       1321035411456      avg: 123786
        bp physical:      1308794964992      avg: 122639     compression:   1.01
        bp allocated:     1968107479040      avg: 184419     compression:   0.67
        bp deduped:                   0    ref>1:      0   deduplication:   1.00
        bp cloned:                    0    count:      0
        Normal class:     3713997586432     used: 10.32%
        Special class           8114176     used:  0.00%
        Embedded log class              0     used:  0.00%

        additional, non-pointer bps of type 0:      58430
         number of (compressed) bytes:  number of bps
                         17:      1 *
                         18:      9 *
                         19:     34 *
                         20:      2 *
                         21:      4 *
                         22:      2 *
                         23:      5 *
                         24:      7 *
                         25:      2 *
                         26:      5 *
                         27:     36 *
                         28:   1121 ************
                         29:   1672 ******************
                         30:      2 *
                         31:      4 *
                         32:     16 *
                         33:      5 *
                         34:      1 *
                         35:      0
                         36:      4 *
                         37:      0
                         38:     14 *
                         39:      4 *
                         40:      9 *
                         41:      1 *
                         42:      3 *
                         43:      2 *
                         44:     22 *
                         45:      4 *
                         46:    157 **
                         47:     99 **
                         48:    211 ***
                         49:    476 ******
                         50:   1795 ********************
                         51:   2786 ******************************
                         52:   1682 ******************
                         53:   1866 ********************
                         54:   1855 ********************
                         55:   1767 *******************
                         56:   1925 *********************
                         57:    767 *********
                         58:   1058 ************
                         59:    849 *********
                         60:    266 ***
                         61:    773 *********
                         62:   1065 ************
                         63:    723 ********
                         64:    526 ******
                         65:    588 *******
                         66:    710 ********
                         67:    958 ***********
                         68:    854 **********
                         69:    753 ********
                         70:    891 **********
                         71:   1484 ****************
                         72:   1110 ************
                         73:    884 **********
                         74:    871 **********
                         75:   1039 ************
                         76:    761 *********
                         77:    617 *******
                         78:    776 *********
                         79:    679 ********
                         80:    591 *******
                         81:    764 *********
                         82:    749 ********
                         83:    884 **********
                         84:   2510 ***************************
                         85:   3777 ****************************************
                         86:    757 *********
                         87:   1042 ************
                         88:    345 ****
                         89:    430 *****
                         90:    503 ******
                         91:    311 ****
                         92:    329 ****
                         93:    309 ****
                         94:    336 ****
                         95:    475 ******
                         96:    390 *****
                         97:    840 *********
                         98:    392 *****
                         99:    387 *****
                        100:    352 ****
                        101:    312 ****
                        102:    297 ****
                        103:    267 ***
                        104:    447 *****
                        105:    640 *******
                        106:    908 **********
                        107:    767 *********
                        108:    642 *******
                        109:    243 ***
                        110:    310 ****
                        111:    278 ***
                        112:    234 ***
        Dittoed blocks on same vdev: 115710

Blocks  LSIZE   PSIZE   ASIZE     avg    comp   %Total  Type
     -      -       -       -       -       -        -  unallocated
     2    32K      8K     24K     12K    4.00     0.00  object directory
     1   128K      4K     24K     24K   32.00     0.00      L1 object array
    15  7.50K      7K    324K   21.6K    1.07     0.00      L0 object array
    16   136K     11K    348K   21.8K   12.32     0.00  object array
     1    16K      4K     12K     12K    4.00     0.00  packed nvlist
     -      -       -       -       -       -        -  packed nvlist size
     -      -       -       -       -       -        -  bpobj
     -      -       -       -       -       -        -  bpobj header
     -      -       -       -       -       -        -  SPA space map header
   150  2.34M    516K   2.64M     18K    4.65     0.00      L1 SPA space map
 1.19K  34.2M   7.71M   37.5M   31.4K    4.43     0.00      L0 SPA space map
 1.34K  36.5M   8.22M   40.1M   29.9K    4.45     0.00  SPA space map
     -      -       -       -       -       -        -  ZIL intent log
     6   768K     24K     48K      8K   32.00     0.00      L5 DMU dnode
     6   768K     24K     48K      8K   32.00     0.00      L4 DMU dnode
     6   768K     24K     48K      8K   32.00     0.00      L3 DMU dnode
     6   768K     24K     48K      8K   32.00     0.00      L2 DMU dnode
    29  3.62M      1M   2.00M   70.8K    3.62     0.00      L1 DMU dnode
 21.1K   338M   84.7M    170M   8.03K    3.99     0.01      L0 DMU dnode
 21.2K   345M   85.8M    172M   8.12K    4.01     0.01  DMU dnode
     7    28K     28K     60K   8.57K    1.00     0.00  DMU objset
     -      -       -       -       -       -        -  DSL directory
     9     5K     512     12K   1.33K   10.00     0.00  DSL directory child map
     -      -       -       -       -       -        -  DSL dataset snap map
    11  67.5K   15.5K     84K   7.64K    4.35     0.00  DSL props
     -      -       -       -       -       -        -  DSL dataset
     -      -       -       -       -       -        -  ZFS znode
     -      -       -       -       -       -        -  ZFS V0 ACL
   986   123M   3.90M   15.6M   16.2K   31.58     0.00      L2 ZFS plain file
 51.3K  6.41G    557M   1.89G   37.7K   11.78     0.10      L1 ZFS plain file
 10.0M  1.19T   1.19T   1.79T    183K    1.00    99.85      L0 ZFS plain file
 10.1M  1.20T   1.19T   1.79T    182K    1.01    99.96  ZFS plain file
 2.23K   286M   8.94M   35.7M   16.0K   31.99     0.00      L1 ZFS directory
 85.1K   145M   54.9M    593M   6.96K    2.64     0.03      L0 ZFS directory
 87.4K   431M   63.8M    629M   7.20K    6.76     0.03  ZFS directory
     6     3K      3K     88K   14.7K    1.00     0.00  ZFS master node
     -      -       -       -       -       -        -  ZFS delete queue
     -      -       -       -       -       -        -  zvol object
     -      -       -       -       -       -        -  zvol prop
     -      -       -       -       -       -        -  other uint8[]
     -      -       -       -       -       -        -  other uint64[]
     -      -       -       -       -       -        -  other ZAP
     -      -       -       -       -       -        -  persistent error log
     2   256K     24K     72K     36K   10.67     0.00  SPA history
     -      -       -       -       -       -        -  SPA history offsets
     -      -       -       -       -       -        -  Pool properties
     -      -       -       -       -       -        -  DSL permissions
     -      -       -       -       -       -        -  ZFS ACL
     -      -       -       -       -       -        -  ZFS SYSACL
     -      -       -       -       -       -        -  FUID table
     -      -       -       -       -       -        -  FUID table size
     -      -       -       -       -       -        -  DSL dataset next clones
     -      -       -       -       -       -        -  scan work queue
    18    11K   4.50K     40K   2.22K    2.44     0.00  ZFS user/group/project used
     -      -       -       -       -       -        -  ZFS user/group/project quota
     -      -       -       -       -       -        -  snapshot refcount tags
     -      -       -       -       -       -        -  DDT ZAP algorithm
     -      -       -       -       -       -        -  DDT statistics
     3  1.50K   1.50K     48K     16K    1.00     0.00  System attributes
     -      -       -       -       -       -        -  SA master node
     6     9K      8K     88K   14.7K    1.12     0.00  SA attr registration
    12   192K     44K    160K   13.3K    4.36     0.00  SA attr layouts
     -      -       -       -       -       -        -  scan translations
     -      -       -       -       -       -        -  deduplicated block
     -      -       -       -       -       -        -  DSL deadlist map
     -      -       -       -       -       -        -  DSL deadlist map hdr
     -      -       -       -       -       -        -  DSL dir clones
     -      -       -       -       -       -        -  bpobj subobj
     -      -       -       -       -       -        -  deferred free
     -      -       -       -       -       -        -  dedup ditto
     5   640K     20K     60K     12K   32.00     0.00      L1 other
    34   502K   77.5K    276K   8.12K    6.47     0.00      L0 other
    39  1.11M   97.5K    336K   8.62K   11.71     0.00  other
     6   768K     24K     48K      8K   32.00     0.00      L5 Total
     6   768K     24K     48K      8K   32.00     0.00      L4 Total
     6   768K     24K     48K      8K   32.00     0.00      L3 Total
   992   124M   3.93M   15.6M   16.1K   31.59     0.00      L2 Total
 53.7K  6.70G    568M   1.93G   36.7K   12.08     0.11      L1 Total
 10.1M  1.19T   1.19T   1.79T    181K    1.00    99.89      L0 Total
 10.2M  1.20T   1.19T   1.79T    180K    1.01   100.00  Total
  162K  7.33G    719M   2.72G   17.2K   10.43     0.15  Metadata Total

Block Size Histogram

  block   psize                lsize                asize
   size   Count   Size   Cum.  Count   Size   Cum.  Count   Size   Cum.
    512:   156K  78.1M  78.1M   156K  78.1M  78.1M      0      0      0
     1K:   126K   152M   230M   126K   152M   230M      0      0      0
     2K:  83.4K   214M   444M  83.3K   214M   444M      0      0      0
     4K:   120K   534M   978M  47.3K   251M   695M  1.32K  5.27M  5.27M
     8K:  41.1K   441M  1.39G  32.5K   362M  1.03G   378K  2.96G  2.96G
    16K:  51.4K  1.09G  2.48G  69.3K  1.32G  2.35G   148K  2.58G  5.54G
    32K:  55.7K  2.55G  5.03G  23.4K  1.10G  3.45G  59.4K  2.41G  7.95G
    64K:  55.8K  4.47G  9.50G  35.9K  2.91G  6.36G  73.3K  6.70G  14.7G
   128K:  9.45M  1.18T  1.19T  9.56M  1.20T  1.20T  9.48M  1.78T  1.79T
   256K:      0      0  1.19T      0      0  1.20T      1   384K  1.79T
   512K:      0      0  1.19T      0      0  1.20T      0      0  1.79T
     1M:      0      0  1.19T      0      0  1.20T      0      0  1.79T
     2M:      0      0  1.19T      0      0  1.20T      0      0  1.79T
     4M:      0      0  1.19T      0      0  1.20T      0      0  1.79T
     8M:      0      0  1.19T      0      0  1.20T      0      0  1.79T
    16M:      0      0  1.19T      0      0  1.20T      0      0  1.79T

                            capacity   operations   bandwidth  ---- errors ----
description                used avail  read write  read write  read write cksum
potatopool                3.38T 29.8T   687     0 5.12M     0     0     0     0
  raidz1                  3.38T 29.4T   520     0 4.41M     0     0     0     0
    /dev/disk/by-id/wwn-0x5000c500b4389471-part1              173     0 1.48M     0     0     0     0
    /dev/disk/by-id/wwn-0x5000c500b6ca2465-part1              173     0 1.47M     0     0     0     0
    /dev/disk/by-id/wwn-0x5000c500b144ba4e-part1              173     0 1.46M     0     0     0     0
  mirror (special)        7.74M  465G   167     0  732K     0     0     0     0
    /dev/disk/by-id/wwn-0x5002538e70274604-part1               90     0  394K     0     0     0     0
    /dev/disk/by-id/wwn-0x5002538e4017825c-part1               76     0  338K     0     0     0     0


