codeunit 50010 ExJnlManagement
{
  // version Exercise 3

  trigger OnRun();
  begin
  end;

  var
    Text000 : TextConst ENU='EXAMPLES';
    Text001 : TextConst ENU='Example Journals';
    Text002 : TextConst ENU='RECURRING';
    Text003 : TextConst ENU='Recurring Example Journal';
    Text004 : TextConst ENU='DEFAULT';
    Text005 : TextConst ENU='Default Journal';
    OldExNo : Code[20];
    OpenFromBatch : Boolean;

  PROCEDURE TemplateSelection(PageID : Integer;RecurringJnl : Boolean;VAR ExJnlLine : Record 50013;VAR JnlSelected : Boolean);
  var
    ExJnlTemplate : Record 50012;
  begin
    JnlSelected := TRUE;

    ExJnlTemplate.RESET;
    ExJnlTemplate.SETRANGE("Page ID",PageID);
    ExJnlTemplate.SETRANGE(Recurring,RecurringJnl);

    CASE ExJnlTemplate.COUNT OF
      0:
        BEGIN
          ExJnlTemplate.INIT;
          ExJnlTemplate.Recurring := RecurringJnl;
          IF NOT RecurringJnl THEN BEGIN
            ExJnlTemplate.Name := Text000;
            ExJnlTemplate.Description := Text001;
          END ELSE BEGIN
            ExJnlTemplate.Name := Text002;
            ExJnlTemplate.Description := Text003;
          END;
          ExJnlTemplate.VALIDATE("Page ID");
          ExJnlTemplate.INSERT;
          COMMIT;
        END;
      1:
        ExJnlTemplate.FINDFIRST;
      ELSE
        JnlSelected := PAGE.RUNMODAL(0,ExJnlTemplate) = ACTION::LookupOK;
    END;
    IF JnlSelected THEN BEGIN
      ExJnlLine.FILTERGROUP := 2;
      ExJnlLine.SETRANGE("Journal Template Name",ExJnlTemplate.Name);
      ExJnlLine.FILTERGROUP := 0;
      IF OpenFromBatch THEN BEGIN
        ExJnlLine."Journal Template Name" := '';
        PAGE.RUN(ExJnlTemplate."Page ID",ExJnlLine);
      END;
    END;
  end;

  PROCEDURE TemplateSelectionFromBatch(VAR ExJnlBatch : Record 50014);
  var
    ExJnlLine : Record 50013;
    ExJnlTemplate : Record 50012;
  begin
    OpenFromBatch := TRUE;
    ExJnlTemplate.GET(ExJnlBatch."Journal Template Name");
    ExJnlTemplate.TESTFIELD("Page ID");
    ExJnlBatch.TESTFIELD(Name);

    ExJnlLine.FILTERGROUP := 2;
    ExJnlLine.SETRANGE("Journal Template Name",ExJnlTemplate.Name);
    ExJnlLine.FILTERGROUP := 0;

    ExJnlLine."Journal Template Name" := '';
    ExJnlLine."Journal Batch Name" := ExJnlBatch.Name;
    PAGE.RUN(ExJnlTemplate."Page ID",ExJnlLine);
  end;

  PROCEDURE OpenJnl(VAR CurrentJnlBatchName : Code[10];VAR ExJnlLine : Record 50013);
  begin
    CheckTemplateName(ExJnlLine.GETRANGEMAX("Journal Template Name"),CurrentJnlBatchName);
    ExJnlLine.FILTERGROUP := 2;
    ExJnlLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
    ExJnlLine.FILTERGROUP := 0;
  end;

  PROCEDURE OpenJnlBatch(VAR ExJnlBatch : Record 50014);
  var
    ExJnlTemplate : Record 50012;
    ExJnlLine : Record 50013;
    JnlSelected : Boolean;
  begin
    IF ExJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
      EXIT;
    ExJnlBatch.FILTERGROUP(2);
    IF ExJnlBatch.GETFILTER("Journal Template Name") <> '' THEN BEGIN
      ExJnlBatch.FILTERGROUP(0);
      EXIT;
    END;
    ExJnlBatch.FILTERGROUP(0);

    IF NOT ExJnlBatch.FIND('-') THEN BEGIN
      IF NOT ExJnlTemplate.FINDFIRST THEN
        TemplateSelection(0,FALSE,ExJnlLine,JnlSelected);
      IF ExJnlTemplate.FINDFIRST THEN
        CheckTemplateName(ExJnlTemplate.Name,ExJnlBatch.Name);
      ExJnlTemplate.SETRANGE(Recurring,TRUE);
      IF NOT ExJnlTemplate.FINDFIRST THEN
        TemplateSelection(0,TRUE,ExJnlLine,JnlSelected);
      IF ExJnlTemplate.FINDFIRST THEN
        CheckTemplateName(ExJnlTemplate.Name,ExJnlBatch.Name);
      ExJnlTemplate.SETRANGE(Recurring);
    END;
    ExJnlBatch.FIND('-');
    JnlSelected := TRUE;
    ExJnlBatch.CALCFIELDS(Recurring);
    ExJnlTemplate.SETRANGE(Recurring,ExJnlBatch.Recurring);
    IF ExJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
      ExJnlTemplate.SETRANGE(Name,ExJnlBatch.GETFILTER("Journal Template Name"));
    CASE ExJnlTemplate.COUNT OF
      1:
        ExJnlTemplate.FINDFIRST;
      ELSE
        JnlSelected := PAGE.RUNMODAL(0,ExJnlTemplate) = ACTION::LookupOK;
    END;
    IF NOT JnlSelected THEN
      ERROR('');

    ExJnlBatch.FILTERGROUP(2);
    ExJnlBatch.SETRANGE("Journal Template Name",ExJnlTemplate.Name);
    ExJnlBatch.FILTERGROUP(0);
  end;

  PROCEDURE CheckTemplateName(CurrentJnlTemplateName : Code[10];VAR CurrentJnlBatchName : Code[10]);
  var
    ExJnlBatch : Record 50014;
  begin
    ExJnlBatch.SETRANGE("Journal Template Name",CurrentJnlTemplateName);
    IF NOT ExJnlBatch.GET(CurrentJnlTemplateName,CurrentJnlBatchName) THEN BEGIN
      IF NOT ExJnlBatch.FINDFIRST THEN BEGIN
        ExJnlBatch.INIT;
        ExJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
        ExJnlBatch.SetupNewBatch;
        ExJnlBatch.Name := Text004;
        ExJnlBatch.Description := Text005;
        ExJnlBatch.INSERT(TRUE);
        COMMIT;
      END;
      CurrentJnlBatchName := ExJnlBatch.Name;
    END;
  end;

  PROCEDURE CheckName(CurrentJnlBatchName : Code[10];VAR ExJnlLine : Record 50013);
  var
    ExJnlBatch : Record 50014;
  begin
    ExJnlBatch.GET(ExJnlLine.GETRANGEMAX("Journal Template Name"),CurrentJnlBatchName);
  end;

  PROCEDURE SetName(CurrentJnlBatchName : Code[10];VAR ExJnlLine : Record 50013);
  begin
    ExJnlLine.FILTERGROUP := 2;
    ExJnlLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
    ExJnlLine.FILTERGROUP := 0;
    IF ExJnlLine.FIND('-') THEN;
  end;

  PROCEDURE LookupName(VAR CurrentJnlBatchName : Code[10];VAR ExJnlLine : Record 50013) : Boolean;
  var
    ExJnlBatch : Record 50014;
  begin
    COMMIT;
    ExJnlBatch."Journal Template Name" := ExJnlLine.GETRANGEMAX("Journal Template Name");
    ExJnlBatch.Name := ExJnlLine.GETRANGEMAX("Journal Batch Name");
    ExJnlBatch.FILTERGROUP(2);
    ExJnlBatch.SETRANGE("Journal Template Name",ExJnlBatch."Journal Template Name");
    ExJnlBatch.FILTERGROUP(0);
    IF PAGE.RUNMODAL(0,ExJnlBatch) = ACTION::LookupOK THEN BEGIN
      CurrentJnlBatchName := ExJnlBatch.Name;
      SetName(CurrentJnlBatchName,ExJnlLine);
    END;
  end;

  PROCEDURE GetEx(ExNo : Code[20];VAR ExName : Text[50]);
  var
    ExamplePerson : Record 50010;
  begin
    IF ExNo <> OldExNo THEN BEGIN
      ExName := '';
      IF ExNo <> '' THEN
        IF ExamplePerson.GET(ExNo) THEN
          ExName := ExamplePerson.Name;
      OldExNo := ExNo;
    END;
  end;
}

