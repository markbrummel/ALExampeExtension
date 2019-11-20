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
        ExReg: Record "Example Register";
        NextEntryNo: Integer;

    LOCAL PROCEDURE TestNear(ExJnlLine: Record "Ex. Journal Line"): Boolean;
    var
        ExJnlCheckLine: Codeunit "Ex. Jnl.-Check Line";
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
        ExampleEntry: Record "Example Entry";
    begin
        IF NextEntryNo = 0 THEN BEGIN
            ExampleEntry.LOCKTABLE;
            IF ExampleEntry.FINDLAST THEN
                NextEntryNo := ExampleEntry."Entry No.";
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

    LOCAL PROCEDURE CreateEntry(VAR ExJnlLine: Record "Ex. Journal Line");
    var
        ExampleEntry: Record "Example Entry";
    begin
        WITH ExJnlLine DO BEGIN
            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            ExampleEntry.INIT;
            ExampleEntry."Entry Type" := "Entry Type";
            ExampleEntry."Document No." := "Document No.";
            ExampleEntry."Posting Date" := "Posting Date";
            ExampleEntry."Document Date" := "Document Date";
            ExampleEntry."Example Person No." := "Example Person No.";
            ExampleEntry."Example Product No." := "Example Product No.";
            ExampleEntry.Description := Description;
            ExampleEntry.Quantity := Quantity;
            ExampleEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            ExampleEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            ExampleEntry."Dimension Set ID" := "Dimension Set ID";
            ExampleEntry."Source Code" := "Source Code";
            ExampleEntry."Journal Batch Name" := "Journal Batch Name";
            ExampleEntry."Reason Code" := "Reason Code";
            ExampleEntry."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            ExampleEntry."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            ExampleEntry."No. Series" := "Posting No. Series";

            IF ExampleEntry."Entry Type" = ExampleEntry."Entry Type"::Sale THEN
                ExampleEntry.Quantity := -ExampleEntry.Quantity;
            ExampleEntry."User ID" := USERID;
            ExampleEntry."Entry No." := NextEntryNo;

            ExampleEntry.INSERT;

            NextEntryNo := NextEntryNo + 1;
        END;
    end;
}

