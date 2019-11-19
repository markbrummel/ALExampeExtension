page 50004 "Example Document"
{
  // version Exercise 4

  PageType=Document;
  SourceTable="Example Document Header";

  layout
  {
    area(content)
    {
      group(General)
      {
        field("No.";"No.")
        {

          trigger OnAssistEdit();
          begin
            IF AssistEdit THEN
              CurrPage.UPDATE;
          end;
        }
        field("Example Person No.";"Example Person No.")
        {
        }
        field(Name;Name)
        {
        }
        field("Document Date";"Document Date")
        {
        }
        field("Posting Date";"Posting Date")
        {
        }
      }
      part(Control11;50005)
      {
        SubPageLink="Document No."=FIELD("No.");
      }
    }
  }

  actions
  {
    area(processing)
    {
      group("P&osting")
      {
        CaptionML=ENU='P&osting';
        Image=Post;
        action(Post)
        {
          CaptionML=ENU='P&ost';
          Ellipsis=true;
          Image=PostOrder;
          Promoted=true;
          PromotedCategory=Process;
          PromotedIsBig=true;
          ShortCutKey='F9';

          trigger OnAction();
          begin
            Post(FALSE);
            CurrPage.UPDATE(FALSE);
          end;
        }
        action(BatchPost)
        {
          CaptionML=ENU='Post &Batch';
          Ellipsis=true;
          Image=PostBatch;

          trigger OnAction();
          begin
            PostBatch;
            CurrPage.UPDATE(FALSE)
          end;
        }
      }
      action(GetWeight)
      {
        CaptionML=ENU='GetWeight';
        Image=Giro;
        Promoted=true;
        PromotedCategory=Process;
        PromotedIsBig=true;

        trigger OnAction();
        begin
          GetWeightFromScale;
        end;
      }
    }
  }
}

