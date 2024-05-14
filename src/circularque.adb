package body CircularQue is

   package IntIO is new Ada.Text_IO.Integer_IO (Integer);
   use IntIO;

   subtype slotindex is Natural range 0 .. (capacity - 1);  -- Natural implies >= 0
   front, rear  : slotindex := 0;  -- insert at front, remove from rear.
   box          : array (slotindex) of Food_Pack; -- circular buffer
   mesnum       : Natural   := 0; --counter
   max_messages : Natural   := capacity - 1; --wrap around max

   procedure acceptMessage (msg : in Food_Pack) is
   begin
      -- Increment rear correctly, considering wrap-around.
      if rear = max_messages then
         rear := 0; -- Wrap around to the beginning of the queue.
      else
         rear := rear + 1;
      end if;
      if mesnum = max_messages then --check for full
         Put ("ERROR - Message rejected - queue is full!");
         New_Line (2);
         if rear = 0 then
            rear := max_messages; --move pointer back
         else
            rear := rear - 1;
         end if;
      else
         -- Increment rear correctly, considering wrap-around.
         -- Insert the message into the queue.
         box (rear) := msg;
      end if;
      mesnum := mesnum + 1;

      Ada.Text_IO.Put_Line ("Front: " & Integer'Image (front));
      Ada.Text_IO.Put_Line ("Rear: " & Integer'Image (rear));

   end acceptMessage;

   procedure retrieveMessage (msg : out Food_Pack)
   is  -- ** modify in dual stacks to return highest priority food
   begin
      if mesnum = 0 then
         Put ("ERROR - No message in the queue to retrieve!");
         New_Line (2);
      else
         if front = max_messages then
            front := 0;
         else
            front := front + 1;
         end if;
         msg    := box (front);
         mesnum := mesnum - 1;

      end if;

      Ada.Text_IO.Put_Line ("Front: " & Integer'Image (front));
      Ada.Text_IO.Put_Line ("Rear: " & Integer'Image (rear));
   end retrieveMessage;

   procedure Circular_Queue_Report is
   begin
      Ada.Text_IO.Put_Line ("Front: " & Integer'Image (front));
      New_Line (1);
      Ada.Text_IO.Put_Line ("Rear: " & Integer'Image (rear));
      New_Line (1);
      Ada.Text_IO.Put_Line ("Total Meat Sold: " & Integer'Image (meatCounter));
      New_Line (1);
      Ada.Text_IO.Put_Line ("Total Non-Meat Sold: " & Integer'Image (grainCounter));
      New_Line (1);
      Ada.Text_IO.Put_Line ("Total Food Sold: " & Integer'Image (soldCounter));
      New_Line (1);
      Ada.Text_IO.Put_Line ("Queue Contents: ");
      -- print out the array
      if front > rear then
         -- Print from front to the end of the array
         for i in front .. capacity loop
            declare
               FoodInArray : Food_Type := getFood_PackFoodType (box (i));
            begin
               Ada.Text_IO.Put_Line ("Food: " & FoodInArray'Image);
            end;
         end loop;
         -- Wrap around and print from the start of the array to rear
         for i in 1 .. rear loop
            declare
               FoodInArray : Food_Type := getFood_PackFoodType (box (i));
            begin
               Ada.Text_IO.Put_Line ("Food: " & FoodInArray'Image);
            end;
         end loop;
      else
         -- Front is behind or equal to rear, normal iteration
         for i in front .. rear loop
            declare
               FoodInArray : Food_Type := getFood_PackFoodType (box (i));
            begin
               Ada.Text_IO.Put_Line ("Food: " & FoodInArray'Image);
            end;
         end loop;
      end if;
   end Circular_Queue_Report;

   function CircularQueEmpty return Boolean is
   begin
      if mesnum > 0 then
         return False;
      else
         return True;
      end if;
   end CircularQueEmpty;

   function CircularQueFull return Boolean is  -- ** modify for dual stacks
   begin
      if mesnum = max_messages then
         return True;
      else
         return False;
      end if;
   end CircularQueFull;

end CircularQue;
