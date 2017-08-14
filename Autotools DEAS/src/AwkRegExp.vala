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
* Static class for generation AWK specific regular expressions 
*
* == Short Description ==
*
* Used to generate AWK specific regular expressions,
* <<BR>>escape AWK specific special characters 
*
*/
public class AwkRegExp: RegExp,Object {
/**
* Generate awk specific command to change column order
*
* == Short Description ==
*
* Generates awk specific command to change column order,<<BR>> add extra column
*
* @param order comma separated ''string'' of int values, representing ne column order
* @param separator ''string''  - new column separartor
* @param extraColumn ''string'' - new column to add
* @return ''string'' command for awk instrument
*/
   public static string changeColumnOrder(string order, string separator, string extraColumn){
      string escapedSeparator="\\\"";
      if (separator ==""){
         escapedSeparator += " \\\"";
      } else {
         escapedSeparator += escapeString(separator)+"\\\"";
      }
      string result =" -v RS=\'\\r?\\n?\\r?\' -v e=\'"+extraColumn+"\' \'{ORS=\\\"\\\"; print ";
      result += prepareOrderString(order, escapedSeparator) + " \\\"\\n\\\"}\'"; 
      return result;
   }
/**
* Generate awk specific command to change end of line
*
* == Short Description ==
*
* Generates awk specific command to change end of line character to CR, LF, CRLF, LFCR
*
* @param endOfLine ''string'' containing either CR, or LF, or CRLF, or LFCR
* @return ''string'' command for awk instrument
*
*/
   public static string changeEOL(string endOfLine){
      string result="";
      string escapedEOL = chooseEOL(endOfLine);
      result+= "-v RS=\'\\r?\\n?\\r?\' \'{ORS=\\\"\\\"; print \\$0 \\\"" + escapedEOL + "\\\"}\'";
      return result;
   }
/**
* Generate correct end of line character 
*
* == Short Description ==
*
* Generate correct end of line character in accordance with endOfLine
*
* @param endOfLine ''string'' containing either CR, or LF, or CRLF, or LFCR
* @return ''string'' containing correct EOL character
*/
   private static string chooseEOL(string endOfLine){
      string escapedEOL="";
      switch (endOfLine){
         case "LF"   : escapedEOL = "\\n"; break;
         case "CR"   : escapedEOL = "\\r"; break;
         case "CRLF" : escapedEOL = "\\r\\n"; break;
         case "LFCR" : escapedEOL = "\\n\\r"; break;
      }
      return escapedEOL;
   }
/**
* Escape instrument specific special characters
*
* == Short Description ==
*
* Escape awk specific special characters.<<BR>>
* Such as: \,",+,-,/,*.
*
* @param inputString ''string'' containing unescaped characters 
* @return ''string'' with escaped special characters 
*/
   private static string escapeString (string inputString){
      string str="";
      string[] charArray = RegExp.toCharArray(inputString);
      foreach(string ch in charArray) {
         switch(ch){
            case "\\": str+="\\"+ch; break;	
            case "\"": str+="\\"+ch; break;	
            case "+" : str+="\\"+ch; break;
            case "-" : str+="\\"+ch; break;
            case "/" : str+="\\"+ch; break;
            case "*" : str+="\\"+ch; break;
            default:  str+=ch; break;
         }  
      }
      return str;    
   }
/**
* Method to prepare the column order string 
*
* == Short Description ==
*
* Prepare column order string, adding special symbols 
*
* @param inputString comma separated ''string'', containing new column order
* @param separator ''string'', containing new separator 
* @return ''string'' with new column order and separator for awk 
*/
   private static string prepareOrderString (string inputString, string separator){
      string[] stringArray=inputString.split(",");
      string[] charArray;
      string innerString;
      string result="";
      for (int i=0;i<stringArray.length;i++){
         charArray = RegExp.toCharArray(stringArray[i]);
         innerString ="\\$";
         foreach (string innerStr in charArray){
            switch(innerStr){
               case "e" : innerString =innerStr; break;
               case "1" :
               case "2" :
               case "3" :
               case "4" :
               case "5" :
               case "6" :
               case "7" :
               case "8" :
               case "9" :
               case "0" : innerString+=innerStr; break;
               default  : innerString+="";break; 
            }
         }
         if (innerString=="\\$") {innerString = "";}
         if (i<stringArray.length-1){
            result +=innerString +  separator ; 
         } else {
            result +=innerString;
         }
      }
      return result;
   } 
}
