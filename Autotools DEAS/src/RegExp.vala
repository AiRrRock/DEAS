using Gtk;
/**
	DEAS (Data Edeting ASsistant - a free GUI software to simpify use of sed,grep awk commands for data modifications 
	Copyright (C) 2016-2017  Alexander Borichev
  
    This file is a part of DEAS
  
	DEAS is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    DEAS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DEAS.  If not, see <http://www.gnu.org/licenses/>.
*/
/**
* Regular expression interface   
*
* == Short Description ==
*
* Interface containing mandatory methods for managing regular expressions,
* <<BR>> also containing several auxiliary methods 
*/
public interface RegExp: Object {
/**
* Escape instrument specific special characters
*
* == Short Description ==
*
* Escape instrument specfic special characters
*
* @param inputString ''string'' of unescaped characters
* @return ''string'' with all special characters escaped
*/
   public static string escapeString (string inputString){
      string str="";
      string[] charArray  = toCharArray(inputString); 
      foreach(string ch in charArray) {
         str+=ch;
      }  
      return str;    
  }
/**
* Escape spaces in string 
*
* == Short Description ==
*
* Escape spaces in string, useful for windows
*
* @param unescapedString input ''string''
* @return ''string'', in which each space is escaped 
*/
   public static string escapeSpaces(string unescapedString){
      string[] charArray = toCharArray(unescapedString);
      string escapedString = "";
      foreach (string character in charArray){
         switch(character){
            case " ": escapedString += "\\" + character; break;
            default : escapedString += character; break;
         }   
      }
      return escapedString;   
   }
/**
* Turn string to characterArrray
*
* == Short Description ==
*
* Turns input string into string array, where each element contains one character
*
* @param inputString input ''string''
* @return ''string[]'', in which each element is a string containing one char 
*/
   public static string[] toCharArray(string inputString){
      string[] charArray = new string[inputString.length];
      for (int i = 0; i < inputString.length; i++){
           charArray[i] = inputString.substring(i,1);
      }
      return charArray;
   }
}
