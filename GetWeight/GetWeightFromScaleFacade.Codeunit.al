codeunit 50061 "Get Weight From Scale Facade"
{

    PROCEDURE GetWeight(Rec: Variant; VAR WeightArguments: Record 50098);
    VAR
        IsHandled: Boolean;
        IsNotHandled: TextConst;
    BEGIN
        GetWeightEvent(Rec, WeightArguments, IsHandled);

        IF NOT IsHandled THEN
            ERROR('ENU=There is no Scale');
    END;

    [BusinessEvent(false)]
    LOCAL PROCEDURE GetWeightEvent(VAR Rec: Variant; VAR WeightArguments: Record "Weight Arguments"; VAR Handled: Boolean);
    BEGIN
    END;

    PROCEDURE GetCodeunitIDFromScaleSetup(): Integer;
    VAR
        ExampleSetup: Record "Example Setup";
        Scale: Record Scale;
    BEGIN
        WITH ExampleSetup DO BEGIN
            GET;
            IF NOT Scale.GET(ExampleSetup."Scale Code") THEN
                EXIT(0);
        END;

        WITH Scale DO BEGIN
            TESTFIELD("Codeunit ID");
            EXIT("Codeunit ID");
        END;
    END;


}