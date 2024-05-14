--in file CircularQue
--
--The GateKeeper requires a circular queue for storage and retrieval.  The package has been
--made a generic to allow use in future systems with respect to the data type and queue size.
--
-- The software suite consists of ProductDistributionMain, 
-- Food_DataStructures, Stats_FoodDistribution, GateKeeperService,
-- Distribution_Service, CircularQue and Food_SalesService.
--
-- With the exception of ProductDistributionMain this suite represents the software
-- to manage an "embedded" planetary system food receiving and distribution system.
-- The Distribution_Service module will be discarded once the embedded software required to 
-- manage the physical system is complete and installed.
--
--** This implementation of the circular queue sacrifices run-time allowing complete utilization of all queue space.
-- Message should not be sent without verifying the queue has avaliable storage space!!!!

with Ada.text_IO; use Ada.Text_IO;

generic
    type message is private;
    capacity: in Natural := 24;  -- Default queue size

 package CircularQue is

   procedure acceptMessage(msg: in message);

   procedure retrieveMessage(msg: out message);

   function circularQueEmpty return Boolean;

   function circularQueFull return Boolean;

 end CircularQue;
