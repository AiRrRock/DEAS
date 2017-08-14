/**
	DEAS (Data Edeting ASsistant - a free GUI software to simpify use of sed,grep awk commands for data modifications 
	Copyright (C) 2016-2017  Alexander Borichev
  
    This file is a part of DEAS
  
	DEAS is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    Foobar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
/**
* Static class used for date representation
*
* == Short Description ==
*
* Used to generate visible date representation for GUI
* <<BR>>checks if the date has long year(YYYY) format
*
*/
public class Date{
   //Constant fields
   private const string DATE = "23";
   private const string MONTH = "11";
   private const string MONTH_LIT = "November";
   private const string YEAR_YY = "89";
   private const string YEAR_YYYY = "1989";
   private const string DEFAULT_SEP = "/";
/**
* Generate visual representation of date format
*
* == Short Description ==
*
* Generate visual representation of date format
*
* @param firstDPart ''string'' first part of date
* @param secondDPart ''string'' second part of date
* @param thirdDPart ''string'' third part of date
* @param separator ''string'' date separator
* @return ''string'' containing visual representation of the date format
* 
*/
   public static string generateVisibleDate(string firstDPart, string secondDPart, string thirdDPart, string separator){
      string output="   ";
      output += getVisiblePart(firstDPart) + separator;
      output += getVisiblePart(secondDPart) + separator;
      output += getVisiblePart(thirdDPart);
      return output;
   }   
/**
* Check if the date has long year(YYYY) format
*
* ==  Short Description ==
*
* Check if the date has long year(YYYY) format
*
* @param someDPart ''string'' part of date
* @return ''true'' if the date part is YYYY,<<BR>>''false'' if the date part is not YYYY
*
*/
   public static bool hasLongYear(string someDPart){
      switch(someDPart){
         case "YYYY"   : return true;
         default       : return false; 
      }
   }
/**
* Auxiliary method of {@link Date.generateVisibleDate}
*
* == Short Description ==
*
* Auxiliary method of {@link Date.generateVisibleDate} to generate a part of visual representation of date format
*
* @param someDPart ''string'' part of date
* @return ''string'' visual representation of date part
*
*/
   private static string getVisiblePart(string someDPart){
      switch(someDPart){
         case "YYYY"   : return YEAR_YYYY;
         case "YY"     : return YEAR_YY;
         case "MM"     : return MONTH;
         case "DD"     : return DATE;
         default       : return ""; 
      }
   }
}

