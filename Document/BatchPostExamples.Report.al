report 50000 "Batch Post Examples"
{
  // version Exercise 4

  CaptionML=ENU='Batch Post Examples';
  ProcessingOnly=true;

  dataset
  {
    dataitem("Example Document Header";"Example Document Header")
    {
      RequestFilterFields="No.";
      RequestFilterHeadingML=ENU='Example Document';

      trigger OnAfterGetRecord();
      begin
        Counter := Counter + 1;
        Window.UPDATE(1,"No.");
        Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        One := SongReq;
        Two := DanceReq;
        CLEAR(ExPost);
        ExPost.SetArguments(Arguments);
        IF ExPost.RUN("Example Document Header") THEN BEGIN
          CounterOK := CounterOK + 1;
          IF MARKEDONLY THEN
            MARK(FALSE);
        END;
      end;

      trigger OnPostDataItem();
      begin
        Window.CLOSE;
        MESSAGE(ExamplesHaveBeenPosted, CounterOK, CounterTotal);
      end;

      trigger OnPreDataItem();
      begin
        WITH Arguments DO
          ThrowErrorIfNoPostingDateAndReplaceIsSelected;

        CounterTotal := COUNT;
        Window.OPEN(PostExamples);
      end;
    }
  }

  requestpage
  {
    SaveValues=true;

    layout
    {
      area(content)
      {
        group(Options)
        {
          CaptionML=ENU='Options';
          field(Song;SongReq)
          {
            CaptionML=ENU='Song';
          }
          field(Dance;DanceReq)
          {
            CaptionML=ENU='Dance';
          }
          field(PostingDate;Arguments."Posting Date")
          {
            CaptionML=ENU='Posting Date';
          }
          field("Arguments.""Replace Posting Date""";Arguments."Replace Posting Date")
          {
            CaptionML=ENU='Replace Posting Date';
          }
          field("Arguments.""Replace Document Date""";Arguments."Replace Document Date")
          {
            CaptionML=ENU='Replace Document Date';
          }
        }
      }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
      Arguments.INIT;
    end;
  }

  labels
  {
  }

  var
    PostExamples : TextConst ENU='Posting examples  #1########## @2@@@@@@@@@@@@@';
    ExamplesHaveBeenPosted : TextConst ENU='%1 examples out of a total of %2 have now been posted.';
    Arguments : Record 50002;
    ExPost : Codeunit 50000;
    Window : Dialog;
    SongReq : Boolean;
    DanceReq : Boolean;
    CounterTotal : Integer;
    Counter : Integer;
    CounterOK : Integer;
}

