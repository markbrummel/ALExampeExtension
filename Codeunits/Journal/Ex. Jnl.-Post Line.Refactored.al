codeunit 50103 "Exampl Jnl.-Post Line"
{
    // version Exercise 3

    TableNo = 50013;

    trigger OnRun();
    begin
        TestNear(Rec);
        TestFar(Rec);
        DoIt(Rec);
    end;

    var
        ExamplePerson: Record 50010;
        ExReg: Record 50015;
        EntryNo: Integer;

    local procedure TestNear(ExJnlLine: Record "Ex. Journal Line");

    begin
        WITH ExJnlLine DO
            IF EmptyLine THEN
                EXIT;
    end;

    local procedure TestFar(ExJnlLine: Record "Ex. Journal Line");
    var
        ExJnlCheckLine: Codeunit 50002;

    begin
        ExJnlCheckLine.RunCheck(ExJnlLine);

    end;

    local procedure DoIt(ExJnlLine: Record "Ex. Journal Line");
    var
        ExLedgEntry: Record 50011;

    begin
        WITH ExJnlLine DO begin

            IF EntryNo = 0 THEN BEGIN
                ExLedgEntry.LOCKTABLE;
                IF ExLedgEntry.FINDLAST THEN
                    EntryNo := ExLedgEntry."Entry No.";
                EntryNo := EntryNo + 1;
            END;

            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            IF ExReg."No." = 0 THEN BEGIN
                ExReg.LOCKTABLE;
                IF (NOT ExReg.FINDLAST) OR (ExReg."To Entry No." <> 0) THEN BEGIN
                    ExReg.INIT;
                    ExReg."No." := ExReg."No." + 1;
                    ExReg."From Entry No." := EntryNo;
                    ExReg."To Entry No." := EntryNo;
                    ExReg."Creation Date" := TODAY;
                    ExReg."Source Code" := "Source Code";
                    ExReg."Journal Batch Name" := "Journal Batch Name";
                    ExReg."User ID" := USERID;
                    ExReg.INSERT;
                END;
            END;
            ExReg."To Entry No." := EntryNo;
            ExReg.MODIFY;

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

            WITH ExLedgEntry DO BEGIN
                IF "Entry Type" = "Entry Type"::Sale THEN
                    Quantity := -Quantity;
                "User ID" := USERID;
                "Entry No." := EntryNo;
            END;

            ExLedgEntry.INSERT;

            EntryNo := EntryNo + 1;
        END;

    END;



}

