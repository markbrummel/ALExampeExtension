codeunit 50140 ExampleDocumentNoVisibility
{
  // version Exercise 1


  trigger OnRun();
  begin
  end;

  PROCEDURE ExamplePersonNoIsVisible() : Boolean;
  var
    NoSeries : Record 308;
    ExampleSetup : Page "Example Setup";
    NoSeriesCode : Code[10];
  begin
    NoSeriesCode := DetermineExamplePersonSeriesNo;

    IF NOT NoSeries.GET(NoSeriesCode) THEN BEGIN
      ExampleSetup.RUNMODAL;
      NoSeriesCode := DetermineExamplePersonSeriesNo;
      IF NOT NoSeries.GET(NoSeriesCode) THEN
        EXIT(TRUE);
    END;

    EXIT(ForceShowNoSeriesForDocNo(NoSeriesCode));
  end;

  PROCEDURE ExampleProductNoIsVisible() : Boolean;
  var
    NoSeries : Record 308;
    NoSeriesCode : Code[10];
  begin
    NoSeriesCode := DetermineExampleProductSeriesNo;

    IF NOT NoSeries.GET(NoSeriesCode) THEN
      EXIT(TRUE);

    EXIT(ForceShowNoSeriesForDocNo(NoSeriesCode));
  end;

  PROCEDURE ExamplePersonNoSeriesIsDefault() : Boolean;
  var
    NoSeries : Record 308;
  begin
    IF NoSeries.GET(DetermineExamplePersonSeriesNo) THEN
      EXIT(NoSeries."Default Nos.");

    EXIT(FALSE);
  end;

  PROCEDURE ExampleProductNoSeriesIsDefault() : Boolean;
  var
    NoSeries : Record 308;
  begin
    IF NoSeries.GET(DetermineExampleProductSeriesNo) THEN
      EXIT(NoSeries."Default Nos.");

    EXIT(FALSE);
  end;

  LOCAL PROCEDURE DetermineExamplePersonSeriesNo() : Code[10];
  var
    ExampleSetup : Record ExampleSetup;
  begin
    ExampleSetup.GET;
    EXIT(ExampleSetup."Example Person Nos.");
  end;

  LOCAL PROCEDURE DetermineExampleProductSeriesNo() : Code[10];
  var
    ExampleSetup : Record ExampleSetup;
  begin
    ExampleSetup.GET;
    EXIT(ExampleSetup."Example Product Nos.");
  end;

  LOCAL PROCEDURE ForceShowNoSeriesForDocNo(NoSeriesCode : Code[10]) : Boolean;
  var
    NoSeries : Record 308;
    NoSeriesRelationship : Record 310;
    NoSeriesMgt : Codeunit NoSeriesManagement;
    SeriesDate : Date;
  begin
    SeriesDate := WORKDATE;
    NoSeries.GET(NoSeriesCode);

    NoSeriesRelationship.SETRANGE(Code,NoSeriesCode);
    IF NOT NoSeriesRelationship.ISEMPTY THEN
      EXIT(TRUE);

    IF NoSeries."Manual Nos." OR (NoSeries."Default Nos." = FALSE) THEN
      EXIT(TRUE);

    EXIT(NoSeriesMgt.GetNextNo3(NoSeriesCode,SeriesDate,FALSE,TRUE) = '');
  end;
}

