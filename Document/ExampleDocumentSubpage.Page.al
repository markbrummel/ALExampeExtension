page 50005 "Example Document Subpage"
{
  // version Exercise 4

  AutoSplitKey=true;
  PageType=ListPart;
  SourceTable="Example Document Line";

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("Example Product No.";"Example Product No.")
        {
        }
        field(Description;Description)
        {
        }
      }
    }
  }

  actions
  {
  }
}

