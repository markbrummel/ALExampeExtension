codeunit 50112 "Example Notifications Init."
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Page, 1518, 'OnInitializingNotificationWithDefaultState', '', false, false)]
    LOCAL PROCEDURE OnInitializingNotificationWithDefaultState();
    var
        MyNotifications: Record 1518;
        ExampleProductPriceTxt: TextConst ENU = 'Show Create Example Price';
        ExampleProductPriceDescriptionTxt: TextConst ENU = 'Show Create Example Price';
    begin
        MyNotifications.InsertDefaultWithTableNum('ce50e6d7-ca3c-496d-8352-2f6cce9a4178',
          ExampleProductPriceTxt,
          ExampleProductPriceDescriptionTxt,
          DATABASE::"Example Product");
    end;
}

