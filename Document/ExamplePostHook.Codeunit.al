codeunit 50030 "Example-Post Hook"
{
  // version Exercise 4


  trigger OnRun();
  begin
  end;

  PROCEDURE OnBeforeTestNear(VAR ExampleDocumentHeader : Record 50003);
  begin
  end;

  PROCEDURE OnAfterDelete(VAR ExampleDocumentHeader : Record 50003);
  begin
  end;
}

