with Food_DataStructures;    use Food_DataStructures;
with Stats_FoodDistribution; use Stats_FoodDistribution;
with GateKeeperService;      use GateKeeperService;

with Ada.Text_IO; use Ada.Text_IO;

package body Food_SalesService is

   package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);
   use Integer_IO;
   task body RetailSales is
      food             : Food_Pack;
      availableForSale : Boolean := True;


   begin
      delay 1.0;  -- Allow for initialization activities.
      loop
         GateKeeper.retrieveMessage (food, availableForSale);

-- The time to sell a product is exponentially distributed with mean 2.0 hours.
         delay (Duration (Next_Exponential * 2.0));

         if getFood_PackFoodType (food) in GrainVegetable then
            grainCounter := grainCounter + 1;
         else
            meatCounter := meatCounter + 1;
         end if;
         Put ("Retail Sales successfuly sold ");
         PrintFood_Pack (food);
         New_Line;
         soldCounter := soldCounter + 1;
         New_Line (2);
         Ada.Text_IO.Put_Line
           ("Total food sold: " & Integer'Image (soldCounter));

      end loop;
   end RetailSales;

end Food_SalesService;
