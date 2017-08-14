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
* Interface containing the description of the main methods of commands
*/
public interface CommandInterface: Object{
/**
* Set command
*
* @param command command to execute
*/
   public abstract void   setCommand(string command);
/**
* Set command flags
*
* @param flags flags needed by the instrument
*/
   public abstract void setFlags(string flags);
/**
* Get command to execut
*/
   public abstract string getCommand();
/**
* Set flag to prevent command execution
*/
   public abstract void mute();
/**
* Set flag to allow command execution
*/
   public abstract void unmute();
/**
* Check command avaliability 
*/
   public abstract bool isMuted();
}
