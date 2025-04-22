      ******************************************************************
      * Author:CESAR CHINCHAY
      * Date:21/05/2025
      * Purpose:INTERBANK COBOL ACADEMY
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPORTE-TRANSACCIONES.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-FILE ASSIGN TO "data.csv"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-FILE.
       01  TRANS-LINE           PIC X(80).

       WORKING-STORAGE SECTION.
       01  EOF-FLAG             PIC X VALUE "N".
           88  EOF              VALUE "Y".
           88  NOT-EOF          VALUE "N".

       01  WS-FIRST-READ        PIC X VALUE "Y".

       01  TR-ID                PIC 9(5).
       01  TR-TIPO              PIC X(10).
       01  TR-MONTO             PIC 9(5)V99.

       01  WS-BALANCE           PIC 9(7)V99 VALUE 0.
       01  WS-MAX-MONTO         PIC 9(5)V99 VALUE 0.
       01  WS-MAX-ID            PIC 9(5)     VALUE 0.
       01  WS-COUNT-CREDITO     PIC 9(4)     VALUE 0.
       01  WS-COUNT-DEBITO      PIC 9(4)     VALUE 0.

       01  WS-DELIM             PIC X VALUE ",".

       01  FIELDS.
           05  FIELD-ID        PIC X(5).
           05  FIELD-TIPO      PIC X(10).
           05  FIELD-MONTO     PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT TRANS-FILE

           PERFORM UNTIL EOF
               READ TRANS-FILE
                   AT END
                       SET EOF TO TRUE
                   NOT AT END
                       PERFORM PROCESS-LINE
               END-READ
           END-PERFORM

           CLOSE TRANS-FILE
           PERFORM SHOW-REPORT
           STOP RUN.

       PROCESS-LINE.
           IF WS-FIRST-READ = "Y"
               MOVE "N" TO WS-FIRST-READ
           END-IF

           UNSTRING TRANS-LINE DELIMITED BY WS-DELIM
               INTO FIELD-ID, FIELD-TIPO, FIELD-MONTO

           MOVE FUNCTION NUMVAL (FIELD-ID) TO TR-ID
           MOVE FIELD-TIPO TO TR-TIPO
           MOVE FUNCTION NUMVAL (FIELD-MONTO) TO TR-MONTO

           IF TR-TIPO(1:7) = "Credito"
               ADD TR-MONTO TO WS-BALANCE
               ADD 1 TO WS-COUNT-CREDITO
           ELSE IF TR-TIPO(1:6) = "Debito"
               SUBTRACT TR-MONTO FROM WS-BALANCE
               ADD 1 TO WS-COUNT-DEBITO
           END-IF

           IF TR-MONTO > WS-MAX-MONTO
               MOVE TR-MONTO TO WS-MAX-MONTO
               MOVE TR-ID TO WS-MAX-ID
           END-IF.

       SHOW-REPORT.
           DISPLAY "Reporte de Transacciones".
           DISPLAY "---------------------------------------------".
           DISPLAY "Balance Final: " WS-BALANCE.
           DISPLAY "Transaccion de Mayor Monto: ID " WS-MAX-ID " - "
           WS-MAX-MONTO.
           DISPLAY "Conteo de Transacciones: Credito: " WS-COUNT-CREDITO
                   " Debito: " WS-COUNT-DEBITO.
