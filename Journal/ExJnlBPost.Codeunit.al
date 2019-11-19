codeunit 50007 "Ex. Jnl.-B.Post"
{
  // version Exercise 3

  TableNo=50014;

  trigger OnRun();
  begin
    ExJnlBatch.COPY(Rec);
    Code;
    Rec := ExJnlBatch;
  end;

  var
    Text000 : TextConst ENU='Do you want to post the journals?',ESM='¿Confirma que desea registrar los diarios?',FRC='Voulez-vous reporter les journaux?',ENC='Do you want to post the journals?';
    Text001 : TextConst ENU='The journals were successfully posted.',ESM='Se han registrado correctamente los diarios.',FRC='Le journal a été reporté avec succès.',ENC='The journals were successfully posted.';
    Text002 : TextConst ENU='It was not possible to post all of the journals. ',ESM='No ha sido posible registrar todos los diarios. ',FRC='Il a été impossible de reporter tous les journaux. ',ENC='It was not possible to post all of the journals. ';
    Text003 : TextConst ENU='The journals that were not successfully posted are now marked.',ESM='Los diarios que no se han registrado están marcados.',FRC='Les journaux qui n''ont pas été reportés sont maintenant indiqués.',ENC='The journals that were not successfully posted are now marked.';
    ExJnlTemplate : Record 50012;
    ExJnlBatch : Record 50014;
    ExJnlLine : Record 50013;
    ExJnlPostBatch : Codeunit 50004;
    JnlWithErrors : Boolean;

  LOCAL PROCEDURE "Code"();
  begin
    WITH ExJnlBatch DO BEGIN
      ExJnlTemplate.GET("Journal Template Name");
      ExJnlTemplate.TESTFIELD("Force Posting Report",FALSE);

      IF NOT CONFIRM(Text000) THEN
        EXIT;

      FIND('-');
      REPEAT
        ExJnlLine."Journal Template Name" := "Journal Template Name";
        ExJnlLine."Journal Batch Name" := Name;
        ExJnlLine."Line No." := 1;
        CLEAR(ExJnlPostBatch);
        IF ExJnlPostBatch.RUN(ExJnlLine) THEN
          MARK(FALSE)
        ELSE BEGIN
          MARK(TRUE);
          JnlWithErrors := TRUE;
        END;
      UNTIL NEXT = 0;

      IF NOT JnlWithErrors THEN
        MESSAGE(Text001)
      ELSE
        MESSAGE(
          Text002 +
          Text003);

      IF NOT FIND('=><') THEN BEGIN
        RESET;
        FILTERGROUP(2);
        SETRANGE("Journal Template Name","Journal Template Name");
        FILTERGROUP(0);
        Name := '';
      END;
    END;
  end;
}

