table 50013 "Ex. Journal Line"
{
    // version Exercise 3

    CaptionML = ENU = 'Ex. Journal Line',
            ESM = 'Lín. diario recurso',
            FRC = 'Ligne journal ressource',
            ENC = 'Ex. Journal Line';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                ESM = 'Nombre libro diario',
                FRC = 'Nom modèle journal',
                ENC = 'Journal Template Name';
            TableRelation = "Ex. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                ESM = 'Nº línea',
                FRC = 'N° ligne',
                ENC = 'Line No.';
        }
        field(3; "Entry Type"; Option)
        {
            CaptionML = ENU = 'Entry Type',
                ESM = 'Tipo movimiento',
                FRC = 'Type d''écriture',
                ENC = 'Entry Type';
            OptionCaptionML = ENU = 'Usage,Sale',
                      ESM = 'Consumo,Venta',
                      FRC = 'Utilisation,Vente',
                      ENC = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(4; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                ESM = 'Nº documento',
                FRC = 'N° de document',
                ENC = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                ESM = 'Fecha registro',
                FRC = 'Date de report',
                ENC = 'Posting Date';

            trigger OnValidate();
            begin
                VALIDATE("Document Date", "Posting Date");
            end;
        }
        field(6; "Example Person No."; Code[20])
        {
            CaptionML = ENU = 'Example Person No.';
            TableRelation = "Example Person";
        }
        field(7; "Example Product No."; Code[20])
        {
            CaptionML = ENU = 'Example Product No.';
            TableRelation = "Example Product";
        }
        field(8; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                ESM = 'Descripción',
                FRC = 'Description',
                ENC = 'Description';
        }
        field(12; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                ESM = 'Cantidad',
                FRC = 'Quantité',
                ENC = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                ESM = 'Cód. dim. acceso dir. 1',
                FRC = 'Code raccourci de dimension 1',
                ENC = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                ESM = 'Cód. dim. acceso dir. 2',
                FRC = 'Code raccourci de dimension 2',
                ENC = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(21; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                ESM = 'Cód. origen',
                FRC = 'Code d''origine',
                ENC = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                ESM = 'Nombre sección diario',
                FRC = 'Nom lot de journal',
                ENC = 'Journal Batch Name';
            TableRelation = "Ex. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(24; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                ESM = 'Cód. auditoría',
                FRC = 'Code motif',
                ENC = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(25; "Recurring Method"; Option)
        {
            BlankZero = true;
            CaptionML = ENU = 'Recurring Method',
                ESM = 'Periodicidad',
                FRC = 'Méthode récurrente',
                ENC = 'Recurring Method';
            OptionCaptionML = ENU = ',Fixed,Variable',
                      ESM = ',Fija,Variable',
                      FRC = ',Fixe,Variable',
                      ENC = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(26; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date',
                ESM = 'Fecha caducidad',
                FRC = 'Date d''expiration',
                ENC = 'Expiration Date';
        }
        field(27; "Recurring Frequency"; DateFormula)
        {
            CaptionML = ENU = 'Recurring Frequency',
                ESM = 'Frecuencia repetición',
                FRC = 'Fréquence de récurrence',
                ENC = 'Recurring Frequency';
        }
        field(28; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                ESM = 'Grupo contable negocio',
                FRC = 'Groupe de report de marché',
                ENC = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(29; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                ESM = 'Grupo contable producto',
                FRC = 'Groupe de report de produit',
                ENC = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(30; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                ESM = 'Fecha emisión documento',
                FRC = 'Date document',
                ENC = 'Document Date';
        }
        field(31; "External Document No."; Code[35])
        {
            CaptionML = ENU = 'External Document No.',
                ESM = 'Nº documento externo',
                FRC = 'N° document externe',
                ENC = 'External Document No.';
        }
        field(32; "Posting No. Series"; Code[10])
        {
            CaptionML = ENU = 'Posting No. Series',
                ESM = 'Nº serie registro',
                FRC = 'Séries de n° report',
                ENC = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                ESM = 'Id. grupo dimensiones',
                FRC = 'Code ensemble de dimensions',
                ENC = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDimensions;
            end;
        }
        field(959; "System-Created Entry"; Boolean)
        {
            CaptionML = ENU = 'System-Created Entry',
                ESM = 'Asiento automático',
                FRC = 'Écriture système',
                ENC = 'System-Created Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        LOCKTABLE;
        ExJnlTemplate.GET("Journal Template Name");
        ExJnlBatch.GET("Journal Template Name", "Journal Batch Name");

        ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
    end;

    var
        ExJnlTemplate: Record 50012;
        ExJnlBatch: Record 50014;
        ExJnlLine: Record 50013;
        ExamplePerson: Record 50010;
        GLSetup: Record 98;
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit 408;
        GLSetupRead: Boolean;

    PROCEDURE EmptyLine(): Boolean;
    begin
        EXIT(("Example Person No." = '') AND ("Example Product No." = '') AND (Quantity = 0));
    end;

    PROCEDURE SetUpNewLine(LastExJnlLine: Record 50013);
    begin
        ExJnlTemplate.GET("Journal Template Name");
        ExJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        ExJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        ExJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF ExJnlLine.FINDFIRST THEN BEGIN
            "Posting Date" := LastExJnlLine."Posting Date";
            "Document Date" := LastExJnlLine."Posting Date";
            "Document No." := LastExJnlLine."Document No.";
        END ELSE BEGIN
            "Posting Date" := WORKDATE;
            "Document Date" := WORKDATE;
            IF ExJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.TryGetNextNo(ExJnlBatch."No. Series", "Posting Date");
            END;
        END;
        "Recurring Method" := LastExJnlLine."Recurring Method";
        "Source Code" := ExJnlTemplate."Source Code";
        "Reason Code" := ExJnlBatch."Reason Code";
        "Posting No. Series" := ExJnlBatch."Posting No. Series";
    end;

    PROCEDURE CreateDim(Type1: Integer; No1: Code[20]);
    var
        TableID: ARRAY[10] OF Integer;
        No: ARRAY[10] OF Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;

    PROCEDURE ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    PROCEDURE LookupShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    PROCEDURE ShowShortcutDimCode(VAR ShortcutDimCode: ARRAY[8] OF Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    LOCAL PROCEDURE GetGLSetup();
    begin
        IF NOT GLSetupRead THEN
            GLSetup.GET;
        GLSetupRead := TRUE;
    end;

    PROCEDURE ShowDimensions();
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    PROCEDURE PostSingle();
    var
        ExampleJnlPostLine: Codeunit "Exampl Jnl.-Post Line";
    begin
        ExampleJnlPostLine.RUN(Rec);
    end;
}

