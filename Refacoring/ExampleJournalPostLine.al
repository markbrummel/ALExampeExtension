codeunit 50122 "Example Jnl.-Post Line"
{
    TableNo = "Ex. Journal Line";

    trigger OnRun();
    begin
        IF NOT TestNear(Rec) THEN
            EXIT;

        TestFar(Rec);
        IsolateTransactionAndFindLastEntryNumber;
        CreateOrUpdateRegister("Source Code", "Journal Batch Name");
        CreateEntry(Rec);
    end;

    var
        ExReg: Record 50015;
        NextEntryNo: Integer;

    LOCAL PROCEDURE TestNear(ExJnlLine: Record 50013): Boolean;
    var
        ExJnlCheckLine: Codeunit 50002;
    begin
        WITH ExJnlLine DO
            IF EmptyLine THEN
                EXIT(FALSE);

        EXIT(TRUE);
    end;

    LOCAL PROCEDURE TestFar(ExJnlLine: Record 50013);
    var
        ExJnlCheckLine: Codeunit 50002;
    begin
        ExJnlCheckLine.RunCheck(ExJnlLine);
    end;

    LOCAL PROCEDURE IsolateTransactionAndFindLastEntryNumber();
    var
        ExLedgEntry: Record 50011;
    begin
        IF NextEntryNo = 0 THEN BEGIN
            ExLedgEntry.LOCKTABLE;
            IF ExLedgEntry.FINDLAST THEN
                NextEntryNo := ExLedgEntry."Entry No.";
            NextEntryNo := NextEntryNo + 1;
        END;
    end;

    LOCAL PROCEDURE CreateOrUpdateRegister(SourceCode: Code[10]; JournalBatchName: Code[10]);
    begin
        IF ExReg."No." = 0 THEN BEGIN
            ExReg.LOCKTABLE;
            IF (NOT ExReg.FINDLAST) OR (ExReg."To Entry No." <> 0) THEN BEGIN
                ExReg.INIT;
                ExReg."No." := ExReg."No." + 1;
                ExReg."From Entry No." := NextEntryNo;
                ExReg."To Entry No." := NextEntryNo;
                ExReg."Creation Date" := TODAY;
                ExReg."Source Code" := SourceCode;
                ExReg."Journal Batch Name" := JournalBatchName;
                ExReg."User ID" := USERID;
                ExReg.INSERT;
            END;
        END;
        ExReg."To Entry No." := NextEntryNo;
        ExReg.MODIFY;
    end;

    LOCAL PROCEDURE CreateEntry(VAR ExJnlLine: Record 50013);
    var
        ExLedgEntry: Record 50011;
    begin
        WITH ExJnlLine DO BEGIN
            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            ExLedgEntry.INIT;
            ExLedgEntry."Entry Type" := "Entry Type";
            ExLedgEntry."Document No." := "Document No.";
            ExLedgEntry."Posting Date" := "Posting Date";
            ExLedgEntry."Document Date" := "Document Date";
            ExLedgEntry."Example Person No." := "Example Person No.";
            ExLedgEntry."Example Product No." := "Example Product No.";
            ExLedgEntry.Description := Description;
            ExLedgEntry.Quantity := Quantity;
            ExLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            ExLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            ExLedgEntry."Dimension Set ID" := "Dimension Set ID";
            ExLedgEntry."Source Code" := "Source Code";
            ExLedgEntry."Journal Batch Name" := "Journal Batch Name";
            ExLedgEntry."Reason Code" := "Reason Code";
            ExLedgEntry."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            ExLedgEntry."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            ExLedgEntry."No. Series" := "Posting No. Series";

            IF ExLedgEntry."Entry Type" = ExLedgEntry."Entry Type"::Sale THEN
                ExLedgEntry.Quantity := -ExLedgEntry.Quantity;
            ExLedgEntry."User ID" := USERID;
            ExLedgEntry."Entry No." := NextEntryNo;

            ExLedgEntry.INSERT;

            NextEntryNo := NextEntryNo + 1;
        END;
    end;
}

