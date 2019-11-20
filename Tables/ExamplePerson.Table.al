table 50010 "Example Person"
{
    Caption = 'Example Person';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    ExampleSetup.GET;
                    NoSeriesMgt.TestManual(ExampleSetup."Example Person Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';

            trigger OnValidate();
            begin
                IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            CaptionML = ENU = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            CaptionML = ENU = 'Name 2';
        }
        field(5; Address; Text[50])
        {
            CaptionML = ENU = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            CaptionML = ENU = 'Address 2';
        }
        field(7; City; Text[30])
        {
            CaptionML = ENU = 'City';

            trigger OnValidate();
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8; Contact; Text[50])
        {
            CaptionML = ENU = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            CaptionML = ENU = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            CaptionML = ENU = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(39; Blocked; Option)
        {
            CaptionML = ENU = 'Blocked';
            OptionCaptionML = ENU = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(91; "Post Code"; Code[20])
        {
            CaptionML = ENU = 'Post Code';

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(92; County; Text[30])
        {
            CaptionML = ENU = 'County';
        }
        field(107; "No. Series"; Code[10])
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
    var
        ExampleDocumentNoVisibility: Codeunit ExampleDocumentNoVisibility;
    begin
        IF "No." = '' THEN
            IF ExampleDocumentNoVisibility.ExamplePersonNoSeriesIsDefault THEN BEGIN
                ExampleSetup.GET;
                ExampleSetup.TESTFIELD("Example Person Nos.");
                NoSeriesMgt.InitSeries(ExampleSetup."Example Person Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            END;
    end;

    var
        ExampleSetup: Record "Example Setup";
        PostCode: Record 225;
        NoSeriesMgt: Codeunit 396;

    PROCEDURE AssistEdit(OldExamplePerson: Record "Example Person"): Boolean;
    var
        ExamplePerson: Record "Example Person";
    begin
        WITH ExamplePerson DO BEGIN
            ExamplePerson := Rec;
            ExampleSetup.GET;
            ExampleSetup.TESTFIELD("Example Person Nos.");
            IF NoSeriesMgt.SelectSeries(ExampleSetup."Example Person Nos.", OldExamplePerson."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ExamplePerson;
                EXIT(TRUE);
            END;
        END;
    end;

    PROCEDURE FormatAddress(VAR AddrArray: ARRAY[8] OF Text[90]);
    var
        FormatAddress: Codeunit 365;
    begin
        WITH FormatAddress DO
            FormatAddr(AddrArray, Name, "Name 2", Contact, Address, "Address 2", City, "Post Code", County, "Country/Region Code")
    end;

}

