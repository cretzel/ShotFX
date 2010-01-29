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
import javafx.scene.shape.Rectangle;
import javafx.scene.Group;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.effect.Lighting;
import javafx.scene.effect.light.DistantLight;
import javafx.scene.effect.Bloom;

/**
 * @author cretzel
 */
public class ShotFxButton extends CustomNode {

    public var label : String;
    public var action: function() : Void;
    public var enabled: Boolean = true;
    
    override function create() : Group {
        
        var glowLevel = 1.0;
        var glow = Bloom {
            threshold: bind glowLevel
        }
        var surfaceScale = 5;

        var rect: Rectangle;
        var text = Text {
            content: bind label
            translateX: 15
            translateY: 18 + 6
            fill: Color.WHITE
            font: Font {
                size: 18
            }
        }


        Group {
            onMousePressed: function(e: MouseEvent) {
                surfaceScale = 1;
            }

            onMouseReleased: function(e: MouseEvent) {
                surfaceScale = 5;
            }

            onMouseClicked: function(e: MouseEvent) {
                if (enabled) {
                    action();
                }

            }

            onMouseEntered: function(e: MouseEvent) {
                if (enabled) {
                    glowLevel = 0.95;
                } else {
                    glowLevel = 1.0;
                }

            }

            onMouseExited: function(e: MouseEvent) {
                glowLevel = 1.0;
            }

            effect: glow
            content: [
                rect = Rectangle {
                    width: text.boundsInLocal.width + 30
                    height: text.font.size + 18
                    fill: bind if (not enabled) Color.GRAY else Color.RED
                    stroke: Color.BLACK
                    arcWidth: 36
                    arcHeight: 36
                    effect: Lighting {
                        light: DistantLight {
                            azimuth: 45
                            elevation: 135
                        }
                        surfaceScale: bind surfaceScale
                    }

                },
                text


            ]
        }

    }

}
