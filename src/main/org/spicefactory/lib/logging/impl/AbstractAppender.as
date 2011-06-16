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
	
import org.spicefactory.lib.logging.Appender;
import org.spicefactory.lib.logging.LogEvent;
import org.spicefactory.lib.logging.LogLevel;
import org.spicefactory.lib.logging.SpiceLogger;
	

/**
 * Abstract base implementation of the <code>Appender</code> interface.
 * 
 * @author Jens Halm
 */
public class AbstractAppender implements Appender {
		
		
	private var _threshold:LogLevel;
	
	
	/**
	 * @private
	 */
	public function AbstractAppender () {
		_threshold = LogLevel.TRACE;
	}

	/**
	 * @inheritDoc
	 */
	public function set threshold (level:LogLevel) : void {
		_threshold = level;
	}
	
	/**
	 * @inheritDoc
	 */
	public function get threshold () : LogLevel {
		return _threshold;
	}
	
	/**
	 * @inheritDoc
	 */
	public function registerLogger (logger:SpiceLogger) : void {
		logger.addEventListener(LogEvent.LOG, handleLogEvent);
	}
	
	/**
	 * Invoked whenever a <code>Logger</code> instance registered with this
	 * <code>Appender</code> fires a <code>LogEvent</code>.
	 * 
	 * @param event the LogEvent to handle
	 */
	protected function handleLogEvent (event:LogEvent) : void {
		/* do nothing */
	}
	
	/**
	 * Checks whether the specified <code>LogLevel</code> is below
	 * the threshold of this <code>Appender</code>.
	 * 
	 * @param level the LogLevel to compare to the threshold of this Appender
	 * @return true if the specified LogLevel is below
	 * the threshold of this Appender
	 */
	protected function isBelowThreshold (level:LogLevel) : Boolean {
		return (level.toValue() < _threshold.toValue());
	}		
		
}
	
}