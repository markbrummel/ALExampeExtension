tableextension 50018 CustomerFormatAddress extends Customer
{
    procedure FormatAddress(VAR AddrArray: ARRAY[8] OF Text[90]);
    var
        FormAddr: Codeunit "Format Address";
    begin
        FormAddr.Customer(AddrArray, Rec);
    end;
}