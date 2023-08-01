-- dbo.usp_MakeFamilyPurchase
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    DECLARE @FamilyID INT;

    -- Проверяем наличие семьи с переданным SurName
    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName;

    IF @FamilyID IS NULL
    BEGIN
        RAISERROR('Семьи с SurName "%s" не существует.', 16, 1, @FamilySurName);
        RETURN; -- Выходим из процедуры в случае несуществующего SurName
    END

    -- Обновляем данные в поле BudgetValue по логике: dbo.Family.BudgetValue - SUM(dbo.Basket.Value)
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
    WHERE ID = @FamilyID;
END;
