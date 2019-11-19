table 50003 "Example Document Header"
{
    // version Exercise 4

    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    ExampleSetup.GET;
                    NoSeriesMgt.TestManual(ExampleSetup."Example Document Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(5; "Example Person No."; Code[20])
        {
            TableRelation = "Example Person";

            trigger OnValidate();
            begin
                OnValidateExampleNo;
            end;
        }
        field(6; Name; Text[50])
        {
            CaptionML = ENU = 'Name';
        }
        field(11; "Document Date"; Date)
        {
        }
        field(12; "Posting Date"; Date)
        {
        }
        field(57; One; Boolean)
        {
        }
        field(58; Two; Boolean)
        {
        }
        field(97; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF "No." = '' THEN BEGIN
            ExampleSetup.GET;
            ExampleSetup.TESTFIELD("Example Document Nos.");
            NoSeriesMgt.InitSeries(ExampleSetup."Example Document Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        ExampleSetup: Record 50000;
        NoSeriesMgt: Codeunit 396;

    PROCEDURE AssistEdit(): Boolean;
    begin
        ExampleSetup.GET;
        ExampleSetup.TESTFIELD("Example Document Nos.");
        IF NoSeriesMgt.SelectSeries(ExampleSetup."Example Document Nos.", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    PROCEDURE OnValidateExampleNo();
    var
        ExamplePerson: Record 50010;
    begin
        IF NOT ExamplePerson.GET("Example Person No.") THEN
            ExamplePerson.INIT;

        Name := ExamplePerson.Name;
        "Posting Date" := WORKDATE;
        "Document Date" := WORKDATE;
    end;

    PROCEDURE Post(HideDialog: Boolean);
    var
        ExPostYesNo: Codeunit 50001;
        ExamplePost: Codeunit 50000;
    begin
        IF HideDialog THEN BEGIN
            One := TRUE;
            Two := TRUE;
            ExamplePost.RUN(Rec)
        END ELSE
            ExPostYesNo.RUN(Rec);
    end;

    PROCEDURE PostBatch();
    begin
        REPORT.RUNMODAL(REPORT::"Batch Post Examples", TRUE, TRUE, Rec);
    end;

    PROCEDURE GetWeightFromScale();
    var
        WeightArguments: Record 50098;
        GetWeightFromScaleFacade: Codeunit "Get Weight From Scale Facade";
    begin
        GetWeightFromScaleFacade.GetWeight(Rec, WeightArguments);

        MESSAGE(FORMAT(WeightArguments.Weight));
    end;
}

