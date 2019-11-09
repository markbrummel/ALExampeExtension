codeunit 50111 "Example Notifications"
{
    // version Exercise 1


    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Page, 50020, 'OnAfterGetCurrRecordEvent', '', false, false)]
    LOCAL PROCEDURE ShowNotificationWhenNoProductPrices(VAR Rec: Record 50020);
    var
        MyNotifications: Record "My Notifications";
        ExampleProduct: Record "Example Product";
        ExampleProductPrice: Record "Example Product Price";
        MyNotification: Notification;
    begin
        IF NOT MyNotifications.IsEnabled('ce50e6d7-ca3c-496d-8352-2f6cce9a4178') THEN
            EXIT;

        ExampleProductPrice.SETRANGE("Product No.", Rec."No.");
        IF NOT ExampleProductPrice.ISEMPTY THEN
            EXIT;

        ExampleProduct := Rec;
        ExampleProduct.SETRECFILTER;

        MyNotification.ID := 'ce50e6d7-ca3c-496d-8352-2f6cce9a4178';
        MyNotification.MESSAGE := 'There are no prices setup for this product, do you want to do this now?';
        MyNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
        MyNotification.SETDATA('Rec', ExampleProduct.GETVIEW);

        MyNotification.ADDACTION('Yes', CODEUNIT::"Example Notification Actions", 'SetupPrices');
        MyNotification.ADDACTION('Do no show again', CODEUNIT::"Example Notification Actions", 'HideSetupPrices');
        MyNotification.SEND;
    end;
}

