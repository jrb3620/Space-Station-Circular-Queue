with Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use  Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

with Food_DataStructures; use Food_DataStructures;

package Stats_FoodDistribution is
--
-- Use 1.0 seconds of real time to simulate passage of 1 hour simulated time.
--
   my_Generator: Generator;

-- Exponential distribution using interpolation and famous data points from early IBM
-- Fortran statistical packages.
   function Next_Exponential return float;

-- Time requried to arrange raw food packets for sale.
   function PrepareGrainVegetableFood_PackforSales return duration;

   function PrepareMeatFood_PackforSales return duration;

 end Stats_FoodDistribution;
