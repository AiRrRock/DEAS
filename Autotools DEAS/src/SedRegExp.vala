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
* Static class for generation SED specific regular expressions
*
* == Short Description ==
*
* Used to generate SED specific regular expressions,
* <<BR>>escape SED specific special characters
*
*/
public class SedRegExp: RegExp, Object {
/**
* Generate regular expression to change decimal delimiter
*
* == Short Description ==
*
* Generate regular expression to change decimal delimiter to dot(.) or comma(,)
*
* @param changeTo ''string'', containing either dot(.) or comma(,)
* @return ''string'' containing regular expression to change delimiter to dot(.) or comma(,)
*/
   public static string replaceDecimalDelimiter(string changeTo){
      if (changeTo == "."){
         return changeToDot();
      } else {
         return changeToComma();
      }
   }
/**
* Generate regular expression to replace words, simbols in text 
*
* == Short Description ==
*
* Generate regular expression to replace words or simbols in text
*
* @param change ''string'', containing word or simbol to replace
* @param changeTo ''string'', containing word or simbol to replace with, <<BR>> or empty ''string''
* @return ''string'' containing regular expression to replace word, simbol with new word, simbol
*/
   public static string replaceWords(string change, string changeTo){
      string result = "\'s/";
      result += escapeString(change) +"/";
      result += escapeString(changeTo)   +"/g\'";
      return result;       
   }
/**
* Generate regular expression to reformat date 
*
* == Short Description ==
*
* Generate regular expression to change date format
*
* @param sourceDF ''string'', first part of source date 
* @param sourceDS ''string'', second part of source date 
* @param sourceDT ''string'', third part of source date 
* @param sourceSep ''string'', source date separator
* @param resultDF ''string'', first part of result date 
* @param resultDS ''string'', second part of result date 
* @param resultDT ''string'', third part of result date 
* @param resultSep ''string'', result date separator
* @param prefix ''string'', additional prefix to add if changing from short year(YY) to long year(YYYY) formats
* @return ''string'' containing regular expression to change date format
*/
   public static string reformatDate(string sourceDF,string sourceDS, string sourceDT, string sourceSep, string resultDF,string resultDS,string resultDT,string resultSep, string prefix=""){
      string result = "-E \'s/";
      result += genDateSearch(sourceDF,sourceDS,sourceDT,sourceSep)+"/";
      result += genDateChange(sourceDF,sourceDS,sourceDT,resultDF, resultDS, resultDT,resultSep,prefix);
      result += "/g\'";
      return result;          
   }
/**
* Auxiliary method of {@link SedRegExp.reformatDate}, used to generate search part of regular expression to reformat date 
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.reformatDate}, used to generate search part of regular expression to reformat date 
*
* @param firstDPart ''string'', first part of date 
* @param secondDPart ''string'', second part of date 
* @param thirdDPart ''string'', third part of  date 
* @param separator ''string'', date separator
* @return ''string'' containing search part of regular expression to change date format
*/
   private static string genDateSearch(string firstDPart, string secondDPart, string thirdDPart, string separator){
      string escapedSep = escapeString(separator);
      string result="";
      result +=genDateSearchPart(firstDPart)+escapedSep;
      result +=genDateSearchPart(secondDPart)+escapedSep;
      result +=genDateSearchPart(thirdDPart);
      return result;
   }
/**
* Auxiliary method of {@link SedRegExp.genDateSearch}  
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateSearch}  
*
* @param part ''string'', date part 
* @return ''string'' containing regular expression to find one part of date
*/
   private static string genDateSearchPart(string part){
      switch(part){
         case "DD"    : return "([0][1-9]|[1-2][0-9]|[3][0-1])"; 
         case "MM"    : return "([0][1-9]|[1][0-2])";
         case "YY"    : return "([^0-9]*)([0-9][0-9])";
         case "YYYY"  : return "([1-2][0-9])([0-9][0-9])";
         default      : return "" ;
      }
   }
/**
* Auxiliary method of {@link SedRegExp.reformatDate}, used to generate replace part of regular expression to reformat date 
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.reformatDate}, used to generate replace part of regular expression to reformat date 
*
* @param sourceDF ''string'', first part of source date 
* @param sourceDS ''string'', second part of source date 
* @param sourceDT ''string'', third part of source date 
* @param resultDF ''string'', first part of result date 
* @param resultDS ''string'', second part of result date 
* @param resultDT ''string'', third part of result date 
* @param dateSep ''string'', result date separator
* @param prefix ''string'', additional prefix to add if changing from short year(YY) to long year(YYYY) formats
* @return ''string'' containing replace part of regular expression to change date format
*/
   private static string genDateChange(string sourceDF,string sourceDS,string sourceDT, string resultDF,string resultDS, string resultDT,string  dateSep, string prefix ){
      string result="";
      int[] order = simpleOrder(genOrder(sourceDF,sourceDS,sourceDT),genOrder(resultDF,resultDS,resultDT));
      int[] resultOrder= genResultOrder(resultDF,resultDS,resultDT);
      string escapedDateSep = escapeString(dateSep);
      int count=0;
      for(int i=0; i<4;i++){
         if (order[i]==0){
            result+="";
         } else if (order[i]==5) {
            result+=prefix;
         } else {
            if ((resultOrder[i]==1)||(resultOrder[i]==2)||(resultOrder[i]==6)||(resultOrder[i]==3)) {
               result+="\\"+order[i].to_string();
               if(count<2){
                  result+=escapedDateSep;
                  count++;
               } else {}
            }
         }
      }
      return result;
   }
/**
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate correct replacement order
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate correct replacement order
*
* @param sourceOrder ''int[]'', source file order 
* @param resultOrder ''int[]'', result file order 
* @return ''int[4]'' containing correct replacement order
*/
   private static int[] simpleOrder(int[] sourceOrder, int[] resultOrder){
      int[] order      = new int[4];
      if (hasLongYear(sourceOrder)){  
         if (hasLongYear(resultOrder)){  
            int[] sourceNewOrder = changeSize(sourceOrder,true);
            int[] resultNewOrder     = changeSize(resultOrder, true);
            for(int i=0; i<4; i++){
               for(int j=0; j<4;j++){
                  if (resultNewOrder[i]==sourceNewOrder[j]) {order[i]=j+1;}
               }
            }           
         } else {
            int[] sourceNewOrder = changeSize(sourceOrder,true);
            int[] resultNewOrder     = changeSize(resultOrder, false);
            for(int i=0; i<4; i++){
               for(int j=0; j<4;j++){
                  if (resultNewOrder[i]==sourceNewOrder[j]) {order[i]=j+1;}
               }
            }
         }
      } else {
         if(hasLongYear(resultOrder)){
            int[] sourceNewOrder = changeSize(sourceOrder,false);
            int[] resultNewOrder     = changeSize(resultOrder, true);
            for(int i=0; i<4; i++){
               for(int j=0; j<4;j++){
                  if (resultNewOrder[i]==sourceNewOrder[j]) {order[i]=j+1;}
               }
            }
            for(int i=0;i<4 ;i++){
               if(order[i]==0){order[i]=5;}
            }          

         } else {
            int[] sourceNewOrder = changeSize(sourceOrder,false);
            int[] resultNewOrder     = changeSize(resultOrder, false);
            for(int i=0; i<4; i++){
               for(int j=0; j<4;j++){
                  if (resultNewOrder[i]==sourceNewOrder[j]) {order[i]=j+1;}
               }
            }           
         }
      }
      return order;      
   }
/**
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate result date order
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate result date order
*
* @param resultDF ''string'', result file first part 
* @param resultDS ''string'', result file second part 
* @param resultDF ''string'', result file third part 
* @return ''int[4]'' containing correct result date order
*/
   private static int[] genResultOrder(string resultDF,string resultDS,string resultDT){
      int[] resultOrder =genOrder(resultDF,resultDS,resultDT);
      int[] result;
      if (hasLongYear(resultOrder)) {
         result= changeSize(resultOrder,true); 
      } else {
         result= changeSize(resultOrder,false); 
      }  
      return result;
   }
/**
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate date order from three strings
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateChange}, used to generate date order from three strings
*
* @param firstDatePart ''string'', first part of date 
* @param secondDatePart ''string'', second part of date 
* @param thirdDatePart ''string'', third part of date 
* @return ''int[3]'' containing correct date order
*/
   private static int[] genOrder(string firstDatePart, string secondDatePart, string thirdDatePart){
      int[] order = new int[3];
      order[0] = genOrderPart(firstDatePart);
      order[1] = genOrderPart(secondDatePart);
      order[2] = genOrderPart(thirdDatePart);
      return order;
   }
/**
* Auxiliary method of {@link SedRegExp.genOrder}, used to generate part of date order
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genOrder}, used to generate part of date order
*
* @param datePart ''string'', part of date 
* @return ''int'' containing correct int representation of date part
*/
   private static int genOrderPart(string datePart){
      switch(datePart){
         case "DD"    : return 1;
         case "MM"    : return 2;
         case "YY"    : return 3;
         case "YYYY"  : return 6;
         default      : return 0;
      }
   }
/**
* Auxiliary method of {@link SedRegExp.genDateChange}, used to turn short int arrays into long int arrays
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateChange}, used to turn short int arrays into long int arrays
* 
* @param shortArray ''string'', first part of date 
* @param hasLongYear ''boolean'', determin whether date has long year format(YYYY) 
* @return ''int[4]'' containing correct date order
*/
   private static int[] changeSize(int[] shortArray, bool hasLongYear){
      int[] longArray = new int[4];
      int j = 0;
      if (hasLongYear){
         for (int i=0; i<4; i++){
            if (shortArray[j]==6){
               longArray[i]=3;
               i++;
               longArray[i]=6;  
            } else {
               longArray[i]=shortArray[j];
            }
            j++;
      }
      } else {
         for (int i=0; i<4; i++){
            if (shortArray[j]==3){
               longArray[i]=0;
               i++;
               longArray[i]=6;  
            } else {
               longArray[i]=shortArray[j];
            }
            j++;
            }
      }

      return longArray;
   }
/**
* Auxiliary method of {@link SedRegExp.genDateChange}, used to determine whether date has long year(YYYY) format 
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.genDateChange}, used to determine whether date has long year(YYYY) format 
*
* @return ''true'' if date has long year format,<<BR>>''false'' if date has short year(YY) format
*/
   private static bool hasLongYear(int[] order){
      foreach(int date in order){
         if (date==6) {return true;}
      }
      return false;
   }
/**
* Escape instrument specific special characters
*
* == Short Description ==
*
* Escape sed specific special characters.<<BR>>
* Such as: $,^,/,*,\,],.,[
*
* @param inputString ''string'' containing unescaped characters
* @return ''string'' with escaped special characters
*
*/
   private static string escapeString (string inputString){
      string str="";
      string[] charArray  = RegExp.toCharArray(inputString); 
      foreach(string ch in charArray) {
         switch(ch){
            case "$" : str+="\\"+ch; break;	
            case "^" : str+="\\"+ch; break;	
            case "/" : str+="\\"+ch; break;	
            case "*" : str+="\\"+ch; break;	
            case "[" : str+="\\"+ch; break;	
            case "\\": str+="\\"+ch; break;	
            case "]": str+="\\"+ch; break;	
            case ".": str+="\\"+ch; break;	
            default:  str+=ch; break;
         }  
      }
      return str;    
   }
/**
* Auxiliary method of {@link SedRegExp.replaceDecimalDelimiter} 
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.replaceDecimalDelimiter} to change delimiter to comma(,) 
*
* @return ''string'' containing regular expression to change decimal delimiter to comma(,)
*/
   private static string changeToComma(){
      return "\'s/\\([[:digit:]]\\)\\.\\([[:digit:]]\\)/\\1,\\2/g\'";
   }
/**
* Auxiliary method of {@link SedRegExp.replaceDecimalDelimiter} 
*
* == Short Description ==
*
* Auxiliary method of {@link SedRegExp.replaceDecimalDelimiter} to change delimiter to dot(.) 
*
* @return ''string'' containing regular expression to change decimal delimiter to dot(.)
*/
   private static string changeToDot(){
      return "\'s/\\([[:digit:]]\\),\\([[:digit:]]\\)/\\1\\.\\2/g\'";
   }
}
