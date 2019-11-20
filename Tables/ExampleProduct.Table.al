table 50020 "Example Product"
{

    Caption = 'Example Person';

    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.';

            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    ExampleSetup.GET;
                    NoSeriesMgt.TestManual(ExampleSetup."Example Product Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(3; Description; Text[50])
        {
            CaptionML = ENU = 'Description';

            trigger OnValidate();
            begin
                IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
                    "Search Description" := Description;
            end;
        }
        field(4; "Search Description"; Code[50])
        {
            CaptionML = ENU = 'Search Description';
        }
        field(5; "Description 2"; Text[50])
        {
            CaptionML = ENU = 'Description 2';
        }
        field(8; "Sales Price"; Decimal)
        {
        }
        field(54; Blocked; Boolean)
        {
            CaptionML = ENU = 'Blocked';
        }
        field(97; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF "No." = '' THEN BEGIN
            ExampleSetup.GET;
            ExampleSetup.TESTFIELD("Example Product Nos.");
            NoSeriesMgt.InitSeries(ExampleSetup."Example Product Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        ExampleSetup: Record "Example Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    PROCEDURE AssistEdit(): Boolean;
    begin
        ExampleSetup.GET;
        ExampleSetup.TESTFIELD("Example Product Nos.");
        IF NoSeriesMgt.SelectSeries(ExampleSetup."Example Product Nos.", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    PROCEDURE GetSalesPrice(PersonNo: Code[20]): Decimal;
    var
        ExampleProductPriceMgt: Codeunit "Example Product Price Mgt.";
    begin
        WITH ExampleProductPriceMgt DO
            EXIT(GetSalesPrice(Rec, PersonNo));
    end;
}

