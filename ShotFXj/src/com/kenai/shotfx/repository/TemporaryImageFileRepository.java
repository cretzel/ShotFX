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
package com.kenai.shotfx.repository;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.imageio.ImageIO;

public class TemporaryImageFileRepository implements IImageFileRepository {

	private static final String FORMAT_NAME = "png";

	public TemporaryImageFileRepository() {
	}

	public URL addImage(BufferedImage image) {
		try {
			return createTemporaryFile(image);
		} catch (ImageFileRepositoryIOException e) {
			return null;
		}
	}

	private URL createTemporaryFile(BufferedImage image)
			throws ImageFileRepositoryIOException {
		File tmpFile;

		try {
			tmpFile = createNewTmpFile();
		} catch (IOException e) {
			throw new ImageFileRepositoryIOException(
					"Tmp file could not be created", e);
		}

		try {
			ImageIO.write(image, FORMAT_NAME, tmpFile);
		} catch (IOException e) {
			throw new ImageFileRepositoryIOException(
					"Image could not be written to file", e);
		}

		URL url;
		try {
			url = tmpFile.toURI().toURL();
		} catch (MalformedURLException e) {
			throw new ImageFileRepositoryIOException(
					"Image url could not be created", e);
		}

		return url;
	}

	private File createNewTmpFile() throws IOException {
		return File.createTempFile("screenshot", null);
	}
}
