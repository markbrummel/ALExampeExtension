codeunit 72050001 "Example-Post (Yes/No)"
{
  // version Exercise 4

  TableNo=72050003;

  trigger OnRun();
  begin
    IF AskDocumentType(Rec) THEN
      PostTheDocument(Rec)
  end;

  PROCEDURE AskDocumentType(VAR ExDoc : Record 72050003) : Boolean;
  var
    DocumentTypeStrMenu : TextConst ENU='&One,&Two,One &and Two';
    Selection : Integer;
  begin
    Selection := STRMENU(DocumentTypeStrMenu,3);
    IF Selection = 0 THEN
      EXIT(FALSE);

    WITH ExDoc DO BEGIN
      One := Selection IN [1,3];
      Two := Selection IN [2,3];
    END;

    EXIT(TRUE);
  end;

  PROCEDURE PostTheDocument(VAR ExDoc : Record 72050003);
  var
    ExamplePost : Codeunit 72050000;
  begin
    ExamplePost.RUN(ExDoc);
  end;
}

