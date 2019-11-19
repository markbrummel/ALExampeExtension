page 50003 "Example Document List"
{
  // version Exercise 4

  CardPageID="Example Document";
  Editable=false;
  PageType=List;
  SourceTable="Example Document Header";

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("No.";"No.")
        {
        }
        field("Example Person No.";"Example Person No.")
        {
        }
        field(Name;Name)
        {
        }
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

