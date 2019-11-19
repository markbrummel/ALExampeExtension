codeunit 50113 "Example Notification Actions"
{
    PROCEDURE SetupPrices(VAR MyNotification: Notification);
    var
        ExampleProduct: Record "Example Product";
        ExampleProductPrice: Record "Example Product Price";
    begin
        ExampleProduct.SETVIEW(MyNotification.GETDATA('Rec'));
        ExampleProduct.FINDFIRST;
        ExampleProductPrice.SETRANGE("Product No.", ExampleProduct."No.");
        PAGE.RUN(0, ExampleProductPrice);
    end;

    PROCEDURE HideSetupPrices(VAR MyNotification: Notification);
    var
        MyNotifications: Record 1518;
        NotificationID: Guid;
    begin
        MyNotifications.LOCKTABLE;
        NotificationID := MyNotification.ID;
        IF MyNotifications.GET(USERID, NotificationID) THEN BEGIN
            MyNotifications.Enabled := FALSE;
            MyNotifications.MODIFY;
        END;
    end;
}

