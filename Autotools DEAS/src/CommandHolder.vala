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
* Store {@link CommandInterface} instances
*
* == Short Description ==
*
* Stores {@link CommandInterface} instances, generates complete set of executable commands for {@link CommandExecutor}
*
* @since 0.0.1
*/
public class CommandHolder{
   CommandInterface[] commands;
/**
* Creates a new {@link CommandHolder} instance to hold N commands
*
* == Short Description ==
*
* Creates a new {@link CommandHolder} instance for storing N {@link CommandInterface} instances
*
* @param n Number of {@link CommandInterface} instances to store
*/
   public CommandHolder(int n){
      commands = new CommandInterface[n];
   }

/**
* Adds {@link CommandInterface} to {@link CommandHolder}
*
* == Short Description ==
*
* Adds {@link CommandInterface} to the N-th element of {@link CommandHolder} 
*
* @param n number of the element in array to put {@link CommandInterface} instance to
* @param command {@link CommandInterface} instance to store in {@link CommandHolder}
* @return ''true'' if {@link CommandInterface} was added sucesfullly <<BR>>''false'' if {@link CommandInterface} was not added
*/
   public bool addCommand(int n, CommandInterface command){
      if (n >= commands.length){
         return false;
      } else {   
      commands[n] = command;
         return true;
      } 
   } 


/**
* Set flags for {@link CommandInterface} 
*
* == Short Description ==
*
* Set flags for {@link CommandInterface} instance, stored at the N-th element of {@link CommandHolder} 
*
* @param n number of element in array to set {@link CommandInterface} flags 
* @param flags new flags to set to {@link CommandInterface} instance 
* @return ''true''  if flags were set successfully <<BR>>''false'' if flags were not set
*
*/
   public bool setFlags(int n, string flags){
      if (n >= commands.length){
         return false;
      } else {   
      commands[n].setFlags(flags);
         return true;
      } 
   }
   
/**
* Changes command of {@link CommandInterface} 
*
* == Short Description ==
*
* Changes command of {@link CommandInterface} instance, stored at the N-th element of {@link CommandHolder} 
*
* @param n number of element in array to set {@link CommandInterface} command
* @param command  new command of {@link CommandInterface} 
* @return ''true'' if command was set successfully <<BR>>''false'' if command was not set
*
*/
   public bool setCommand(int n, string command){
      if (n >= commands.length){
         return false;
      } else {   
      commands[n].setCommand(command);
         return true;
      } 

   } 
/**
* Get {@link CommandInterface} instance
*
* == Short Description ==
*
* Return the instance of {@link CommandInterface}, stored as the N-th element of {@link CommandHolder} 
*
* @param n number of the element in array to get
* @return {@link CommandInterface} instance 
*
*/
   public CommandInterface getCommand(int n){
      if (n >= commands.length){
         return null;
      } else {   
         return commands[n];
      }
   }
/**
* Check if command of {@link CommandInterface} is muted
*
* == Short Description ==
*
* Checks if command of {@link CommandInterface} instance, stored at the N-th element of {@link CommandHolder} is muted
*
* @param n number of element in array to mute the {@link CommandInterface} command
* @return ''true'' if the command is muted or doesn't exist,<<BR>>''false'' if the command is not muted
* 
*/
   public bool isMuted(int n) {
      if (n >= commands.length){
         return true;
      } else {   
         return commands[n].isMuted();
      }
   }
/**
* Mutes all commands  
*
* == Short Description ==
*
* Mutes all commands stored in {@link CommandHolder} 
*
*/
   public void muteAll(){
      foreach(CommandInterface com in commands){
         com.mute();
      }
   } 
/**
* Mutes command of {@link CommandInterface} 
*
* == Short Description ==
*
* Mutes command of {@link CommandInterface} instance, stored at the N-th element of {@link CommandHolder} 
*
* @param n number of element in array to mute the {@link CommandInterface} command
*/
   public void mute(int n){
      if (n >= commands.length){
      } else {   
         commands[n].mute();
      } 
   }
/**
* Unmutes command of {@link CommandInterface} 
*
* == Short Description ==
*
* Unmutes command of {@link CommandInterface} instance, stored at the N-th element of {@link CommandHolder} 
*
* @param n number of element in array to unmute the {@link CommandInterface} command
*/
   public void unmute(int n){
      if (n >= commands.length){
      } else {   
         commands[n].unmute();
      } 
   }
/**
* Get the complete set of commands  
*
* == Short Description ==
*
* Gets the complete set of commands, which are not empty or muted, to execute via {@link CommandExecutor}
*
* @return ''string'' containing complete set of commands for execution via {@link CommandExecutor}
*
*/
   public string getCompleteCommand(){
      string completeCommand="";
      foreach(CommandInterface com in commands){
         if (com.getCommand() == ""){
            completeCommand += "";
         } else {
            completeCommand += "| " + com.getCommand();
         }
      }
      return completeCommand;
   }
}
