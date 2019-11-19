table 50012 "Ex. Journal Template"
{
  // version Exercise 3

  CaptionML=ENU='Ex. Journal Template',
            ESM='Libro del diario recurso',
            FRC='Modèle journal ressources',
            ENC='Ex. Journal Template';
  DrillDownPageID=50015;
  LookupPageID=50015;

  fields
  {
    field(1;Name;Code[10])
    {
      CaptionML=ENU='Name',
                ESM='Nombre',
                FRC='Nom',
                ENC='Name';
      NotBlank=true;
    }
    field(2;Description;Text[80])
    {
      CaptionML=ENU='Description',
                ESM='Descripción',
                FRC='Description',
                ENC='Description';
    }
    field(5;"Test Report ID";Integer)
    {
      CaptionML=ENU='Test Report ID',
                ESM='Nº informe prueba',
                FRC='Code de rapport de test',
                ENC='Test Report ID';
      //TableRelation=Object.ID WHERE (Type=CONST(Report));
    }
    field(6;"Page ID";Integer)
    {
      CaptionML=ENU='Page ID',
                ESM='Id. página',
                FRC='Code page',
                ENC='Page ID';
      //TableRelation=Object.ID WHERE (Type=CONST(Page));

      trigger OnValidate();
      begin
        IF "Page ID" = 0 THEN
          VALIDATE(Recurring);
      end;
    }
    field(7;"Posting Report ID";Integer)
    {
      CaptionML=ENU='Posting Report ID',
                ESM='Nº informe para registro',
                FRC='Code de rapport sur le report',
                ENC='Posting Report ID';
    }
    field(8;"Force Posting Report";Boolean)
    {
      CaptionML=ENU='Force Posting Report',
                ESM='Forzar informe para registro',
                FRC='Forcer rapport sur le report',
                ENC='Force Posting Report';
    }
    field(10;"Source Code";Code[10])
    {
      CaptionML=ENU='Source Code',
                ESM='Cód. origen',
                FRC='Code d''origine',
                ENC='Source Code';
      TableRelation="Source Code";

      trigger OnValidate();
      begin
        ExJnlLine.SETRANGE("Journal Template Name",Name);
        ExJnlLine.MODIFYALL("Source Code","Source Code");
        MODIFY;
      end;
    }
    field(11;"Reason Code";Code[10])
    {
      CaptionML=ENU='Reason Code',
                ESM='Cód. auditoría',
                FRC='Code motif',
                ENC='Reason Code';
      TableRelation="Reason Code";
    }
    field(12;Recurring;Boolean)
    {
      CaptionML=ENU='Recurring',
                ESM='Periódico',
                FRC='Récurrent',
                ENC='Recurring';

      trigger OnValidate();
      begin
        "Page ID" := PAGE::"Example Journal";
        //"Test Report ID" := REPORT::Report5002;
        "Posting Report ID" := REPORT::"Example Register";
        SourceCodeSetup.GET;
        "Source Code" := SourceCodeSetup."Example Journal";
        IF Recurring THEN
          TESTFIELD("No. Series",'');
      end;
    }
    field(13;"Test Report Caption";Text[250])
    {
      CaptionML=ENU='Test Report Caption',
                ESM='Título informe prueba',
                FRC='Libellé du rapport de test',
                ENC='Test Report Caption';
      Editable=false;
    }
    field(14;"Page Caption";Text[250])
    {
      CaptionML=ENU='Page Caption',
                ESM='Título página',
                FRC='Légende de la page',
                ENC='Page Caption';
      Editable=false;
    }
    field(15;"Posting Report Caption";Text[250])
    {
      CaptionML=ENU='Posting Report Caption',
                ESM='Título del informe de registro',
                FRC='Libellé du rapport de report',
                ENC='Posting Report Caption';
      Editable=false;
    }
    field(16;"No. Series";Code[10])
    {
      CaptionML=ENU='No. Series',
                ESM='Nos. serie',
                FRC='Séries de n°',
                ENC='No. Series';
      TableRelation="No. Series";

      trigger OnValidate();
      begin
        IF "No. Series" <> '' THEN BEGIN
          IF Recurring THEN
            ERROR(
              Text000,
              FIELDCAPTION("Posting No. Series"));
          IF "No. Series" = "Posting No. Series" THEN
            "Posting No. Series" := '';
        END;
      end;
    }
    field(17;"Posting No. Series";Code[10])
    {
      CaptionML=ENU='Posting No. Series',
                ESM='Nº serie registro',
                FRC='Séries de n° report',
                ENC='Posting No. Series';
      TableRelation="No. Series";

      trigger OnValidate();
      begin
        IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
      end;
    }
  }

  keys
  {
    key(Key1;Name)
    {
      Clustered=true;
    }
  }

  fieldgroups
  {
  }

  trigger OnDelete();
  begin
    ExJnlLine.SETRANGE("Journal Template Name",Name);
    ExJnlLine.DELETEALL(TRUE);
    ExJnlBatch.SETRANGE("Journal Template Name",Name);
    ExJnlBatch.DELETEALL;
  end;

  trigger OnInsert();
  begin
    VALIDATE("Page ID");
  end;

  var
    Text000 : TextConst ENU='Only the %1 field can be filled in on recurring journals.',ESM='Sólo se debe completar el campo %1 en los diarios periódicos.',FRC='Seul le champ %1 peut être rempli sur les journaux récurrents.',ENC='Only the %1 field can be filled in on recurring journals.';
    Text001 : TextConst ENU='must not be %1',ESM='No puede ser %1.',FRC='ne doit pas être %1',ENC='must not be %1';
    ExJnlBatch : Record 50014;
    ExJnlLine : Record 50013;
    SourceCodeSetup : Record 242;
}

