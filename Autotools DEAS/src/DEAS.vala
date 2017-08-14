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
* Main class of the application
*
* == Short Description ==
*
* Main class of the application, used to create GUI, load GUI .glade file , prepare Gtk, connect all listeners
*
*/

public class DEAS : Window {
   //Software version
   private string softwareVersion="0.0.1";
   //Number of commands
   private int NUMBER_OF_COMMANDS=8;
   //CommandHolder
   private CommandHolder commandHolder;

   //User files 
   private File sourceFile   = File.new_for_path("temporal.sf");
   private File resultFile   = File.new_for_path("temporal.rf");
   private File temporalFile = File.new_for_path("temporal.file");
   private string encoding   = "UTF-8";
   
   // All the elements needed for GUI
   //Main window
   private Builder builder;
   private Window DEASWindow;

   //Header Bar -------------------------------------------------
   private MenuButton logoButton; 
   private Button openSourceTButton; 
   private Button openResultTButton;    
   private Gtk.MenuItem logoMenuSaveMI;
   private Gtk.MenuItem logoMenuOpenMI;
  
    //Body (Main Programm) part-------------------------------------------------
   //source and result views
   private TextView sourceFileView;
   private TextView resultFileView;
   //source and result buttons   
   private Button openSourceMButton;
   private Button openResultMButton;
   //source and result file pathes for user
   private Entry sourceFilePath; 
   private Entry resultFilePath;
   //Save changes to result file Button
   private Button proceedButton;

   //All commands (Stack items) -----------------
   //Page 1 Column Editor -----------------------  
   private CheckButton columnEditorCB;
   private Box columnEditorBox;
   private Entry columnEditorSeparator;
   private Entry columnEditorOrder;
   private Entry columnEditorNewSep;
   private Entry columnEditorExtraCol;

   //Page 2 Decimal Delimiter -------------------
   private CheckButton decimalDelimiterCB;
   private Box decimalDelimiterBox; 
   private ComboBoxText decimalDelimiterFromCB;
   private ComboBoxText decimalDelimiterToCB; 
   
   //Page 3 Word Editor -------------------------
   private CheckButton wordEditorCB;
   private Box wordEditorBox;
   private Entry wordToChange;
   private Entry wordToChangeTo;

   //Page 4 Date Formatter ----------------------
   private CheckButton dateFormatterCB;
   private Box dateFormatterBox; 
   private ComboBoxText sourceDFCB;
   private ComboBoxText sourceDSCB;
   private ComboBoxText sourceDTCB;
   private Entry sourceDViewEntry;
   private Entry sourceDSepEntry;
   private ComboBoxText resultDFCB;
   private ComboBoxText resultDSCB;
   private ComboBoxText resultDTCB;
   private Entry resultDViewEntry;
   private Entry resultDSepEntry;
   private Entry resultPrefixEntry;
   private Button showDChanges;
   
   //Page 5 End of Line--------------------------
   private CheckButton endOfLineCB;
   private Box endOfLineBox;
   private ComboBoxText endOfLineToCB;

   //Page 6 Encoding ----------------------------
   private CheckButton encodingCB;
   private Box encodingBox;
   private Entry encodingChangeFromEntry;
   private Entry encodingChangeToEntry;

   //Other windows ------------------------------------------------------------
   //---------------------------------------------------------- 

   //Source File Chooser Dialog Window ----------------------------------------
   private FileChooserDialog sourceFileChooser;
   private Button sourceFileOpenButton ;
   private ComboBoxText sourceFileEncoding;
   private Entry sourceFileCustomEncoding;
   private CheckButton sourceOverWrite;

   //Result File Chooser Dialog Window -----------------------------------------
   private FileChooserDialog resultFileChooser;
   private Button resultFileChooseButton;
  
   //Proceed Dialog -----------------------------------------------------------
   private Dialog proceedDialog;
   private Button pDialogProceedButton;
   private Button pDialogCancelButton;
   private Entry  pDialogSourceEntry;
   private Entry  pDialogResultEntry;
   private Button pDialogOpenSourceButton;
   private Button pDialogOpenResultButton;

   //Save Preset Dialog --------------------------------------------------------
   private FileChooserDialog savePresetDialog;
   private Button savePresetButton;

