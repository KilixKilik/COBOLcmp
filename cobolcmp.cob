       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBOLCMP.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CONFIG-FILE ASSIGN TO "config.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT INPUT-FILE ASSIGN TO "src/input.cob"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT OUTPUT-FILE ASSIGN TO "src/obfuscated_output.cob"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD CONFIG-FILE.
       01 CONFIG-RECORD PIC X(80).

       FD INPUT-FILE.
       01 INPUT-LINE PIC X(80).

       FD OUTPUT-FILE.
       01 OUTPUT-LINE PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-EOF PIC X VALUE 'N'.
       01 WS-VAR-COUNTER PIC 9999 VALUE 1000.
       01 WS-NEW-VAR-NAME PIC X(10).
       01 WS-TMP PIC X(80).
       01 WS-FOUND PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           OPEN INPUT INPUT-FILE
           OPEN OUTPUT OUTPUT-FILE

           PERFORM READ-AND-OBFUSCATE-LOOP

           CLOSE INPUT-FILE
           CLOSE OUTPUT-FILE
           STOP RUN.

       READ-AND-OBFUSCATE-LOOP.
           READ INPUT-FILE
               AT END MOVE 'Y' TO WS-EOF
           NOT AT END
               PERFORM PROCESS-LINE
               GO TO READ-AND-OBFUSCATE-LOOP.

       PROCESS-LINE.
           MOVE INPUT-LINE TO WS-TMP

           IF INPUT-LINE(1:1) = '0' AND INPUT-LINE(3:3) = 'PIC'
               PERFORM GENERATE-NEW-VAR-NAME
               PERFORM REPLACE-VAR-NAME-IN-LINE
           END-IF

           STRING WS-TMP DELIMITED BY SPACE
                  '      *> Obfuscated by COBOLcmp'
                  INTO OUTPUT-LINE
           END-STRING

           WRITE OUTPUT-LINE.

       GENERATE-NEW-VAR-NAME.
           MOVE 'VAR' TO WS-NEW-VAR-NAME(1:4)
           MOVE WS-VAR-COUNTER TO WS-NEW-VAR-NAME(5:4)
           ADD 1 TO WS-VAR-COUNTER.

       REPLACE-VAR-NAME-IN-LINE.
           MOVE WS-NEW-VAR-NAME TO WS-TMP(1:8).

       END PROGRAM COBOLCMP.