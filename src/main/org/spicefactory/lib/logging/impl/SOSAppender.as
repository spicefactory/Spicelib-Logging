/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.logging.impl {

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.XMLSocket;
import org.spicefactory.lib.collection.List;
import org.spicefactory.lib.logging.LogEvent;
import org.spicefactory.lib.logging.SpiceLogger;


/**
 * Appender implementation that routes all log output to Powerflasher SOS through
 * an XMLSocket. SOS is a Java application that displays log output in a window
 * with filtering and coloring options.<br><br>
 * The default connection is localhost:4444. You may change this by
 * setting the <code>host</code> and <code>port</code> properties.
 * <br><br>
 * For more information 
 * see <a href="http://sos.powerflasher.com" target="_blank">http://sos.powerflasher.com</a>.
 * 
 * @author Jens Halm
 * @author Nico Zimmermann
 */
public class SOSAppender extends AbstractAppender {
	

	private var _host:String = "localhost";
	private var _port:uint = 4444;
	private var _useShortNames:Boolean = false;
	
	private var socket:XMLSocket;
	private var ready:Boolean;
	private var cache:List;
	
	/**
	 * Creates a new instance. The new instance does not automatically connect
	 * to Powerflasher SOS. Use the <code>init</code> method to initiate the connection.	 */
	public function SOSAppender () {
		super();
		ready = false;
	}
	
	public function set host (value:String) : void {
		_host = value;
	}
	
	/**
	 * The host to connect to. The default is localhost.
	 */
	public function get host () : String {
		return _host;
	}
	
	public function set port (value:uint) : void {
		_port = value;
	}
	
	/**
	 * The port to connect to. The default is 4444.
	 */
	public function get port () : uint {
		return _port;
	}
	
	public function set useShortNames (value:Boolean) : void {
		_useShortNames = value;
	}
	
	/**
	 * Indicates whether to use short names or fully qualified class names / logger names.
	 * If this property is set to true it will only use the part of the logger name after
	 * the last occurence of <code>'.'</code>.
	 */
	public function get useShortNames () : Boolean {
		return _useShortNames;
	}
	
	/**
	 * Initializes the <code>XMLSocket</code> and connects to Powerflasher SOS.	 */
	[Init]
	public function init () : void {
		cache = new List(); // just in case the first logs arrive before socket is ready
		socket = new XMLSocket();
		socket.addEventListener(Event.CONNECT, onConnect);
		socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		try {
			socket.connect(host, port);
		} catch (error:SecurityError) {
			handleError("SecurityError in SOSAppender: " + error);
		}
	}
	
	private function handleError (message:String) : void {
		// do not log to avoid loops
		trace(message);
		try {
			socket.close();
		}
		catch (e:Error) {
			trace("Error closing socket: " + e.message);
		}
		socket = null;
		cache = null;		
	}
	
	private function onConnect (event:Event) : void {
		ready = true;
		for each (var logEvent:LogEvent in cache.toArray()) {
			handleLogEvent(logEvent);
		} 	
		cache = null;
	}
	
	private function onError (event:ErrorEvent) : void {
		handleError("Error in SOSAppender: " + event.type + " - " + event.text);
	}
	
	/**
	 * @private
	 */
	protected override function handleLogEvent (event:LogEvent) : void {
		if (socket == null || isBelowThreshold(event.level)) return;
		if (!ready) {
			cache.add(event);
			return;
		}
		var message:String = formatLogMessage(event);
		send(message);
	}
	
	/**
	 * @private
	 */
	protected function formatLogMessage (event:LogEvent) : String {
		var loggerName:String = SpiceLogger(event.target).name;
		if (useShortNames) {
			var index:Number = loggerName.lastIndexOf("::");
			if (index != -1) loggerName = loggerName.substring(index + 1);
		}
		var level:String = event.level.toString();
		var message:String = event.message;
		var command:String;
		if (message.indexOf(":::") > -1) {
			var elems : Array = message.split(":::");
			var title : String = elems[0];
			var body : String = elems[1];
			command = "!SOS<showFoldMessage key=\"" + level + "\"><title><![CDATA[" 
				+ loggerName + ": " + title + "]]></title><message><![CDATA[" 
				+ body + "]]></message></showFoldMessage>\n";
		} else {
			command = "!SOS<showMessage key=\"" + level + "\"><![CDATA[" 
				+ loggerName + ": " + message + "]]></showMessage>\n";
		}
		return command;
	}
		
	/**
	 * Sends a custom command to Powerflasher SOS. For documentation
	 * on available commands see http://sos.powerflasher.com.
	 * 
	 * @param command the command to send to SOS
	 */					
	public function sendCommand (command:String) : void {
		if (ready) send("!SOS" + command);
	}
	
	private function send (str:String) : void {
		try {
			socket.send(str);
		}
		catch (e:Error) {
			trace("Error sending " + str + ": " + e.message);
		}
	}


}


}
