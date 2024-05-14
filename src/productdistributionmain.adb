with Ada.Text_IO; use Ada.Text_IO;

with Food_DataStructures; use Food_DataStructures;

with Stats_FoodDistribution; use Stats_FoodDistribution;

with Distribution_Service; use Distribution_Service;

with Food_SalesService; use Food_SalesService;

procedure ProductDistributionMain is

   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);
   use Int_IO;
   --  procedure Initalize_Gatekeeper(Capacity: Positive);
   numProductGenerators : Positive := 1; -- number product generators.
   numPOS : Positive := 2;               -- number points of sale.

   --SalesPerson: RetailSales; -- single sales center.
   --User_Capacity : Natural;

begin --body ProductDistributionMain
 --  Put ("What is the capacity? ");
 --  Get(User_Capacity);
 --  New_Line (2);
   --GateKeeperService.Set_Capacity(User_Capacity);
   Put ("How many Product Generators?  ");
   Get (numProductGenerators);  -- number receiving stations.
   New_Line;
   Put ("How many points of sale?  ");
   Get (numPOS);  -- number receiving stations.
   New_Line (2);


   declare
      FarmProducts : array (1 .. numProductGenerators) of Product_Generator;
      POS          : array (1 .. numPOS) of RetailSales;

   begin
      null;
   end;

end ProductDistributionMain;
