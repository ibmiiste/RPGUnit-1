
     H NoMain Option(*SrcStmt)

      /copy RPGUNIT1,TESTCASE
      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,QMHSNDPM

     DsetupSuite       pr
     Dtest1            pr
     DteardownSuite    pr
     D sndInfoMsg      pr
     D  msg                         256a   Const

     PsetupSuite       b                   Export
     DsetupSuite       pi
      /free

        sndInfoMsg( 'setupSuite' );

      /end-free
     PsetupSuite       e

     Ptest1            b                   Export
     Dtest1            pi
      /free

        sndInfoMsg( 'test1' );

      /end-free
     Ptest1            e

     PteardownSuite    b                   Export
     DteardownSuite    pi
     D x               s             10i 0 Inz(0)
      /free

        sndInfoMsg( 'teardownSuite' );

        x = 1 / x;    // Generate error.

      /end-free
     PteardownSuite    e


     P sndInfoMsg      b                   Export
     D sndInfoMsg      pi
     D  msg                         256a   Const

       // Call Stack Counter.
       // 1 - QCMDEXC
       // 2 - RUACPTST.RUN
       // 3 - RUACPTST.TEST...
     D callStkCnt      c                   Const(3)

       // The message reference key (unique string of characters that identifies
       // a particular instance of a message in a queue).
     D msgKey          s              4a

      /free

        QMHSNDPM( *blank :
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*INFO' :
                  '*CTLBDY' :
                  callStkCnt :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndInfoMsg      e
