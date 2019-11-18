codeunit 50020 "Example Product Price Mgt."
{
    PROCEDURE GetSalesPrice(ExampleProduct: Record "Example Product"; PersonNo: Code[20]): Decimal;
    var
        ExampleProductPrice: Record "Example Product Price";
    begin
        WITH ExampleProduct DO
            EXIT("Sales Price");

        WITH ExampleProductPrice DO BEGIN
            IF GET(ExampleProduct."No.", PersonNo) THEN
                EXIT("Sales Price");

            IF GET(ExampleProduct."No.") THEN
                EXIT("Sales Price");
        END;
    end;
}

