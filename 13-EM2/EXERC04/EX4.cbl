       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX4.
       AUTHOR. LETICIA CANDIDO.
       INSTALLATION. FATEC-SP.
       DATE-WRITTEN. 22/10/23.
       DATE-COMPILED. 22/10/23.
       SECURITY. APENAS O AUTOR PODE MODIFICAR. 

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADESTOQ ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT RELESTOQ ASSIGN TO DISK.
           SELECT RELESTOQ2 ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.

       FD CADESTOQ
           LABEL RECORD ARE STANDARD
           VALUE OF FILE-IS IS "CADESTOQ".

       01 REG-ENT.
           02 CODIGO-ENT  PIC 9(5).
           02 NOME-ENT PIC X(15).
           02 QTDEEST-ENT PIC 9(5).
           02 PRECOUNI-ENT PIC 9(6)V9(2).
       
       FD RELESTOQ
           LABEL RECORD IS OMITTED.
       01 REG-REL
           PIC X(100).

       FD RELESTOQ2
           LABEL RECORD IS OMITTED.
       01 REG-REL2
           PIC X(100).

       WORKING-STORAGE SECTION.
           77 FIM-ARQ PIC X(03) VALUE "NAO".
           77 CT-LIN PIC 9(02) VALUE 25.
           77 CT-LIN2 PIC 9(02) VALUE 25.
           77 CT-PAG PIC 9(02) VALUE ZEROES.
           77 CT-PAG2 PIC 9(02) VALUE ZEROES.
           77 CUST PIC 9(6)V99 VALUE ZEROES.
           77 QTDTOTAL PIC 9(7) VALUE ZEROES.
           77 PRECOMEDIO PIC 9(6)V99 VALUE ZEROES.
           77 PRECOTOTAL PIC 9(8)V99 VALUE ZEROES.

       01 CAB-01.
           02 FILLER  PIC X(14) VALUE "DATA: 23/10/23".
           02 FILLER PIC X(4) VALUE SPACES.
           02 FILLER PIC X(21) VALUE "RELATORIO DE MATERIAL".
           02 FILLER PIC X(1) VALUE SPACES.
           02 FILLER PIC X(10) VALUE "EM ESTOQUE".
           02 FILLER PIC X(40) VALUE SPACES.
           02 FILLER  PIC X(05) VALUE "PAG. ".
           02 VAR-PAG PIC 99.
           02 FILLER  PIC X(03) VALUE SPACES.
       01 CAB-02.
           02 FILLER PIC X(06) VALUE "CODIGO".
           02 FILLER PIC X(10) VALUE SPACES.
           02 FILLER PIC X(04) VALUE "NOME".
           02 FILLER PIC X(10) VALUE SPACES.
           02 FILLER PIC X(15) VALUE "QTDE DO ESTOQUE".
           02 FILLER PIC X(10) VALUE SPACES.
           02 FILLER PIC X(14) VALUE "CUSTO UNITARIO".
           02 FILLER PIC X(10) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "CUSTO TOTAL".
           02 FILLER PIC X(10) VALUE SPACES.
       01 DETALHE.
           02 COD PIC 9(5).
           02 FILLER PIC X(12) VALUE SPACES.
           02 NOM PIC X(15).
           02 FILLER PIC X(8) VALUE SPACES.
           02 QTD PIC 9(5).
           02 FILLER PIC X(16) VALUE SPACES.
           02 UNI PIC 9(6)V99.
           02 FILLER PIC X(12) VALUE SPACES.
           02 CUSTL PIC 9(7)V99.
           02 FILLER PIC X(14) VALUE SPACES.
       01 CAB-001.
           02 FILLER  PIC X(14) VALUE "DATA: 23/10/23".
           02 FILLER PIC X(4) VALUE SPACES.
           02 FILLER PIC X(21) VALUE "RELATORIO DE MATERIAL".
           02 FILLER PIC X(1) VALUE SPACES.
           02 FILLER PIC X(10) VALUE "EM ESTOQUE".
           02 FILLER PIC X(40) VALUE SPACES.
           02 FILLER  PIC X(05) VALUE "PAG. ".
           02 VAR-PAG2 PIC 99.
           02 FILLER  PIC X(03) VALUE SPACES.
       01 CAB-002.
           02 FILLER PIC X(16) VALUE "QUANTIDADE TOTAL".
           02 FILLER PIC X(20) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "PRECO MEDIO".
           02 FILLER PIC X(20) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "PRECO TOTAL".
           02 FILLER PIC X(22) VALUE SPACES.
       01 DETALHE-02.
           02 TOT PIC 9(7).
           02 FILLER PIC X(25) VALUES SPACES.
           02 PRECM PIC 9(06)V99.
           02 FILLER PIC X(25) VALUES SPACES.
           02 PRECTOT PIC 9(8)V99.
           02 FILLER PIC X(25) VALUES SPACES.

       PROCEDURE DIVISION.
       EX1.
           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "SIM".
           PERFORM IMPRESSAO2.
           PERFORM FIM.
           STOP RUN.

       INICIO.
           OPEN INPUT CADESTOQ
                OUTPUT RELESTOQ
                OUTPUT RELESTOQ2.
           PERFORM LEITURA.

       LEITURA.
           READ CADESTOQ AT END MOVE "SIM" TO FIM-ARQ.

       PRINCIPAL.
           PERFORM IMPRESSAO.
           DIVIDE PRECOTOTAL BY QTDTOTAL GIVING PRECOMEDIO.
           PERFORM LEITURA.

       IMPRESSAO.
           IF CT-LIN GREATER THAN 19
               PERFORM CABECALHO.
           PERFORM IMPDET.
       IMPDET.
           MOVE CODIGO-ENT TO COD.
           MOVE NOME-ENT TO NOM.
           MOVE QTDEEST-ENT TO QTD.
           MOVE PRECOUNI-ENT TO UNI.
           MULTIPLY QTDEEST-ENT BY PRECOUNI-ENT GIVING CUSTL.
           MOVE CUSTL TO CUST.
           WRITE REG-REL FROM DETALHE AFTER ADVANCING 1 LINE.
           ADD 1 TO CT-LIN.
           ADD 1 TO QTDTOTAL.
           ADD PRECOUNI-ENT TO PRECOTOTAL.
           MOVE ZEROES TO CUSTL.
       CABECALHO.
           ADD 1 TO CT-PAG.
           MOVE CT-PAG TO VAR-PAG.
           MOVE SPACES TO REG-REL.
           WRITE REG-REL AFTER ADVANCING PAGE.
           WRITE REG-REL FROM CAB-01 AFTER ADVANCING 1 LINE.
           WRITE REG-REL FROM CAB-02 AFTER ADVANCING 2 LINE.
           MOVE ZEROES TO CT-LIN.

       IMPRESSAO2.
           IF CT-LIN2 GREATER THAN 19
               PERFORM CABECALHO2.
           PERFORM IMPDET2.

       IMPDET2.
           MOVE QTDTOTAL TO TOT.
           MOVE PRECOMEDIO TO PRECM.
           MOVE PRECOTOTAL TO PRECTOT.
           WRITE REG-REL2 FROM DETALHE-02 AFTER ADVANCING 1 LINE.
           ADD 1 TO CT-LIN2.

      CABECALHO2.
           ADD 1 TO CT-PAG2.
           MOVE CT-PAG2 TO VAR-PAG2.
           MOVE SPACES TO REG-REL2.
           WRITE REG-REL2 AFTER ADVANCING PAGE.
           WRITE REG-REL2 FROM CAB-001 AFTER ADVANCING 1 LINE.
           WRITE REG-REL2 FROM CAB-002 AFTER ADVANCING 2 LINE.
           MOVE ZEROES TO CT-LIN2.
       FIM.
           CLOSE CADESTOQ RELESTOQ RELESTOQ2.