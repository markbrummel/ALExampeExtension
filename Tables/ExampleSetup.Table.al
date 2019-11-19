table 50000 "Example Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[1]) { CaptionML = ENU = 'Primary Key'; }
        field(2; "Example Enabled"; Boolean) { CaptionML = ENU = 'Example Enabled'; }

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
        If not Get then begin
            Init;
            Insert;
        end;
    end;
}