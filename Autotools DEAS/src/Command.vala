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
* Store information about Bash command
*
* == Short Description ==
*
* Stores Bash command, instrument, flags
*
* @since 0.0.1
*/
public class Command: Object,CommandInterface{
/**
* Name of the instrument
*
* == Short Description ==
* 
* Stores instrument name
*
*/
   private string instrument;
/**
* Command to Execute 
*
* == Short Description ==
*
* Stores command
*
*/
   private string command;
/**
* Flags pased to the instrument
*
*
*/
   private string flags;
/**
* Priority of the command, used to determine commands order of execution
*
* == Short Description ==
*
* Stores command priority
*
* @deprecated true
*
*/
   private int priority;
/**
* Muted state of command
*
* == Short Description ==
*
* Stores muted state of command
*
*/
   private bool muted;
/**
* Creates a new {@link Command} instance
*
* Creates a new instnse of {@link Command} with specified parameters.
*
* @param instrument - commad line instrument, used to preform command
* @param command    - command to preform
* @param priority   - priority of command, used to determine command order
* @param flags      - instrument flags 
* @param muted      - boolean muted field, used to determine if the comand will be executed 
* 
*/
   public Command(string instrument, string command,int priority=5, string flags="",bool muted=false){
      this.instrument = instrument;
      this.command = command;
      this.priority = priority;
      this.flags=flags;
      this.muted=muted;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Sets the command parameter of {@link Command} instance
*
* @param command command to execute
*/
   public void setCommand(string command){
      this.command =command;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Set the flags of {@link Command} instance
*
* @param flags flags needed by the instrument
*
*/
   public void setFlags(string flags){
      this.flags=flags;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Mute the {@link Command} instance command
*
*/
   public void mute(){
      this.muted=true;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Unmute the {@link Command} instance command
*
*/
   public void unmute(){
      this.muted=false;
   }
/**
* {@inheritDoc}
*
* == Short Description ==
*
* Check if the {@link Command} instance is muted
*
* @return ''true'' if command is muted, thus is unavaliable for execution<<BR>> ''false'' if command is not muted, thus is avaliable for execution
*/
   public bool isMuted(){
      return this.muted;
   }
/**
* {@inheritDoc}
*
* Get  Bash command for execution via {@link CommandExecutor}
*
* @return ''string'' with commad ready for execution if command is not muted or empty <<BR>> ''empty string'' if command is muted or empty 
*/
   public string getCommand(){
      if ((command == "")||(muted)){
         return "";
      } else {
         return instrument + " " + flags + " " + command + " ";
      }
   } 
}
