page 50100 "Create New Price"
{
    Caption = 'Create New Price';
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(PriceListCodeSale; PriceListCode)
            {
                Caption = 'Price List Code';
                TableRelation = "Price List Header" where("Price Type" = const(Sale));
                Visible = PriceType = PriceType::Sale;
            }
            field(CustomerNo; CustomerNo)
            {
                Caption = 'Customer No.';
                TableRelation = Customer."No.";
                Visible = PriceType = PriceType::Sale;
            }
            field(PriceListCodePurchase; PriceListCode)
            {
                Caption = 'Price List Code';
                TableRelation = "Price List Header" where("Price Type" = const(Purchase));
                Visible = PriceType = PriceType::Purchase;
            }
            field(VendorNo; VendorNo)
            {
                Caption = 'Vendor No.';
                TableRelation = Vendor."No.";
                Visible = PriceType = PriceType::Purchase;
            }
            field(CurrencyCode; CurrencyCode)
            {
                Caption = 'Currency Code';
                TableRelation = Currency.Code;
            }
            field(UnitPrice; UnitPrice)
            {
                Caption = 'Unit Price';
                Visible = PriceType = PriceType::Sale;
            }
            field(DirectUnitCost; DirectUnitCost)
            {
                Caption = 'Direct Unit Cost';
                Visible = PriceType = PriceType::Purchase;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if PriceType = PriceType::Sale then
            SourceGroup := SourceGroup::Customer
        else
            SourceGroup := SourceGroup::Vendor;
        PriceListCode := PriceListManagement.GetDefaultPriceListCode(PriceType, SourceGroup, true);
    end;

    var
        PriceListManagement: Codeunit "Price List Management";
        PriceListCode: Code[20];
        CustomerNo: Code[20];
        VendorNo: Code[20];
        CurrencyCode: Code[10];
        UnitPrice: Decimal;
        DirectUnitCost: Decimal;
        PriceType: Enum "Price Type";
        SourceGroup: Enum "Price Source Group";

    procedure SetPriceType(NewPriceType: Enum "Price Type")
    begin
        PriceType := NewPriceType;
    end;

    procedure GetPriceListCode(): Code[20];
    begin
        exit(PriceListCode);
    end;

    procedure GetSourceNo(): Code[20];
    begin
        if PriceType = PriceType::Sale then
            exit(CustomerNo)
        else
            exit(VendorNo);
    end;

    procedure GetCurrencyCode(): Code[10];
    begin
        exit(CurrencyCode);
    end;

    procedure GetUnitPrice(): Decimal;
    begin
        exit(UnitPrice);
    end;

    procedure GetDirectUnitCost(): Decimal;
    begin
        exit(DirectUnitCost);
    end;
}
