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
* Store information about GNU parallel Bash command
*
* == Short Description ==
*
* Stores GNU parallel Bash command and inner {@link Command} instance
*
* @since 0.0.2
*/
public class ParallelCommand: Object,CommandInterface{
   private const string BASIC_FLAGS="--no-notice -q -k --pipe "; 
   private const string pCommand="parallel ";
   private string parallelFlags;
   private Command command;
/**
* Creates new ParallelCommand instance
*
* == Short Description ==
*
* Creates an instance of {@link ParallelCommand} with specified parameters
*
* @param instrument command line instrument, used for command execution
* @param command command to execute
* @param priority priority of command, used to determine command order
* @param flags istrument flags
* @param parallelFlags additional flags for parallel
*/
   public ParallelCommand(string instrument, string command,int priority,string flags="",string parallelFlags=""){
      this.command = new Command(instrument,command,priority,flags);
      this.parallelFlags = parallelFlags;
   }
/**
* {@inheritDoc}
* 
* == Short Description ==
*
* Set the {@link Command} instance command of {@link ParallelCommand}
*
* @param command the command to execute
*/
   public void setCommand(string command){
      this.command.setCommand(command); 
   }
/**
* Set parallel flags for command execution
*
* == Short Description ==
*
* Set additional flags of the GNU Parallel command
*
* @param parallelFlags flags used by parallel
*/
   public void setParallelFlags(string parallelFlags){
      this.parallelFlags=parallelFlags;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
* 
* Set the flags of the {@link Command} instance of {@link ParallelCommand}
*
* @param flags flags to set to {@link Command}
*/
   public void setFlags(string flags){
      this.command.setFlags(flags);
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Mute the {@link Command} instance of {@link ParallelCommand}
*
*/
   public void mute(){
      this.command.mute();
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Unmute the {@link Command} instance of {@link ParallelCommand}
*
*/
   public void unmute(){
      this.command.unmute();
   }

/**
* {@inheritDoc}
*
* == Short Description ==
*
* Check if the {@link Command} instance of {@link ParallelCommand} is muted
*
* @return ''true''- when command is muted, thus not anavaliable for execution <<BR>>''false'' - when command is not muted
*/
   public bool isMuted(){
      return this.command.isMuted();
   }
/**
* {@inheritDoc}
*
* == Short Description ==
* 
* Gets the complete command, ready for execution  with both parallel flags and command flags set 
*
* @return ''string'', containing command - if it is not muted or empty<<BR>> ''empty string'' - if command is muted or empty
*/
   public string getCommand(){
      if (command.getCommand() == ""){
         return "";
      } else {
         return pCommand + BASIC_FLAGS + parallelFlags + " " + command.getCommand();
      }
   } 
  
}
