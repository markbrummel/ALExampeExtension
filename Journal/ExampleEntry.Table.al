table 50011 "Example Entry"
{
    // version Exercise 3

    CaptionML = ENU = 'Ex. Ledger Entry',
            ESM = 'Mov. recurso',
            FRC = 'Détails écritures ressources',
            ENC = 'Ex. Ledger Entry';
    DrillDownPageID = 50014;
    LookupPageID = 50014;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                ESM = 'Nº mov.',
                FRC = 'N° écriture',
                ENC = 'Entry No.';
        }
        field(2; "Entry Type"; Option)
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
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                ESM = 'Nº documento',
                FRC = 'N° de document',
                ENC = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                ESM = 'Fecha registro',
                FRC = 'Date de report',
                ENC = 'Posting Date';
        }
        field(5; "Example Person No."; Code[20])
        {
            CaptionML = ENU = 'Example Person No.';
            TableRelation = "Example Person";
        }
        field(6; "Example Product No."; Code[20])
        {
            CaptionML = ENU = 'Example Product No.';
            TableRelation = "Example Product";
        }
        field(7; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                ESM = 'Descripción',
                FRC = 'Description',
                ENC = 'Description';
        }
        field(11; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                ESM = 'Cantidad',
                FRC = 'Quantité',
                ENC = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            CaptionML = ENU = 'Global Dimension 1 Code',
                ESM = 'Cód. dimensión global 1',
                FRC = 'Code de dimension principal 1',
                ENC = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            CaptionML = ENU = 'Global Dimension 2 Code',
                ESM = 'Cód. dimensión global 2',
                FRC = 'Code de dimension principal 2',
                ENC = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                ESM = 'Id. usuario',
                FRC = 'Code utilisateur',
                ENC = 'User ID';

            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
                //        UserMgt.LookupUserID("User ID"); System App??
            end;
        }
        field(21; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                ESM = 'Cód. origen',
                FRC = 'Code d''origine',
                ENC = 'Source Code';
            TableRelation = "Source Code";
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                ESM = 'Nombre sección diario',
                FRC = 'Nom lot de journal',
                ENC = 'Journal Batch Name';
        }
        field(24; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                ESM = 'Cód. auditoría',
                FRC = 'Code motif',
                ENC = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(25; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                ESM = 'Grupo contable negocio',
                FRC = 'Groupe de report de marché',
                ENC = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(26; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                ESM = 'Grupo contable producto',
                FRC = 'Groupe de report de produit',
                ENC = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(27; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                ESM = 'Fecha emisión documento',
                FRC = 'Date document',
                ENC = 'Document Date';
        }
        field(29; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series',
                ESM = 'Nos. serie',
                FRC = 'Séries de n°',
                ENC = 'No. Series';
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
        field(50000; Autoincement; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Example Person No.", "Posting Date")
        {
        }
        key(Key3; "Entry Type", "Example Person No.", "Posting Date")
        {
            SumIndexFields = Quantity;
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Entry Type", "Document No.", "Posting Date")
        {
        }
    }

    var
        DimMgt: Codeunit 408;

    PROCEDURE ShowDimensions();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Entry No."));
    end;
}

