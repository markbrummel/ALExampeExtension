codeunit 50100 "Example Enabled"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure CreateExampleSetup()
    var
        ExampleSetup: Record "Example Setup";
    begin
        with ExampleSetup do
            InitSetupRecord;
    end;

    procedure GetExampleEnabled(): Boolean
    var
        ExampleSetup: Record "Example Setup";
        UserSetup: Record "User Setup";
    begin
        if UserSetup.get(UserId) then begin
            if UserSetup."Example Enabled" then
                exit(true);
        end;
        with ExampleSetup do begin
            Get;
            exit("Example Enabled");
        end;
    end;


}