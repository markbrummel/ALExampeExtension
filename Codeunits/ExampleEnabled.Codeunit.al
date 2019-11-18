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

}