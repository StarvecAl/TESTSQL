CREATE FUNCTION dbo.udf_GetSKUPrice (@ID_SKU INT)
RETURNS DECIMAL(18,2)
AS	
BEGIN
	DECLARE @TotalValue DECIMAL(18,2);
	DECLARE @TotalQu INT;
	SELECT @TotalValue = SUM(Value), @TotalQu = SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    IF (@TotalQu > 0)
        RETURN @TotalValue / @TotalQu;
    ELSE
        RETURN 0.00; -- Чтобы избежать деления на ноль
END;