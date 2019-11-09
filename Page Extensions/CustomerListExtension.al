pageextension 50022 CustomerListExtension extends "Customer List"
{

    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst("&Customer")
        {
            action("Example Setup")
            {
                Image = Setup;
                RunObject = page "Example Setup";
            }
        }
    }
}

