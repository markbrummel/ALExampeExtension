table 50000 ExampleSetup
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key';
        }
        field(2; "Example Enabled"; Boolean)
        {
            CaptionML = ENU = 'Example Enabled';
            //            FieldPropertyName = FieldPropertyValue;
        }
        field(10; "Example Person Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Example Product Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "Example Document Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(40; "Scale Code"; Code[10])
        {
            TableRelation = "Example Scale";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure InitSetupRecord();
    begin
        If not get then begin
            Init;
            Insert;
        end;
    end;
}