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

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.effect.Lighting;
import javafx.scene.effect.light.DistantLight;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Screen;
import javafx.stage.Stage;
import java.lang.String;
import com.kenai.shotfx.Screenshooter;
import com.kenai.shotfx.ShotFxButton;
import com.kenai.shotfx.imagesaver.ImageSaver;
import javafx.scene.effect.Reflection;

/**
 * @author cretzel
 */

def robot = new Screenshooter();
def imageSaver = new ImageSaver();

var imageUrl : String;
var stageOpacity = 1.0;

var scene : Scene;
var captureX : Integer;
var captureY : Integer;
var captureWidth : Integer;
var captureHeight : Integer;

var selectionStage : Stage;

/**
* Creates secondary window to capture a rectangular area of the screen.
*/
function createSelectionStage() : Stage {

    var scene: Scene;

    def button : ShotFxButton = ShotFxButton {
        label: "Capture"
        translateX: bind scene.width/2 - button.boundsInLocal.width/2;
        translateY: bind scene.height/2 - button.boundsInLocal.height/2;
        action: function() {
            captureX = selectionStage.x as Integer;
            captureY = selectionStage.y as Integer;
            captureWidth = selectionStage.width as Integer;
            captureHeight = selectionStage.height as Integer;
            selectionStage.close();
            shotTimeline.playFromStart();
        }
        effect: Reflection {
            fraction: 0.9
        }

    }

    Stage {
        title: "Select"
        width: 400
        height: 400
        visible: false
        opacity: bind stageOpacity
        scene: scene = Scene {
            content: [
                Rectangle {
                    width: bind scene.width
                    height: bind scene.height
                    effect: Lighting {
                        light: DistantLight {
                            azimuth: 45
                            elevation: 135
                        }
                        surfaceScale: 5
                    }
                    fill: Color.BLACK
                },
                button
            ]
        }
    }
}

/** 
* Takes a screen shot of the screen. First makes stages
* transparent, then captures.
*/
def shotTimeline = Timeline {
	keyFrames: [
        KeyFrame {
            time: 0s
            action: function() {
                stageOpacity = 0.0;
            }
        },

        KeyFrame {
            time: 50ms
            action: function() {
                imageUrl = robot.screenshot(captureX, captureY, captureWidth, captureHeight).toString();
            }
        },

        KeyFrame {
            time: 100ms
            action: function() {
                selectionStage.close();
                stageOpacity = 1.0;
            }
        }
	]
}


def shotButton = ShotFxButton {
    label: "Select Area"
    action: function() {
        selectionStage = createSelectionStage();
        selectionStage.visible = true;
    }
}

def fullScreenButton = ShotFxButton {
    label: "Full Screen"
    action: function() {
        captureX = Screen.primary.visualBounds.minX as Integer;
        captureY = Screen.primary.visualBounds.minY as Integer;
        captureWidth = Screen.primary.visualBounds.width as Integer;
        captureHeight = Screen.primary.visualBounds.height as Integer;
        shotTimeline.playFromStart();
    }
}

def saveImageButton = ShotFxButton {
    label: "Save"
    action: function() {
        imageSaver.saveImage(imageUrl);
    }
    enabled: bind imageUrl != null
}

def clearImageButton = ShotFxButton {
    label: "Clear"
    action: function() {
        imageUrl = null;
    }
    enabled: bind imageUrl != null
}


def controlGroupHeight = 60.0;

def controlGroup = Group {
    translateX: -10
    translateY: bind scene.height - controlGroupHeight
    content: [

        Rectangle {
            width: bind scene.width + 20
            height: bind controlGroupHeight + 10
            effect: Lighting {
                light: DistantLight {
                    azimuth: 45
                    elevation: 135
                }
                surfaceScale: 5
            }
            fill: Color.BLACK
        },

        HBox {
            translateX: 20
            translateY: 10
            spacing: 10
            content: [
                fullScreenButton,
                shotButton,
                saveImageButton,
                clearImageButton
            ]
        }

    ]
}

function run() {

Stage {
    title: "ShotFX"
    width: 500
    height: 500
    opacity: bind stageOpacity;
    onClose: function() {
        selectionStage.close();
    }
    scene: scene = Scene {
        content: [
            Rectangle {
                width: bind scene.width
                height: bind scene.height - controlGroupHeight + 5
                fill: Color.BLACK
            },

            ShotFxImageView {
                imageUrl: bind imageUrl
                width: bind scene.width - 20
                height: bind scene.height - controlGroupHeight - 20
                translateX: 10
                translateY: 10
            },
            controlGroup
	    ]
    }

}


}