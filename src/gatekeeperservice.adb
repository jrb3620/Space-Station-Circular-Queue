with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Calendar;        use Ada.Calendar;
with Food_DataStructures; use Food_DataStructures;

package body GateKeeperService is
   package IntegerIO is new Ada.Text_IO.Integer_IO (Integer);
   use IntegerIO;
   User_Capacity : Natural;
   rejected : Integer := 0;

   function CreateAndUseQueue return Natural is

    begin
      put("What is the capacity? ");
      get(User_Capacity);
      new_line(2);
      return User_Capacity;
    end CreateAndUseQueue;

   package CircularQueue is new CircularQue (CreateAndUseQueue);
   use CircularQueue;
   
   task body GateKeeper is

      
      -- Declare food packet counters here.

      MgtDesiredFoodTypeToSell : Food_Type;

      Start_Time : Ada.Calendar.Time;
      End_Time   : Ada.Calendar.Time;

   begin
      delay 0.5;  -- allow 1/2 hour to initialize facility.
      Start_Time := Ada.Calendar.Clock;
      End_Time   :=
        Start_Time + 1.0 * 8.0 * 5.0; -- 1.0 sec./hour * 8 hours/days * 5 days

      -- Termiate after lossing 5 customers or time to close has arrived.
      while rejected < 5 and Ada.Calendar.Clock < End_Time
      loop  -- Termiate after lossing 5 customers

      -- In Ada, a "select" statement with multiple "or" options must uniformly
      -- process (randomly) the "accept" statements.  This prevents any single
      -- "accept" from starving the others from service.
         --
         -- Rules for "Select":
         -- 1) If no task are waiting for service, the task sleeps.
         -- 2) If only one of the "accept" entries has a task waiting that task is served.
         -- 3) If sleeping and a task or tasks arrive simultaneously, awake a service the
         --    the first arrival.
   -- 4) If multiple "accepts" have task waiting, service them in random order
         --    to prevent starvation.
         --

         select
            -- new arrivals of food
            accept acceptMessage (newFood : in Food_Pack) do
               if not (CircularQueue.circularQueFull) then
                  CircularQueue.acceptMessage (newFood);
                  Put ("GateKeeper insert accepted ");
                  PrintFood_Pack (newFood);
                  New_Line;
               else
                  rejected := rejected + 1;
                  Put (" Rejected by GateKeeper: ");
                  New_Line;
                  PrintFood_Pack (newFood);
                  New_Line;
                  Put (" Rejected = ");
                  Put (rejected);
                  Put (". Sent to another distribution facility!");
                  New_Line (3);
               end if;
            end acceptMessage;
         or
            -- Accept request for distribution from sales
            accept retrieveMessage
              (newFood : out Food_Pack; availableForShipment : out Boolean)
            do
               availableForShipment := False;

               if not (CircularQueue.circularQueEmpty) then
                  availableForShipment := True;

                  CircularQueue.retrieveMessage (newFood);

                  MgtDesiredFoodTypeToSell := RandomFoodType;
                  Put ("Mgt Desired Food Type To Sell is: ");
                  PrintFoodType (MgtDesiredFoodTypeToSell);
                  Put ("Actual type sold is: ");
                  PrintFood_PackType (newFood);
                  New_Line;
                  --PrintFood_PackShipment( newFood );
                  Put ("Food pack removed by GateKeeper for shipment.");
                  New_Line (2);
               end if;
            end retrieveMessage;
         end select;

         delay 1.1; -- Complete overhead due to accepting or rejecting a request prior to new iteration.
      end loop;

      -- print time in service, statistics such as number food pacekets of meat and non-meat products processed.
      Put ("Circular queue contents: ");
      New_Line (2);
      CircularQueue.Circular_Queue_Report;
      New_Line (2);
      Put ("Hours of operation prior to closing: ");
      Ada.Text_IO.Put_Line (Duration'Image (Ada.Calendar.Clock - Start_Time));
      New_Line (2);

   end GateKeeper;
end GateKeeperService;
