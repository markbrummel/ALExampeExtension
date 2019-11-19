codeunit 50003 "Ex. Jnl.-Post Line"
{

    TableNo = 50013;

    trigger OnRun();
    begin
        //GetGLSetup;
        RunWithCheck(Rec);
    end;

    var
        GLSetup: Record 98;
        ExJnlLine: Record 50013;
        ExLedgEntry: Record 50011;
        ExamplePerson: Record 50010;
        ExReg: Record 50015;
        ExJnlCheckLine: Codeunit 50002;
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    PROCEDURE GetExReg(VAR NewExReg: Record 50015);
    begin
        NewExReg := ExReg;
    end;

    PROCEDURE RunWithCheck(VAR ExJnlLine2: Record 50013);
    begin
        ExJnlLine.COPY(ExJnlLine2);
        Code;
        ExJnlLine2 := ExJnlLine;
    end;

    LOCAL PROCEDURE "Code"();
    begin
        WITH ExJnlLine DO BEGIN
            IF EmptyLine THEN
                EXIT;

            ExJnlCheckLine.RunCheck(ExJnlLine);

            IF NextEntryNo = 0 THEN BEGIN
                ExLedgEntry.LOCKTABLE;
                IF ExLedgEntry.FINDLAST THEN
                    NextEntryNo := ExLedgEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
            END;

            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            IF ExReg."No." = 0 THEN BEGIN
                ExReg.LOCKTABLE;
                IF (NOT ExReg.FINDLAST) OR (ExReg."To Entry No." <> 0) THEN BEGIN
                    ExReg.INIT;
                    ExReg."No." := ExReg."No." + 1;
                    ExReg."From Entry No." := NextEntryNo;
                    ExReg."To Entry No." := NextEntryNo;
                    ExReg."Creation Date" := TODAY;
                    ExReg."Source Code" := "Source Code";
                    ExReg."Journal Batch Name" := "Journal Batch Name";
                    ExReg."User ID" := USERID;
                    ExReg.INSERT;
                END;
            END;
            ExReg."To Entry No." := NextEntryNo;
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
            //GetGLSetup;

            WITH ExLedgEntry DO BEGIN
                IF "Entry Type" = "Entry Type"::Sale THEN
                    Quantity := -Quantity;
                "User ID" := USERID;
                "Entry No." := NextEntryNo;
            END;

            ExLedgEntry.INSERT;

            NextEntryNo := NextEntryNo + 1;
        END;
    end;


}

