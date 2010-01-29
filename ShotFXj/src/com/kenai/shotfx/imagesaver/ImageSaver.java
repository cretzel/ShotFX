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
package com.kenai.shotfx.imagesaver;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;

/**
 * Saves images to the disk.
 * <p>
 * Opens file dialog and saves an image to the selected file.
 * @author cretzel
 */
public class ImageSaver {

    public ImageSaver() {
    }

    public boolean saveImage(String imageUrl) {
        String userHome = System.getProperty("user.home");
        System.out.println(userHome);

        JFileChooser chooser;
        if (userHome != null) {
            File homeDir = new File(userHome);
            chooser = new JFileChooser(homeDir);
        } else {
            chooser = new JFileChooser();
        }

        FileNameExtensionFilter filter = new FileNameExtensionFilter(
                "JPG or PNG Images", "jpg", "png");
        chooser.setFileFilter(filter);

        int returnVal = chooser.showSaveDialog(null);
        if (returnVal == JFileChooser.APPROVE_OPTION) {
            File selectedFile = chooser.getSelectedFile();

            String extension = getExtension(selectedFile);
            System.out.println(extension);
            try {
                BufferedImage image = ImageIO.read(new URL(imageUrl));
                ImageIO.write(image, extension, selectedFile);
                return true;
            } catch (IOException e) {
                System.out.println(e);
                return false;
            }
            
        }

        return true;

    }

    public String getExtension(File file) {
            String filename = file.getName();
            int pos = filename.lastIndexOf('.') + 1;
            String extension = filename.substring(pos).toLowerCase();
            return extension;
    }
}
