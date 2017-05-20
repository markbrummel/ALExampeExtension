codeunit 72060000 "Example-Post With Events"
{
  // version Exercise 4

  TableNo=72050003;

  trigger OnRun();
  begin
    ThrowErrorIfNoSelection(Rec);
    TestNear(Rec);
    TestFar(Rec);
    ReplaceDatesIfAttrExists(Rec);
    PostExampleOne(Rec);
    PostExampleTwo(Rec);
    PostExJnlLine(Rec);
    DeleteExampeDocument(Rec);
  end;

  var
    Arguments : Record 72050002;

  LOCAL PROCEDURE ThrowErrorIfNoSelection(VAR ExDoc : Record 72050003);
  var
    NoSelectionError : TextConst ENU='Please enter "Yes" in %1 and/or %2.';
  begin
    WITH ExDoc DO
      IF NOT (One OR Two) THEN
        ERROR(
          NoSelectionError,
          FIELDCAPTION(One), FIELDCAPTION(Two));
  end;

  LOCAL PROCEDURE TestNear(VAR ExDoc : Record 72050003);
  begin
    WITH ExDoc DO BEGIN
      TESTFIELD("Example Person No.");
      TESTFIELD("Posting Date");
    END;
    OnAfterTestNear;
  end;

  LOCAL PROCEDURE TestFar(VAR ExDoc : Record 72050003);
  var
    GenJnlCheckLine : Codeunit 11;
    DateNotAllowed : TextConst ENU='is not within your range of allowed posting dates.';
  begin
    IF GenJnlCheckLine.DateNotAllowed(ExDoc."Posting Date") THEN
      ExDoc.FIELDERROR("Posting Date", DateNotAllowed);
  end;

  LOCAL PROCEDURE ReplaceDatesIfAttrExists(VAR ExDoc : Record 72050003);
  begin
    WITH Arguments DO BEGIN
      IF (NOT "Replace Posting Date") AND (NOT "Replace Document Date") THEN
        EXIT;

      ThrowErrorIfNoPostingDateAndReplaceIsSelected;
    END;

    WITH ExDoc DO BEGIN
      IF Arguments."Replace Posting Date" THEN
        "Posting Date" := Arguments."Posting Date";
      IF Arguments."Replace Document Date" THEN
        "Document Date" := Arguments."Posting Date";
    END;
  end;

  LOCAL PROCEDURE PostExampleOne(VAR ExDoc : Record 72050003);
  var
    ExampleDocumentLine : Record 72050004;
    ExampleHistoryOne : Record 72050008;
    ExampleHistoryOneLine : Record 72050009;
  begin
    WITH ExampleHistoryOne DO BEGIN
      TRANSFERFIELDS(ExDoc);
      INSERT;
    END;
    WITH ExampleDocumentLine DO BEGIN
      SETRANGE("Document No.", ExDoc."No.");
      IF FINDSET THEN REPEAT
        ExampleHistoryOneLine.TRANSFERFIELDS(ExampleDocumentLine);
        ExampleHistoryOneLine.INSERT;
      UNTIL NEXT = 0;
    END;
  end;

  LOCAL PROCEDURE PostExampleTwo(VAR ExDoc : Record 72050003);
  var
    ExampleHistoryTwo : Record 72050018;
    ExampleHistoryTwoLine : Record 72050019;
    ExampleDocumentLine : Record 72050004;
  begin
    WITH ExampleHistoryTwo DO BEGIN
      TRANSFERFIELDS(ExDoc);
      INSERT;
    END;

    WITH ExampleDocumentLine DO BEGIN
      SETRANGE("Document No.", ExDoc."No.");
      IF FINDSET THEN REPEAT
        ExampleHistoryTwoLine.TRANSFERFIELDS(ExampleDocumentLine);
        ExampleHistoryTwoLine.INSERT;
      UNTIL NEXT = 0;
    END;
  end;

  LOCAL PROCEDURE DeleteExampeDocument(VAR ExDoc : Record 72050003);
  begin
    OnBeforeDelete;
    WITH ExDoc DO
      DELETE;
  end;

  PROCEDURE SetArguments(VAR ArgumentsIn : Record 72050002);
  begin
    Arguments := ArgumentsIn;
  end;

  LOCAL PROCEDURE PostExJnlLine(ExDoc : Record 72050003);
  var
    ExampleDocumentLine : Record 72050004;
    ExJnlLine : Record 72050013;
    ExJnlPostLine : Codeunit 72050003;
  begin
    WITH ExDoc DO BEGIN
      ExampleDocumentLine.SETRANGE("Document No.", "No.");
      IF ExampleDocumentLine.FINDSET THEN REPEAT
        ExJnlLine.INIT;
        ExJnlLine."Posting Date" := "Posting Date";
        ExJnlLine."Document Date" := "Document Date";
        ExJnlLine."Example Person No." := "Example Person No.";
        ExJnlLine."Example Product No." := ExampleDocumentLine."Example Product No.";
        ExJnlLine.Description := ExampleDocumentLine.Description;
        ExJnlLine.Quantity := 1;
        ExJnlPostLine.RunWithCheck(ExJnlLine);
      UNTIL ExampleDocumentLine.NEXT = 0;
    END;
  end;

  [Business(false)]
  LOCAL PROCEDURE OnAfterTestNear();
  begin
  end;

  [Business(false)]
  LOCAL PROCEDURE OnBeforeDelete();
  begin
  end;
}

