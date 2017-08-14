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
* Execute {@link CommandInterface} instances stored in {@link CommandHolder}
*
* == Short Description ==
*
* Executes {@link CommandInterface} instances stored in {@link CommandHolder}
* <<BR>>Also can be uset to execute simple {@link CommandInterface} instances
*
*/
public class CommandExecutor{
/**
* Execute all unmuted {@link CommandHolder} commands
*
* == Short Description ==
*
* Executes set of commands stored in {@link CommandHolder}
*
* @param sourceFilePath path to source file
* @param commandHolder  instance of {@link CommandHolder} with  set of commands to execute
* @return ''string'' result of command execution
*/   
   public static string visualExecute(string sourceFilePath, CommandHolder commandHolder){
      var commandLine="sh -c \"" + "head -q -n 10 " + sourceFilePath + " " +commandHolder.getCompleteCommand() + "\"";
      var visualResultString="";
      try{
         Process.spawn_command_line_sync(commandLine,out visualResultString, null, null);
      } catch (Error e) {
      }
      return visualResultString;
   }
/**
* Execute all unmuted {@link CommandHolder} commands and save them to result file
*
* == Short Description ==
*
* Executes set of commands stored in {@link CommandHolder} and save them to result file
*
* @param sourceFilePath path to source file
* @param resultFilePath path to result file
* @param commandHolder  instance of {@link CommandHolder} with  set of commands to execute
*/   
   public static void silentExecute(string sourceFilePath, string resultFilePath, CommandHolder commandHolder){
      var commandLine = "sh -c \""+ "cat " + sourceFilePath + " " + commandHolder.getCompleteCommand() + " > " + resultFilePath + " \"";
      try{
         Process.spawn_command_line_sync(commandLine, null, null ,null);
      } catch (Error e) {
         
      }
   }
/**
* Execute one unmuted {@link CommandInterface} 
*
* == Short Description ==
*
* Executes one unmuted, not empty command from {@link CommandInterface}
*
* @param sourceFilePath path to source file
* @param resultFilePath path to result file
* @param command instance of {@link CommandInterface}
*
*/   
   public static void silentExecuteCommand (string sourceFilePath, string resultFilePath, CommandInterface command) {
      string commandLine ="";
      if(command.getCommand()==""){

      } else {
         commandLine = "sh -c \"" + command.getCommand() + sourceFilePath + " " + resultFilePath + "\" ";
      }
      try{
         Process.spawn_command_line_sync(commandLine,null, null, null);
      } catch (Error e) {
      }
}
/**
* Execute one unmuted {@link CommandInterface} 
*
* == Short Description ==
*
* Executes one unmuted, not empty command from {@link CommandInterface}
*
* @param sourceFilePath path to source file
* @param command instance of {@link CommandInterface}
* @return ''string'' result of command execution
*/   
      public static string visualExecuteCommand(string sourceFilePath, CommandInterface command){
      string commandLine ="";
      if (command.getCommand()==""){ 
         commandLine="sh -c \"" + "head -q -n 10 " + sourceFilePath + "\"";
      } else {
         commandLine="sh -c \"" + "head -q -n 10 " + sourceFilePath + " | " +command.getCommand() + "\"";
      }
      var visualResultString="";
      try{
         Process.spawn_command_line_sync(commandLine,out visualResultString, null, null);
      } catch (Error e) {
      }
      return visualResultString;
   }
}
   

