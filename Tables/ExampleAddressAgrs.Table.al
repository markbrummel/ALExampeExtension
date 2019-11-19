table 50099 "Address Agruments"
{
    fields
    {
        field(2; Name; Text[100]) { }
        field(4; "Name 2"; Text[50]) { }
        field(5; Address; Text[100]) { }
        field(6; "Address 2"; Text[50]) { }
        field(7; City; Text[30]) { }
        field(8; Contact; Text[100]) { }
        field(35; "Country/Region Code"; Code[10]) { }
        field(91; "Post Code"; Code[20]) { }
        field(92; County; Text[30]) { }
    }
    PROCEDURE FormatAddr(VAR AddrArray: ARRAY[8] OF Text[90]);
    var
        GLSetup: Record 98;
        i: Integer;
        Country: Record 9;
        InsertText: Integer;
        Index: Integer;
        NameLineNo: Integer;
        Name2LineNo: Integer;
        AddrLineNo: Integer;
        Addr2LineNo: Integer;
        ContLineNo: Integer;
        PostCodeCityLineNo: Integer;
        CountyLineNo: Integer;
        CountryLineNo: Integer;
    begin
        CLEAR(AddrArray);

        IF "Country/Region Code" = '' THEN BEGIN
            GLSetup.GET;
            CLEAR(Country);
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET("Country/Region Code");

        CASE Country."Contact Address Format" OF
            Country."Contact Address Format"::First:
                BEGIN
                    NameLineNo := 2;
                    Name2LineNo := 3;
                    ContLineNo := 1;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 7;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::"After Company Name":
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 3;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 7;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::Last:
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 8;
                    AddrLineNo := 3;
                    Addr2LineNo := 4;
                    PostCodeCityLineNo := 5;
                    CountyLineNo := 6;
                    CountryLineNo := 7;
                END;
        END;

        AddrArray[NameLineNo] := Name;
        AddrArray[Name2LineNo] := "Name 2";
        AddrArray[AddrLineNo] := Address;
        AddrArray[Addr2LineNo] := "Address 2";

        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City",
            Country."Address Format"::"City+County+Post Code",
            Country."Address Format"::"City+Post Code":
                BEGIN
                    AddrArray[ContLineNo] := Contact;
                    GeneratePostCodeCity(AddrArray[PostCodeCityLineNo], AddrArray[CountyLineNo], City, "Post Code", County, Country);
                    AddrArray[CountryLineNo] := Country.Name;
                    COMPRESSARRAY(AddrArray);
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF ContLineNo < PostCodeCityLineNo THEN
                        AddrArray[ContLineNo] := Contact;
                    COMPRESSARRAY(AddrArray);

                    Index := 1;
                    InsertText := 1;
                    REPEAT
                        IF AddrArray[Index] = '' THEN BEGIN
                            CASE InsertText OF
                                2:
                                    GeneratePostCodeCity(AddrArray[Index], AddrArray[Index + 1], City, "Post Code", County, Country);
                                3:
                                    AddrArray[Index] := Country.Name;
                                4:
                                    IF ContLineNo > PostCodeCityLineNo THEN
                                        AddrArray[Index] := Contact;
                            END;
                            InsertText := InsertText + 1;
                        END;
                        Index := Index + 1;
                    UNTIL Index = 9;
                END;
        END;
    end;

    LOCAL PROCEDURE FormatPostCodeCity(VAR PostCodeCityText: Text[90]; VAR CountyText: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; CountryCode: Code[10]);
    var
        GLSetup: Record 98;
        Country: Record 9;
    begin
        CLEAR(PostCodeCityText);
        CLEAR(CountyText);

        IF CountryCode = '' THEN BEGIN
            GLSetup.GET;
            CLEAR(Country);
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET(CountryCode);

        GeneratePostCodeCity(PostCodeCityText, CountyText, City, PostCode, County, Country);
    end;

    LOCAL PROCEDURE GeneratePostCodeCity(VAR PostCodeCityText: Text[90]; VAR CountyText: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; Country: Record 9);
    var
        DummyString: Text;
        OverMaxStrLen: Integer;
    begin
        DummyString := '';
        OverMaxStrLen := MAXSTRLEN(PostCodeCityText);
        IF OverMaxStrLen < MAXSTRLEN(DummyString) THEN
            OverMaxStrLen += 1;

        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(PostCode + ' ' + City, OverMaxStrLen)
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
            Country."Address Format"::"City+County+Post Code":
                BEGIN
                    IF (County <> '') AND (PostCode <> '') THEN
                        PostCodeCityText :=
                          DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - STRLEN(County) - 3) +
                          ', ' + County + '  ' + PostCode
                    ELSE
                        IF PostCode = '' THEN BEGIN
                            PostCodeCityText := City;
                            CountyText := County;
                        END ELSE
                            IF (County = '') AND (PostCode <> '') THEN
                                PostCodeCityText := DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - 1) + ', ' + PostCode;
                END;
            Country."Address Format"::"City+Post Code":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - 1) + ', ' + PostCode
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(PostCode + ' ' + City, OverMaxStrLen)
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
        END;
    end;
}