   //Open Preset Dialog --------------------------------------------------------
   private FileChooserDialog openPresetDialog;
   private Button openPresetButton;


/**
* Create new {@link DEAS} instance
*
* == Short Description ==
*
*  * Creates a new instance of {@link DEAS}
*  * Prepares {@link CommandHolder} instance
*  * Uses {@link Gtk.Builder} to attach .glade file to GUI
*  * Attaches listeners
*
* @param builderPath path to .glade file
*
*/
   public DEAS(string builderPath){
      prepareCommandHolder(NUMBER_OF_COMMANDS);
      attachFromBuilder(builderPath);
      attachListeners();
   }

/**
* Method to create {@link CommandHolder} and set all {@link CommandInterface}s
*
* == Short Description ==
*
* Creates {@link CommandHolder} and adds all {@link CommandInterface} instances to it
*
* @param n number of {@link CommandInterface} instances to store in {@link CommandHolder}
*
*/
   private void prepareCommandHolder(int n){
      commandHolder = new CommandHolder(n);
      commandHolder.addCommand(0,new ParallelCommand("awk","",10));
      commandHolder.addCommand(1,new ParallelCommand("sed","",5));
      commandHolder.addCommand(2,new ParallelCommand("sed","",5));
      commandHolder.addCommand(3,new ParallelCommand("sed","",5));
      commandHolder.addCommand(4,new Command("awk","",5));
      commandHolder.addCommand(5,new Command("iconv","",5));
      commandHolder.addCommand(6,new Command("iconv","",5,"-t UTF-8 -f"));
      commandHolder.addCommand(7,new Command("mv","",5,"-f "));
      commandHolder.muteAll();
      
   }

/**
* Method to attach elements from .glade to {@link DEAS} instance
*
* == Short Description ==
*
* Attaches all needed GUI elements to {@link DEAS} instance
*
* @param builderPath path to .glade file
*
*/
   private void attachFromBuilder(string builderPath){
      //Reading Builder from .glade file
      builder = new Builder.from_file(builderPath);
      //Main window connection -----------------------------------------------
      DEASWindow            = builder.get_object ("window1") as Window;
      //Header(AppMenu) part ------------------------------------------------- 

      //LogoButton
      logoButton            = builder.get_object("logoButton") as MenuButton;
      logoMenuSaveMI        = builder.get_object("logoMenuSaveMI") as Gtk.MenuItem;
      logoMenuOpenMI        = builder.get_object("logoMenuOpenMI") as Gtk.MenuItem;

      //Open source file button
      openSourceTButton     = builder.get_object("openSourceTopButton") as Button;
      openResultTButton     = builder.get_object("openResultTopButton") as Button;

      //Body (Main Programm) part ---------------------------------------------

      //source and result views
      sourceFileView        = builder.get_object ("sourceFileView") as TextView;
      resultFileView        = builder.get_object ("result") as TextView;

      //source and result buttons   
      openSourceMButton     = builder.get_object("openSourceMidButton") as Button;
      openResultMButton     = builder.get_object("openResultMidButton") as Button;

      //source and result file pathes
      sourceFilePath        = builder.get_object("sourceFilePath") as Entry;
      resultFilePath        = builder.get_object("resultFilePath") as Entry;

      //proceedButton(writes changes to result file)
      proceedButton         = builder.get_object("proceedButton") as Button;
   
      //Stack items -----------------------------------------------------------
   
      //Page 1 Column Editor ------------------------
      columnEditorCB        = builder.get_object("columnEditorCB") as CheckButton;
      columnEditorBox       = builder.get_object("columnEditorBox") as Box;  
      columnEditorSeparator = builder.get_object("columnEditorSeparator") as Entry;
      columnEditorOrder     = builder.get_object("columnEditorOrder") as Entry;
      columnEditorNewSep    = builder.get_object("columnEditorNewSep") as Entry;
      columnEditorExtraCol  = builder.get_object("columnEditorExtraCol") as Entry;

      //Page2 Decimal Delimiter ---------------------
      decimalDelimiterCB    = builder.get_object("decimalDelimiterCB") as CheckButton;
      decimalDelimiterBox   = builder.get_object("decimalDelimiterBox") as Box;  
      decimalDelimiterToCB  = builder.get_object("decimalDelimiterToCB") as ComboBoxText;
      decimalDelimiterFromCB= builder.get_object("decimalDelimiterFromCB") as ComboBoxText;
      
      //Page 3 Word Editor --------------------------
      wordEditorCB        = builder.get_object("wordEditorCB") as CheckButton;
      wordEditorBox       = builder.get_object("wordEditorBox") as Box;  
      wordToChange          = builder.get_object ("wordToChange") as Entry;
      wordToChangeTo        = builder.get_object ("wordToChangeTo") as Entry;
      
      //Page 4 Date Formatter -----------------------
      dateFormatterCB       = builder.get_object("dateFormatterCB") as CheckButton;
      dateFormatterBox      = builder.get_object ("dateFormatterBox") as Box;
      showDChanges          = builder.get_object("showDChanges") as Button;

      //Source date comboboxes, separator, example
      sourceDFCB            = builder.get_object("sourceDFCB") as ComboBoxText;
      sourceDSCB            = builder.get_object("sourceDSCB") as ComboBoxText;
      sourceDTCB            = builder.get_object("sourceDTCB") as ComboBoxText;
      sourceDViewEntry      = builder.get_object("sourceDViewEntry")  as Entry;
      sourceDSepEntry       = builder.get_object("sourceDSepEntry")   as Entry;
      
      //Result date comboboxes, separator, example
      resultDFCB            = builder.get_object("resultDFCB") as ComboBoxText;
      resultDSCB            = builder.get_object("resultDSCB") as ComboBoxText;
      resultDTCB            = builder.get_object("resultDTCB") as ComboBoxText;
      resultDViewEntry      = builder.get_object("resultDViewEntry") as Entry;
      resultPrefixEntry     = builder.get_object("resultPrefixEntry") as Entry;
      resultDSepEntry       = builder.get_object("resultDSepEntry") as Entry;

      //Page 5 End of Line --------------------------
      endOfLineCB           = builder.get_object("endOfLineCB") as CheckButton; 
      endOfLineBox          = builder.get_object("endOfLineBox") as Box;
      endOfLineToCB         = builder.get_object("endOfLineToCB") as ComboBoxText;

      //Page 6 Encoding -----------------------------
      encodingCB              = builder.get_object("encodingCB") as CheckButton;
      encodingBox             = builder.get_object("encodingBox") as Box;
      encodingChangeFromEntry = builder.get_object("encodingChangeFromEntry") as Entry;
      encodingChangeToEntry   = builder.get_object("encodingChangeToEntry") as Entry;
  
      //Other windows ---------------------------------------------------------------------------------

      //Source File Chooser Dialog Window -----------------------

      sourceFileChooser        = builder.get_object("sourceFileChooser") as FileChooserDialog;
      sourceFileOpenButton     = builder.get_object("openSourceButton") as Button;
      sourceFileEncoding       = builder.get_object("sourceFileEncoding") as ComboBoxText;
      sourceFileCustomEncoding = builder.get_object("customEncoding") as Entry;
      sourceOverWrite          = builder.get_object("sourceORCB") as CheckButton;

      //Result File Chooser Dialog Window -----------------------
      resultFileChooser        = builder.get_object("resultFileOpener") as FileChooserDialog;
      resultFileChooseButton   = builder.get_object("chooseResultButton") as Button;
   
      //Proceed Dialog -----------------------------------------
      proceedDialog            = builder.get_object("procceedDialog") as Dialog;
      pDialogProceedButton     = builder.get_object("pDialogProceedButton") as Button;
      pDialogCancelButton      = builder.get_object("pDialogCancelButton")  as Button;
      pDialogSourceEntry       = builder.get_object("pDialogSourceEntry") as Entry;
      pDialogResultEntry       = builder.get_object("pDialogResultEntry") as Entry;
      pDialogOpenSourceButton  = builder.get_object("pDialogOpenSourceButton") as Button;
      pDialogOpenResultButton  = builder.get_object("pDialogOpenResultButton") as Button;
      //Save Preset Dialog --------------------------------------
      savePresetDialog         = builder.get_object("savePresetDialog") as FileChooserDialog;
      savePresetButton         = builder.get_object("savePresetButton") as Button;
   
      //Open Preset Dialog --------------------------------------
      openPresetDialog         = builder.get_object("openPresetDialog") as FileChooserDialog;
      openPresetButton         = builder.get_object("openPresetButton") as Button;

}

/**
* Method to attcah listeners to GUI elements
*
* == Short Description ==
*
* Attaches listeners to GUI elements of {@link DEAS} instance
*
*/
   private void attachListeners(){
      //Main window ------------------------------------------------
      //Destroy on window close listener
      DEASWindow.destroy.connect(Gtk.main_quit);      
   
      //Header Bar -------------------------------------------------
   
      //Open source, result FileChooserDialogs Buttons listners

      // Top open sourceFile Chooser Button
      openSourceTButton.clicked.connect(()=>{
         sourceFileChooser.show();
      });

      // Top open resultFile Chooser Button
      openResultTButton.clicked.connect(()=>{
         resultFileChooser.show();
      });

      //Logo MenuButton menuitems listeners

      // Save Preset MenuItem
      logoMenuSaveMI.activate.connect(()=>{
         savePresetDialog.show();
      });

      // Load preset MenuItem
      logoMenuOpenMI.activate.connect(()=>{
         openPresetDialog.show();
      });
   
      //Body (Main Programm) part------------------------------------
    
      //Open source, result FileChooserDialogs Buttons listeners   

      // Middle open sourceFile Button
      openSourceMButton.clicked.connect(()=>{
         sourceFileChooser.show();
      });

      // Middle open resultFile Button
      openResultMButton.clicked.connect(()=>{
         resultFileChooser.show();
      });
   
      //Proceed Button
      proceedButton.clicked.connect(()=>{
         if (sourceFilePath.get_text()==""){
            sourceFileChooser.show();
         } else if (resultFilePath.get_text()==""){
            resultFileChooser.show();
         } else {
            proceedDialog.show();
         } 
      });
   
      //Stack items -------------------------------------------------

      //Page 1 Column Editor ------------------------

      // Use Column Editor CheckButton
      columnEditorCB.toggled.connect(()=>{
      if (columnEditorCB.active){
         columnEditorBox.show();
         commandHolder.unmute(0);
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
      } else {
         columnEditorBox.hide();
         commandHolder.mute(0);
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
      }  
      });
      
      // Old column separator
      columnEditorSeparator.changed.connect(()=>{
         if (columnEditorSeparator.get_text()==""){
            commandHolder.setFlags(0,"");
         } else {
            commandHolder.setFlags(0,"-F\\\""+columnEditorSeparator.get_text()+"\\\"");
         }
      });
   
      // New column order
      columnEditorOrder.changed.connect(()=>{
         if (columnEditorOrder.get_text()==""){
            commandHolder.setCommand(0,"");
         } else {
            commandHolder.setCommand(0,AwkRegExp.changeColumnOrder(columnEditorOrder.get_text(),columnEditorNewSep.get_text(),columnEditorExtraCol.get_text()));
            resultFileView.buffer.text=commandHolder.getCommand(0).getCommand();
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });
   
      // New column separator
      columnEditorNewSep.changed.connect(()=>{
         if (columnEditorOrder.get_text()==""){
            commandHolder.setCommand(0,"");
         } else {
            commandHolder.setCommand(0,AwkRegExp.changeColumnOrder(columnEditorOrder.get_text(),columnEditorNewSep.get_text(),columnEditorExtraCol.get_text()));
            resultFileView.buffer.text=commandHolder.getCommand(0).getCommand();
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });
  
      // Extra column
      columnEditorExtraCol.changed.connect(()=>{
         if (columnEditorOrder.get_text()==""){
            commandHolder.setCommand(0,"");
         } else {
            commandHolder.setCommand(0,AwkRegExp.changeColumnOrder(columnEditorOrder.get_text(),columnEditorNewSep.get_text(),columnEditorExtraCol.get_text()));
            resultFileView.buffer.text=commandHolder.getCommand(0).getCommand();
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      }); 
      //Page 2 Decimal Delimiter -------------------

      // Change Decimal Delimiter CheckButton
      decimalDelimiterCB.toggled.connect(()=>{
         if (decimalDelimiterCB.active){
            decimalDelimiterBox.show();
            commandHolder.unmute(1);
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            decimalDelimiterBox.hide();
            commandHolder.mute(1);
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });

      // Change Delimiter From *redundant - only used for interactivity
      decimalDelimiterFromCB.changed.connect(()=>{
         if (decimalDelimiterFromCB.get_active_text()=="."){
            decimalDelimiterToCB.set_active(1);
            commandHolder.setCommand(1,SedRegExp.replaceDecimalDelimiter(","));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            decimalDelimiterToCB.set_active(0);
            commandHolder.setCommand(1,SedRegExp.replaceDecimalDelimiter("."));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });

      //Change Delimiter To
      decimalDelimiterToCB.changed.connect(()=>{
         if (decimalDelimiterToCB.get_active_text()=="."){
            decimalDelimiterFromCB.set_active(1);
            commandHolder.setCommand(1,SedRegExp.replaceDecimalDelimiter("."));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            decimalDelimiterFromCB.set_active(0);
            commandHolder.setCommand(1,SedRegExp.replaceDecimalDelimiter(","));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });
   
      //Page 3 Word Editor -------------------------

      // Use Word Editor CheckButton
      wordEditorCB.toggled.connect(()=>{
         if (wordEditorCB.active){
            wordEditorBox.show();
            commandHolder.unmute(2);
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            wordEditorBox.hide();
            commandHolder.mute(2);
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });

      // Word to Change Entry
      wordToChange.changed.connect(()=>{
         if (wordToChange.get_text() == ""){
            commandHolder.setCommand(2,"");
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            commandHolder.setCommand(2,SedRegExp.replaceWords(wordToChange.get_text(),wordToChangeTo.get_text()));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });

      // Word to Change to Entry
      wordToChangeTo.changed.connect(()=>{
         if (wordToChange.get_text() == ""){
            commandHolder.setCommand(2,"");
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         } else {
            commandHolder.setCommand(2,SedRegExp.replaceWords(wordToChange.get_text(),wordToChangeTo.get_text()));
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
         }
      });
   
      //Page 4 Date Formatter ----------------------

      // Use Date Formatter CheckButton
      dateFormatterCB.toggled.connect(()=>{
         if (dateFormatterCB.active){
            dateFormatterBox.show();
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
            commandHolder.unmute(3);
         } else {
            dateFormatterBox.hide();
            resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
            commandHolder.mute(3);
         }
   
      });

      //Source Date Format Preview Generation   
      sourceDFCB.changed.connect(()=>{
         sourceDViewEntry.set_text(Date.generateVisibleDate(sourceDFCB.get_active_text(),sourceDSCB.get_active_text(),sourceDTCB.get_active_text(),sourceDSepEntry.get_text()));
      });
      sourceDSCB.changed.connect(()=>{
         sourceDViewEntry.set_text(Date.generateVisibleDate(sourceDFCB.get_active_text(),sourceDSCB.get_active_text(),sourceDTCB.get_active_text(),sourceDSepEntry.get_text()));
      });
      sourceDTCB.changed.connect(()=>{
         sourceDViewEntry.set_text(Date.generateVisibleDate(sourceDFCB.get_active_text(),sourceDSCB.get_active_text(),sourceDTCB.get_active_text(),sourceDSepEntry.get_text()));
      });
      sourceDSepEntry.changed.connect(()=>{   
         sourceDViewEntry.set_text(Date.generateVisibleDate(sourceDFCB.get_active_text(),sourceDSCB.get_active_text(),sourceDTCB.get_active_text(),sourceDSepEntry.get_text()));
      });

      //Result Date Format Preview Generation
      resultDFCB.changed.connect(()=>{
         resultDViewEntry.set_text(Date.generateVisibleDate(resultDFCB.get_active_text(),resultDSCB.get_active_text(),resultDTCB.get_active_text(),resultDSepEntry.get_text()));
      });
      resultDSCB.changed.connect(()=>{
         resultDViewEntry.set_text(Date.generateVisibleDate(resultDFCB.get_active_text(),resultDSCB.get_active_text(),resultDTCB.get_active_text(),resultDSepEntry.get_text()));
      });
      resultDTCB.changed.connect(()=>{
         resultDViewEntry.set_text(Date.generateVisibleDate(resultDFCB.get_active_text(),resultDSCB.get_active_text(),resultDTCB.get_active_text(),resultDSepEntry.get_text()));
      });
      resultDSepEntry.changed.connect(()=>{
         resultDViewEntry.set_text(Date.generateVisibleDate(resultDFCB.get_active_text(),resultDSCB.get_active_text(),resultDTCB.get_active_text(),resultDSepEntry.get_text()));
      });

      // Show Changes in ResultView Button
      showDChanges.clicked.connect(()=>{
         commandHolder.setCommand(3,SedRegExp.reformatDate(sourceDFCB.get_active_text(),sourceDSCB.get_active_text(),sourceDTCB.get_active_text(),sourceDSepEntry.get_text(),resultDFCB.get_active_text(),resultDSCB.get_active_text(),resultDTCB.get_active_text(),resultDSepEntry.get_text(),resultPrefixEntry.get_text()));
         resultFileView.buffer.text=CommandExecutor.visualExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder);
      });
   
      //Page 5 End of Line ------------------------------------------------

      // Change end of line
      endOfLineCB.toggled.connect(()=>{
         if (endOfLineCB.active){
            endOfLineBox.show();
         } else {
            endOfLineBox.hide();
         }
      });

      // Change end of line to   
      endOfLineToCB.changed.connect(()=>{
         commandHolder.setCommand(6,AwkRegExp.changeEOL(endOfLineToCB.get_active_text()));
      });
   
      //Page 6 Encoding ---------------------------------------------------

      // Change file encoding
      encodingCB.toggled.connect(()=>{
         if (encodingCB.active){
            encodingBox.show();
         } else {
            encodingBox.hide();
         }
      });
      
      //Change encoding from
      encodingChangeFromEntry.changed.connect(()=>{
         if((encodingChangeFromEntry.get_text()=="")||(encodingChangeToEntry.get_text()=="")){
            commandHolder.setCommand(5,"");
         } else {
            commandHolder.setCommand(5,"-f "+encodingChangeFromEntry.get_text()+" -t "+encodingChangeToEntry.get_text());
         }
      }); 

      //Change encoding to
      encodingChangeToEntry.changed.connect(()=>{
         if((encodingChangeFromEntry.get_text()=="")||(encodingChangeToEntry.get_text()=="")){
            commandHolder.setCommand(5,"");
         } else {
            commandHolder.setCommand(5,"-f "+encodingChangeFromEntry.get_text()+" -t "+encodingChangeToEntry.get_text());
         } 
      }); 
   
   
      // Other windows ------------------------------------------------------------------------------------------------------------------------------
       
      // Source File Chooser Dialog Window ----------------------------------------

      // Encoding ComboBox listener
      sourceFileEncoding.changed.connect(()=>{
      if (sourceFileEncoding.get_active_text() == "Other"){
         sourceFileCustomEncoding.show();
      } else{
         sourceFileCustomEncoding.hide();
      }
      });

      // SourceFile openButton 
      sourceFileOpenButton.clicked.connect(()=>{
         // Set sourceFile to file
         sourceFile=sourceFileChooser.get_file();
         // Get encoding, if not UTF-8 -> prepare command 
         if (sourceFileEncoding.get_active_text() == "UTF-8"){
           commandHolder.mute(6);
         } else{
            if (sourceFileEncoding.get_active_text()=="Other"){
               encoding = sourceFileCustomEncoding.get_text();
            } else {
               encoding = sourceFileEncoding.get_active_text();
            }
            commandHolder.setCommand(6,encoding + " ");
         }
         //Set file encodingFrom on Page5
         encodingChangeFromEntry.set_text(encoding);
         sourceFileChooser.hide();
         //Set file path for user
         sourceFilePath.set_text(sourceFile.get_path());
         pDialogSourceEntry.set_text(sourceFilePath.get_text());
         //Get file content
         string lines = CommandExecutor.visualExecuteCommand(RegExp.escapeSpaces(sourceFilePath.get_text()),commandHolder.getCommand(6));
         sourceFileView.buffer.text=lines;
         resultFileView.buffer.text=lines;
         // If OverWrite CheckButton is checked set resultFile path to same file
         if (sourceOverWrite.active){
            resultFile=sourceFile;
            resultFilePath.set_text(resultFile.get_path());
            pDialogResultEntry.set_text(resultFilePath.get_text()); 
            sourceOverWrite.set_active(false);
         }
      });

      //Procceed Dialog ----------------------------------------------------

      //Cancel Button 
      pDialogCancelButton.clicked.connect(()=>{
         proceedDialog.hide();
      });

      //Proceed Button
      pDialogProceedButton.clicked.connect(()=>{
         commandHolder.mute(6);
         if (endOfLineCB.active){commandHolder.unmute(4);}
         if (encodingCB.active){commandHolder.unmute(5);}
         if  (pDialogSourceEntry.get_text()==pDialogResultEntry.get_text()) {
            commandHolder.setCommand(7, " ");
            CommandExecutor.silentExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),RegExp.escapeSpaces(temporalFile.get_path()),commandHolder);
            commandHolder.unmute(7);
            CommandExecutor.silentExecuteCommand(RegExp.escapeSpaces(temporalFile.get_path()), RegExp.escapeSpaces(resultFilePath.get_text()), commandHolder.getCommand(7));
            commandHolder.mute(7);
         } else {
            CommandExecutor.silentExecute(RegExp.escapeSpaces(sourceFilePath.get_text()),RegExp.escapeSpaces(resultFilePath.get_text()),commandHolder);
         }
         proceedDialog.hide(); 
         commandHolder.mute(4);     
         commandHolder.mute(5);     
         
      });

      // Open source file Procced Dialog Button
      pDialogOpenSourceButton.clicked.connect(()=>{
         sourceFileChooser.show();
      });
      
      // Open resul file Procced Dialog Button
      pDialogOpenResultButton.clicked.connect(()=>{
         resultFileChooser.show();
      });

      //Save Preset Dialog -------------------------------------------------
      savePresetButton.clicked.connect(()=>{
         // Get file path
         string fileToWriteToPath = savePresetDialog.get_file().get_path();
         // Use Preset Class to save Glib.KeyFile
         Preset.savePreset(fileToWriteToPath, softwareVersion, columnEditorCB, columnEditorSeparator,columnEditorOrder, columnEditorNewSep, columnEditorExtraCol, decimalDelimiterCB,decimalDelimiterToCB, wordEditorCB, wordToChange, wordToChangeTo, dateFormatterCB, sourceDFCB, sourceDSCB, sourceDTCB, sourceDSepEntry, resultDFCB, resultDSCB, resultDTCB, resultDSepEntry, endOfLineCB, endOfLineToCB, encodingCB, encodingChangeFromEntry, encodingChangeToEntry);   
         savePresetDialog.hide();
      });
    
      //Open Preset Dialog -------------------------------------------------
      openPresetButton.clicked.connect(()=>{
         openPresetDialog.hide();
         // Get file path
         string fileToReadPath = openPresetDialog.get_file().get_path();
         // Use Preset Class to load Glib.KeyFile
         Preset.loadPreset(fileToReadPath, softwareVersion, columnEditorCB, columnEditorSeparator,columnEditorOrder, columnEditorNewSep, columnEditorExtraCol, decimalDelimiterCB,decimalDelimiterToCB, wordEditorCB, wordToChange, wordToChangeTo, dateFormatterCB, sourceDFCB, sourceDSCB, sourceDTCB, sourceDSepEntry, resultDFCB, resultDSCB, resultDTCB, resultDSepEntry, endOfLineCB, endOfLineToCB, encodingCB, encodingChangeFromEntry, encodingChangeToEntry);   
      });
   
      // Result File Chooser Dialog Window ----------------------------------
      
      // Open resultFile Button
      resultFileChooseButton.clicked.connect(()=>{
         resultFile=resultFileChooser.get_file();
         resultFilePath.set_text(resultFile.get_path());
         pDialogResultEntry.set_text(resultFilePath.get_text()); 
         resultFileChooser.hide();
      }); 
   
   }
/**
* Main method of the application
*
* == Short Description ==
*
* Method used to initialize Gtk, set default theme, creat {@link DEAS} instance and call Window.show_all()
* 
* @param args Gtk flags 
*
*/
   public static int main (string[] args){
      // Initializing GTK
      Gtk.init(ref args);
      // Setting default theme
      Gtk.Settings.get_default().set("gtk-application-prefer-dark-theme", true);
      // Craeting DEAS instance
      DEAS DEASInstance = new DEAS("/usr/local/share/DEASGUI.glade");
      // Showing the window 
      DEASInstance.DEASWindow.show_all();

      Gtk.main();
      return 0;
   }
}
