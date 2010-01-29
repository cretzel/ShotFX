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
package com.kenai.shotfx;

import java.awt.image.BufferedImage;
import java.net.URL;

import com.kenai.shotfx.capturer.IScreenCapturer;
import com.kenai.shotfx.capturer.ScreenCapturer;
import com.kenai.shotfx.repository.IImageFileRepository;
import com.kenai.shotfx.repository.TemporaryImageFileRepository;

public class Screenshooter {

    private IScreenCapturer capturer;
    private IImageFileRepository repository;

    public Screenshooter() {
        repository = new TemporaryImageFileRepository();
        capturer = new ScreenCapturer();
    }

    public URL screenshot(int x, int y, int width, int height) {
        System.out.println("shot");
        BufferedImage img = capturer.captureScreen(x, y, width, height);
        return repository.addImage(img);
    }
}
