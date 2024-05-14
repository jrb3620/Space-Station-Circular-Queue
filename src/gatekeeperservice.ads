with Food_DataStructures;  use Food_DataStructures;
With Stats_FoodDistribution;  use Stats_FoodDistribution;

with CircularQue;


package GateKeeperService is

   function CreateAndUseQueue return Natural;
   task GateKeeper is

      -- accept Food_Packs from interplanetary vesssels.
      entry acceptMessage( newFood: in Food_Pack );

      --Allow sales to retrive the repackaged Food_Packs.
      entry retrieveMessage( newFood: out Food_Pack; availableForShipment: out Boolean );

   end GateKeeper;

end GateKeeperService;
