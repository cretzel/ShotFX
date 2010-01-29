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

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.animation.Interpolator;
import javafx.animation.Timeline;
import javafx.scene.image.ImageView;
import javafx.scene.layout.ClipView;
import javafx.scene.image.Image;
import javafx.scene.transform.Scale;
import javafx.scene.effect.Reflection;

/**
 * @author cretzel
 */
public class ShotFxImageView extends CustomNode {

    public var imageUrl : String;
    public var width : Number;
    public var height : Number;
    
    var scale : Number = 1.0;

    override function create() : Node {

        var scaleTransform = Scale {
            pivotX: 0
            pivotY: 0
            x: bind scale;
            y: bind scale;
        }

        var imageView = ImageView {
            image: bind Image {url: imageUrl}
            transforms: [scaleTransform]

            // Scaling
            onMouseClicked: function(e) {

                // Resulting size
                var result = scale;
                if (e.controlDown) {
                    result *= if (scale > 0.0) 0.8 else 1.0;
                } else {
                    result *= 1.2;
                }

                // Animation
                Timeline {
                    keyFrames: [
                        at(600ms) {scale => result tween Interpolator.EASEOUT}
                    ]
                }.play();

            }
        }

        // Clipping and panning
        def clipView= ClipView {
            pannable: true;
            width: bind width
            height: bind height
            node: imageView
        }

    }


}
