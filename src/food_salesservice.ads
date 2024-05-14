with Food_DataStructures;  --use Food_DataStructures;
with Stats_FoodDistribution;  use Stats_FoodDistribution;

package Food_SalesService is
      soldCounter : Integer := 0;
grainCounter : Integer := 0;
      meatCounter : Integer := 0;
   task type RetailSales;
   --task RetailSales;  -- May be used if only a single point of sales is required.
end Food_SalesService;
