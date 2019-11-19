codeunit 50004 "Ex. Jnl.-Post Batch"
{
  // version Exercise 3

  TableNo=50013;

  trigger OnRun();
  begin
    ExJnlLine.COPY(Rec);
    Code4;
    Rec := ExJnlLine;
  end;

  var
    Text000 : TextConst ENU='cannot exceed %1 characters',ESM='no puede superar %1 caracteres',FRC='ne peut dépasser %1 caractères',ENC='cannot exceed %1 characters';
    Text001 : TextConst ENU='Journal Batch Name    #1##########\\',ESM='Nombre sección diario #1##########\\',FRC='Nom de lot du journal    #1##########\\',ENC='Journal Batch Name    #1##########\\';
    Text002 : TextConst ENU='Checking lines        #2######\',ESM='Comprobando líneas    #2######\',FRC='Vérification des lignes  #2######\',ENC='Checking lines        #2######\';
    Text003 : TextConst ENU='Posting lines         #3###### @4@@@@@@@@@@@@@\',ESM='Registrando líneas    #3###### @4@@@@@@@@@@@@@\',FRC='Report des lignes        #3###### @4@@@@@@@@@@@@@\',ENC='Posting lines         #3###### @4@@@@@@@@@@@@@\';
    Text004 : TextConst ENU='Updating lines        #5###### @6@@@@@@@@@@@@@',ESM='Actualizando líns.    #5###### @6@@@@@@@@@@@@@',FRC='Mise à jour des lignes   #5###### @6@@@@@@@@@@@@@',ENC='Updating lines        #5###### @6@@@@@@@@@@@@@';
    Text005 : TextConst ENU='Posting lines         #3###### @4@@@@@@@@@@@@@',ESM='Registrando líneas    #3###### @4@@@@@@@@@@@@@',FRC='Report des lignes        #3###### @4@@@@@@@@@@@@@',ENC='Posting lines         #3###### @4@@@@@@@@@@@@@';
    Text006 : TextConst ENU='A maximum of %1 posting number series can be used in each journal.',ESM='Se puede utilizar un máximo de %1 números de serie de registro en cada diario.',FRC='Un maximum de %1 séries de numéros de report peuvent être utilisées dans chaque journal.',ENC='A maximum of %1 posting number series can be used in each journal.';
    Text007 : TextConst ENU='<Month Text>',ESM='<Month Text>',FRC='<Month Text>',ENC='<Month Text>';
    ExJnlTemplate : Record 50012;
    ExJnlBatch : Record 50014;
    ExJnlLine : Record 50013;
    ExJnlLine2 : Record 50013;
    ExJnlLine3 : Record 50013;
    ExLedgEntry : Record 50011;
    ExReg : Record 50015;
    NoSeries : Record 308 TEMPORARY;
    ExJnlCheckLine : Codeunit 50002;
    ExJnlPostLine : Codeunit 50003;
    NoSeriesMgt : Codeunit 396;
    NoSeriesMgt2 : ARRAY [10] OF Codeunit 396;
    Window : Dialog;
    ExRegNo : Integer;
    StartLineNo : Integer;
    Day : Integer;
    Week : Integer;
    Month : Integer;
    MonthText : Text[30];
    AccountingPeriod : Record 50;
    LineCount : Integer;
    NoOfRecords : Integer;
    LastDocNo : Code[20];
    LastDocNo2 : Code[20];
    LastPostedDocNo : Code[20];
    NoOfPostingNoSeries : Integer;
    PostingNoSeriesNo : Integer;
    "0DF" : DateFormula;

  LOCAL PROCEDURE Code4();
  var
    UpdateAnalysisView : Codeunit 410;
  begin
    WITH ExJnlLine DO BEGIN
      SETRANGE("Journal Template Name","Journal Template Name");
      SETRANGE("Journal Batch Name","Journal Batch Name");
      LOCKTABLE;

      ExJnlTemplate.GET("Journal Template Name");
      ExJnlBatch.GET("Journal Template Name","Journal Batch Name");
      IF STRLEN(INCSTR(ExJnlBatch.Name)) > MAXSTRLEN(ExJnlBatch.Name) THEN
        ExJnlBatch.FIELDERROR(
          Name,
          STRSUBSTNO(
            Text000,
            MAXSTRLEN(ExJnlBatch.Name)));

      IF ExJnlTemplate.Recurring THEN BEGIN
        SETRANGE("Posting Date",0D,WORKDATE);
        SETFILTER("Expiration Date",'%1 | %2..',0D,WORKDATE);
      END;

      IF NOT FIND('=><') THEN BEGIN
        "Line No." := 0;
        COMMIT;
        EXIT;
      END;

      IF ExJnlTemplate.Recurring THEN
        Window.OPEN(
          Text001 +
          Text002 +
          Text003 +
          Text004)
      ELSE
        Window.OPEN(
          Text001 +
          Text002 +
          Text005);
      Window.UPDATE(1,"Journal Batch Name");

      // Check lines
      LineCount := 0;
      StartLineNo := "Line No.";
      REPEAT
        LineCount := LineCount + 1;
        Window.UPDATE(2,LineCount);
        CheckRecurringLine(ExJnlLine);
        ExJnlCheckLine.RunCheck(ExJnlLine);
        IF NEXT = 0 THEN
          FIND('-');
      UNTIL "Line No." = StartLineNo;
      NoOfRecords := LineCount;

      // Find next register no.
      ExLedgEntry.LOCKTABLE;
      IF ExLedgEntry.FIND('+') THEN;
      ExReg.LOCKTABLE;
      IF ExReg.FIND('+') AND (ExReg."To Entry No." = 0) THEN
        ExRegNo := ExReg."No."
      ELSE
        ExRegNo := ExReg."No." + 1;

      // Post lines
      LineCount := 0;
      LastDocNo := '';
      LastDocNo2 := '';
      LastPostedDocNo := '';
      FIND('-');
      REPEAT
        LineCount := LineCount + 1;
        Window.UPDATE(3,LineCount);
        Window.UPDATE(4,ROUND(LineCount / NoOfRecords * 10000,1));
        IF NOT EmptyLine AND
           (ExJnlBatch."No. Series" <> '') AND
           ("Document No." <> LastDocNo2)
        THEN
          TESTFIELD("Document No.",NoSeriesMgt.GetNextNo(ExJnlBatch."No. Series","Posting Date",FALSE));
        IF NOT EmptyLine THEN
          LastDocNo2 := "Document No.";
        MakeRecurringTexts(ExJnlLine);
        IF "Posting No. Series" = '' THEN
          "Posting No. Series" := ExJnlBatch."No. Series"
        ELSE
          IF NOT EmptyLine THEN
            IF "Document No." = LastDocNo THEN
              "Document No." := LastPostedDocNo
            ELSE BEGIN
              IF NOT NoSeries.GET("Posting No. Series") THEN BEGIN
                NoOfPostingNoSeries := NoOfPostingNoSeries + 1;
                IF NoOfPostingNoSeries > ARRAYLEN(NoSeriesMgt2) THEN
                  ERROR(
                    Text006,
                    ARRAYLEN(NoSeriesMgt2));
                NoSeries.Code := "Posting No. Series";
                NoSeries.Description := FORMAT(NoOfPostingNoSeries);
                NoSeries.INSERT;
              END;
              LastDocNo := "Document No.";
              EVALUATE(PostingNoSeriesNo,NoSeries.Description);
              "Document No." := NoSeriesMgt2[PostingNoSeriesNo].GetNextNo("Posting No. Series","Posting Date",FALSE);
              LastPostedDocNo := "Document No.";
            END;
        ExJnlPostLine.RunWithCheck(ExJnlLine);
      UNTIL NEXT = 0;

      // Copy register no. and current journal batch name to the res. journal
      IF NOT ExReg.FIND('+') OR (ExReg."No." <> ExRegNo) THEN
        ExRegNo := 0;

      INIT;
      "Line No." := ExRegNo;

      // Update/delete lines
      IF ExRegNo <> 0 THEN BEGIN
        IF ExJnlTemplate.Recurring THEN BEGIN
          // Recurring journal
          LineCount := 0;
          ExJnlLine2.COPYFILTERS(ExJnlLine);
          ExJnlLine2.FIND('-');
          REPEAT
            LineCount := LineCount + 1;
            Window.UPDATE(5,LineCount);
            Window.UPDATE(6,ROUND(LineCount / NoOfRecords * 10000,1));
            IF ExJnlLine2."Posting Date" <> 0D THEN
              ExJnlLine2.VALIDATE("Posting Date",CALCDATE(ExJnlLine2."Recurring Frequency",ExJnlLine2."Posting Date"));
            IF (ExJnlLine2."Recurring Method" = ExJnlLine2."Recurring Method"::Variable) AND
               (ExJnlLine2."Example Person No." <> '')
            THEN BEGIN
              ExJnlLine2.Quantity := 0;
            END;
            ExJnlLine2.MODIFY;
          UNTIL ExJnlLine2.NEXT = 0;
        END ELSE BEGIN
          // Not a recurring journal
          ExJnlLine2.COPYFILTERS(ExJnlLine);
          ExJnlLine2.SETFILTER("Example Person No.",'<>%1','');
          IF ExJnlLine2.FIND('+') THEN; // Remember the last line
          ExJnlLine3.COPY(ExJnlLine);
          ExJnlLine3.DELETEALL;
          ExJnlLine3.RESET;
          ExJnlLine3.SETRANGE("Journal Template Name","Journal Template Name");
          ExJnlLine3.SETRANGE("Journal Batch Name","Journal Batch Name");
          IF NOT ExJnlLine3.FINDLAST THEN
            IF INCSTR("Journal Batch Name") <> '' THEN BEGIN
              ExJnlBatch.DELETE;
              ExJnlBatch.Name := INCSTR("Journal Batch Name");
              IF ExJnlBatch.INSERT THEN;
              "Journal Batch Name" := ExJnlBatch.Name;
            END;

          ExJnlLine3.SETRANGE("Journal Batch Name","Journal Batch Name");
          IF (ExJnlBatch."No. Series" = '') AND NOT ExJnlLine3.FINDLAST THEN BEGIN
            ExJnlLine3.INIT;
            ExJnlLine3."Journal Template Name" := "Journal Template Name";
            ExJnlLine3."Journal Batch Name" := "Journal Batch Name";
            ExJnlLine3."Line No." := 10000;
            ExJnlLine3.INSERT;
            ExJnlLine3.SetUpNewLine(ExJnlLine2);
            ExJnlLine3.MODIFY;
          END;
        END;
      END;
      IF ExJnlBatch."No. Series" <> '' THEN
        NoSeriesMgt.SaveNoSeries;
      IF NoSeries.FIND('-') THEN
        REPEAT
          EVALUATE(PostingNoSeriesNo,NoSeries.Description);
          NoSeriesMgt2[PostingNoSeriesNo].SaveNoSeries;
        UNTIL NoSeries.NEXT = 0;

      COMMIT;
    END;
    UpdateAnalysisView.UpdateAll(0,TRUE);
    COMMIT;
  end;

  LOCAL PROCEDURE CheckRecurringLine(VAR ExJnlLine2 : Record 50013);
  begin
    WITH ExJnlLine2 DO BEGIN
      IF "Example Person No." <> '' THEN
        IF ExJnlTemplate.Recurring THEN BEGIN
          TESTFIELD("Recurring Method");
          TESTFIELD("Recurring Frequency");
          IF "Recurring Method" = "Recurring Method"::Variable THEN
            TESTFIELD(Quantity);
        END ELSE BEGIN
          TESTFIELD("Recurring Method",0);
          TESTFIELD("Recurring Frequency","0DF");
        END;
    END;
  end;

  LOCAL PROCEDURE MakeRecurringTexts(VAR ExJnlLine2 : Record 50013);
  begin
    WITH ExJnlLine2 DO BEGIN
      IF ("Example Person No." <> '') AND ("Recurring Method" <> 0) THEN BEGIN // Not recurring
        Day := DATE2DMY("Posting Date",1);
        Week := DATE2DWY("Posting Date",2);
        Month := DATE2DMY("Posting Date",2);
        MonthText := FORMAT("Posting Date",0,Text007);
        AccountingPeriod.SETRANGE("Starting Date",0D,"Posting Date");
        IF NOT AccountingPeriod.FIND('+') THEN
          AccountingPeriod.Name := '';
        "Document No." :=
          DELCHR(
            PADSTR(
              STRSUBSTNO("Document No.",Day,Week,Month,MonthText,AccountingPeriod.Name),
              MAXSTRLEN("Document No.")),
            '>');
        Description :=
          DELCHR(
            PADSTR(
              STRSUBSTNO(Description,Day,Week,Month,MonthText,AccountingPeriod.Name),
              MAXSTRLEN(Description)),
            '>');
      END;
    END;
  end;
}

