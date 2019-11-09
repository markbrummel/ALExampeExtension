codeunit 50102 ExampleCompanyInitialize
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 2, 'OnCompanyInitialize', '', false, false)]
    local procedure InitExampleSetup();
    var
        ExampleSetup : Record ExampleSetup;
    begin
        ExampleSetup.InitSetupRecord;
    end;
}