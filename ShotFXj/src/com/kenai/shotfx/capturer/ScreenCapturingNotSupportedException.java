/*
 * Copyright (C) <2009> <Nick Wiedenbrueck>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY  or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */
package com.kenai.shotfx.capturer;

/**
 * Platform does not support screen capturing.
 * 
 * @author nwi
 */
public class ScreenCapturingNotSupportedException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ScreenCapturingNotSupportedException() {
		super();
	}

	public ScreenCapturingNotSupportedException(String message, Throwable cause) {
		super(message, cause);
	}

	public ScreenCapturingNotSupportedException(String message) {
		super(message);
	}

	public ScreenCapturingNotSupportedException(Throwable cause) {
		super(cause);
	}

}
