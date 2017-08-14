using Gtk;
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
* Static class for saving and loading of {@link GLib.KeyFile}
*
* == Short Description ==
*
* Static class useed to save/load {@link GLib.KeyFile} and
* and serialize/deserialize {@link DEAS} instance 
**/
public class Preset{
/**
* Static method to serialize {@link DEAS} instanse into file
*
* == Short Desciption ==
*
* Static method to serialize state of {@link DEAS} instanse into {@link GLib.KeyFile}
*
* @param fileToWriteToPath path to {@link GLib.KeyFile}
* @param softwareVersion current version of software
* @param columnOrderCB {@link Gtk.CheckButton} used to determine whether to change or not to change Colum Order
* @param colOrderOldSep {@link Gtk.Entry} old column separator
* @param colOrderOrder  {@link Gtk.Entry} comma separated column order
* @param colOrderNewSep {@link Gtk.Entry} new column separator
* @param columnEditorExtraCol {@link Gtk.Entry} extra column
* @param decimalDelimiterCB {@link Gtk.CheckButton} used to determinr whether to change or not to change Decimal Delimiter
* @param decDelTo {@link Gtk.ComboBoxText} new decimal delimiter
* @param wordEditorCB {@link Gtk.CheckButton} used to determine whether to change or not to change words
* @param wordToChange {@link Gtk.Entry} word to replace
* @param wordToChangeTo {@link Gtk.Entry} word to replace to
* @param dateFormatterCB {@link Gtk.CheckButton} used to determinr whether to change or not to change date format
* @param sourceDFCB      {@link Gtk.ComboBoxText} first part of source date
* @param sourceDSCB      {@link Gtk.ComboBoxText} second part of source date
* @param sourceDTCB      {@link Gtk.ComboBoxText} third part of source date
* @param sourceDSepEntry {@link Gtk.Entry} source date separator
* @param resultDFCB      {@link Gtk.ComboBoxText} first part of result date
* @param resultDSCB      {@link Gtk.ComboBoxText} second part of result date
* @param resultDTCB      {@link Gtk.ComboBoxText} third part of result date
* @param resultDSepEntry {@link Gtk.Entry} result date separator
* @param endOfLineCB {@link Gtk.CheckButton} used to determinr whether to change or not to change end of line
* @param endOfLineToCB {@link Gtk.ComboBoxText} end of line to change to 
* @param encodingCB {@link Gtk.CheckButton} used to determinr whether to change or not to change file encoding
* @param encodingChangeFromEntry {@link Gtk.Entry} encoding to change from
* @param encodingChangeToEntry {@link Gtk.Entry} encoding to change from
* @return ''true'' if {@link GLib.KeyFile} was saved sucessfully<<BR>>''false'' if {@link GLib.KeyFile} was not seved
*/

