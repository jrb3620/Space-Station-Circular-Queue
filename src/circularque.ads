with Ada.text_IO; use Ada.Text_IO;
with Food_DataStructures;  use Food_DataStructures;
with food_salesservice; use food_salesservice;

generic
   capacity: in Positive;
    -- Add generic parameter to determine the size of the storage space.

 package CircularQue is
   procedure acceptMessage(msg: in Food_Pack);

   procedure retrieveMessage(msg: out Food_Pack);

   procedure Circular_Queue_Report;

   function circularQueEmpty return Boolean;

   function circularQueFull return Boolean;

 end CircularQue;

