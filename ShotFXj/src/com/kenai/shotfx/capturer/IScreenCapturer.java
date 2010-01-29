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

import java.awt.image.BufferedImage;

/**
 * Provides the basic screen capturing facilities.
 * 
 * @author nwi
 */
public interface IScreenCapturer {

	/**
	 * Captures the screen at the specified rectangular location.
	 * 
	 * @param x
	 *            x-coordinate of the upper left corner
	 * @param y
	 *            y-coordinate of the upper left corner
	 * @param width
	 *            width of the rectangle
	 * @param height
	 *            height of the rectangle
	 * @return Image of the captured rectangle
	 */
	BufferedImage captureScreen(int x, int y, int width, int height);

}