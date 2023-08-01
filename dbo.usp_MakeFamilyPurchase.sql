-- dbo.usp_MakeFamilyPurchase
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    DECLARE @FamilyID INT;

    -- ��������� ������� ����� � ���������� SurName
    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName;

    IF @FamilyID IS NULL
    BEGIN
        RAISERROR('����� � SurName "%s" �� ����������.', 16, 1, @FamilySurName);
        RETURN; -- ������� �� ��������� � ������ ��������������� SurName
    END

    -- ��������� ������ � ���� BudgetValue �� ������: dbo.Family.BudgetValue - SUM(dbo.Basket.Value)
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
END;