   public static bool  savePreset(string fileToWriteToPath,string softwareVersion, CheckButton columnOrderCB, Entry colOrderOldSep, Entry colOrderOrder, Entry colOrderNewSep,Entry columnEditorExtraCol, CheckButton decimalDelimiterCB, ComboBoxText decDelTo, CheckButton wordEditorCB, Entry wordToChange, Entry wordToChangeTo,CheckButton dateFormatterCB, ComboBoxText sourceDFCB,ComboBoxText sourceDSCB,ComboBoxText sourceDTCB, Entry sourceDSepEntry,ComboBoxText  resultDFCB,ComboBoxText resultDSCB,ComboBoxText resultDTCB, Entry resultDSepEntry ,CheckButton endOfLineCB, ComboBoxText endOfLineToCB,CheckButton encodingCB, Entry encodingChangeFromEntry, Entry encodingChangeToEntry ){
      KeyFile keyFile = new KeyFile();
      keyFile.set_string("Software","Software Version",softwareVersion); 
      keyFile.set_boolean("Column Editor","Use Column Editor",columnOrderCB.active);
      keyFile.set_string("Column Editor","Old Separator",colOrderOldSep.get_text());
      keyFile.set_string("Column Editor","New Separator",colOrderNewSep.get_text());
      keyFile.set_string("Column Editor","Column Order",colOrderOrder.get_text());
      keyFile.set_string("Column Editor","Extra Column",columnEditorExtraCol.get_text());
      keyFile.set_boolean("Decimal Delimiter","Use Decimal Delimiter",decimalDelimiterCB.active);
      keyFile.set_integer("Decimal Delimiter", "Change Simbol to",decDelTo.active); 
      keyFile.set_boolean("Word Editor","Use Wold Editor",wordEditorCB.active);
      keyFile.set_string("Word Editor","Word to Change",wordToChange.get_text());
      keyFile.set_string("Word Editor","Word to Change To",wordToChangeTo.get_text());
      keyFile.set_boolean("Date Formatter","Use Date Formatter",dateFormatterCB.active);
      keyFile.set_integer("Date Formatter","Source Date First",sourceDFCB.active); 
      keyFile.set_integer("Date Formatter","Source Date Second",sourceDSCB.active); 
      keyFile.set_integer("Date Formatter","Source Date Third",sourceDTCB.active); 
      keyFile.set_string("Date Formatter","Source Date Separator", sourceDSepEntry.get_text());
      keyFile.set_integer("Date Formatter","Result Date First",resultDFCB.active); 
      keyFile.set_integer("Date Formatter","Result Date Second",resultDSCB.active); 
      keyFile.set_integer("Date Formatter","Result Date Third",resultDTCB.active); 
      keyFile.set_string("Date Formatter","Result Date Separator", resultDSepEntry.get_text());
      keyFile.set_boolean("End of Line","Use End of Line", endOfLineCB.active);
      keyFile.set_integer("End of Line","Change End of Line To", endOfLineToCB.active); 
      keyFile.set_boolean("Encoding","Use Encoding", encodingCB.active);
      keyFile.set_string("Encoding","Change Encoding From",encodingChangeFromEntry.get_text());
      keyFile.set_string("Encoding","Change Encoding To",encodingChangeToEntry.get_text());
      try {
         keyFile.save_to_file(fileToWriteToPath);
         return true;
      } catch{
         return false;
      }

   }

/**
* Static method to deserialize {@link DEAS} instanse into file
*
* == Short Desciption ==
* 
* Static method to deserialize state of {@link DEAS} instanse from {@link GLib.KeyFile}
*
* @param fileToReadPath path to {@link GLib.KeyFile}
* @param softwareVersion current version of software
* @param columnOrderCB {@link Gtk.CheckButton} used to determine whether to change or not to change Colum Order
* @param colOrderOldSep {@link Gtk.Entry} old column separator
* @param colOrderOrder  {@link Gtk.Entry} comma separated column order
* @param colOrderNewSep {@link Gtk.Entry} new column separator
* @param columnEditorExtraCol {@link Gtk.Entry} extra column
* @param decimalDelimiterCB {@link Gtk.CheckButton} used to determinr whether to change or not to change Decimal Delimiter
* @param decDelTo {@link Gtk.ComboBoxText} new decimal delimiter
* @param wordEditorCB {@link Gtk.CheckButton} used to determine whether to change or not to change words
* @param wordToChange {@link Gtk.Entry} word to replace
* @param wordToChangeTo {@link Gtk.Entry} word to replace to
* @param dateFormatterCB {@link Gtk.CheckButton} used to determinr whether to change or not to change date format
* @param sourceDFCB      {@link Gtk.ComboBoxText} first part of source date
* @param sourceDSCB      {@link Gtk.ComboBoxText} second part of source date
* @param sourceDTCB      {@link Gtk.ComboBoxText} third part of source date
* @param sourceDSepEntry {@link Gtk.Entry} source date separator
* @param resultDFCB      {@link Gtk.ComboBoxText} first part of result date
* @param resultDSCB      {@link Gtk.ComboBoxText} second part of result date
* @param resultDTCB      {@link Gtk.ComboBoxText} third part of result date
* @param resultDSepEntry {@link Gtk.Entry} result date separator
* @param endOfLineCB {@link Gtk.CheckButton} used to determinr whether to change or not to change end of line
* @param endOfLineToCB {@link Gtk.ComboBoxText} end of line to change to 
* @param encodingCB {@link Gtk.CheckButton} used to determinr whether to change or not to change file encoding
* @param encodingChangeFromEntry {@link Gtk.Entry} encoding to change from
* @param encodingChangeToEntry {@link Gtk.Entry} encoding to change from
* @return ''true'' if {@link GLib.KeyFile} was loaded and the fields where set sucessfully<<BR>>''false'' if {@link GLib.KeyFile} was not loaded or field were not set
*/
   public static bool loadPreset(string fileToReadPath, string softwareVersion, CheckButton columnOrderCB, Entry colOrderOldSep, Entry colOrderOrder, Entry colOrderNewSep,Entry columnEditorExtraCol, CheckButton decimalDelimiterCB, ComboBoxText decDelTo, CheckButton wordEditorCB, Entry wordToChange, Entry wordToChangeTo,CheckButton dateFormatterCB, ComboBoxText sourceDFCB,ComboBoxText sourceDSCB,ComboBoxText sourceDTCB, Entry sourceDSepEntry,ComboBoxText  resultDFCB,ComboBoxText resultDSCB,ComboBoxText resultDTCB, Entry resultDSepEntry ,CheckButton endOfLineCB, ComboBoxText endOfLineToCB,CheckButton encodingCB, Entry encodingChangeFromEntry, Entry encodingChangeToEntry ){
      string softwareVersionFile="";
      KeyFile keyFile = new KeyFile();
      try{
         keyFile.load_from_file(fileToReadPath,KeyFileFlags.NONE);
         softwareVersionFile     = keyFile.get_string("Software","Software Version"); 
         columnOrderCB.set_active(keyFile.get_boolean("Column Editor","Use Column Editor"));
         colOrderOldSep.set_text(keyFile.get_string("Column Editor","Old Separator"));
         colOrderNewSep.set_text(keyFile.get_string("Column Editor","New Separator"));
         colOrderOrder.set_text(keyFile.get_string("Column Editor","Column Order"));
         columnEditorExtraCol.set_text(keyFile.get_string("Column Editor","Extra Column"));
         decimalDelimiterCB.set_active(keyFile.get_boolean("Decimal Delimiter","Use Decimal Delimiter"));
         decDelTo.set_active(keyFile.get_integer("Decimal Delimiter", "Change Simbol to")); 
         wordEditorCB.set_active(keyFile.get_boolean("Word Editor","Use Wold Editor"));
         wordToChange.set_text(keyFile.get_string("Word Editor","Word to Change"));
         wordToChangeTo.set_text(keyFile.get_string("Word Editor","Word to Change To"));
         dateFormatterCB.set_active(keyFile.get_boolean("Date Formatter","Use Date Formatter"));
         sourceDFCB.set_active(keyFile.get_integer("Date Formatter","Source Date First")); 
         sourceDSCB.set_active(keyFile.get_integer("Date Formatter","Source Date Second")); 
         sourceDTCB.set_active(keyFile.get_integer("Date Formatter","Source Date Third")); 
         sourceDSepEntry.set_text(keyFile.get_string("Date Formatter","Source Date Separator")); 
         resultDFCB.set_active(keyFile.get_integer("Date Formatter","Result Date First")); 
         resultDSCB.set_active(keyFile.get_integer("Date Formatter","Result Date Second")); 
         resultDTCB.set_active(keyFile.get_integer("Date Formatter","Result Date Third")); 
         resultDSepEntry.set_text(keyFile.get_string("Date Formatter","Result Date Separator"));
         endOfLineCB.set_active(keyFile.get_boolean("End of Line","Use End of Line"));
         endOfLineToCB.set_active(keyFile.get_integer("End of Line","Change End of Line To")); 
         encodingCB.set_active(keyFile.get_boolean("Encoding","Use Encoding"));
         encodingChangeFromEntry.set_text(keyFile.get_string("Encoding","Change Encoding From"));
         encodingChangeToEntry.set_text(keyFile.get_string("Encoding","Change Encoding To"));
         return true;
      } catch {
         return false;
      } 

   }

      
}
