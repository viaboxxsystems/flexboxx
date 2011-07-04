package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;
import de.viaboxx.flexboxx.editors.PropertyEditor;

import flash.events.MouseEvent;

import mx.binding.utils.BindingUtils;
import mx.controls.ColorPicker;
import mx.graphics.GradientEntry;
import mx.graphics.LinearGradient;

import spark.components.Button;
import spark.components.HSlider;
import spark.components.Label;
import spark.components.VGroup;
import spark.primitives.Rect;

public class GradientEditor extends PropertyEditor {
    public function GradientEditor(element:*, property:Property, changeHandler:Function = null) {
        var label:Label = new Label();
        label.text = property.name;
        var overviewRect:Rect = new Rect();
        overviewRect.width = 100;
        overviewRect.height = 10;

        var gradientFill:LinearGradient = new LinearGradient();
        gradientFill.entries = [];
        overviewRect.fill = gradientFill;
        addElement(overviewRect);

        var addGradientEntryButton:Button = new Button();
        addGradientEntryButton.label = "+";
        var controlsGroup:VGroup = new VGroup();
        addElement(controlsGroup);

        function clearControlsGroup():void {
            controlsGroup.removeAllElements();
        }

        function addControls(entries:Array):void {
            entries.forEach(function(item:GradientEntry, index:int, array:Array):void {
                var label:Label = new Label();
                label.text = "Entry:";
                controlsGroup.addElement(label);
                var colorChooser:ColorPicker = new ColorPicker();
                colorChooser.selectedColor = item.color;
                BindingUtils.bindProperty(item, "color", colorChooser, "selectedColor");
                controlsGroup.addElement(colorChooser);
                var alphaSlider:HSlider = new HSlider();
                alphaSlider.value = item.alpha;
                alphaSlider.minimum = 0;
                alphaSlider.maximum = 1;
                alphaSlider.stepSize = .01;
                BindingUtils.bindProperty(item, "alpha", alphaSlider, "value");
                controlsGroup.addElement(alphaSlider);
                var removeButton:Button = new Button();
                removeButton.label = "-";
                removeButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
                    var newGradients:Array = gradientFill.entries.filter(function(entry:GradientEntry, ...rest):Boolean {
                        return entry != item;
                    });
                    gradientFill.entries = newGradients;
                    element[property.name] = gradientFill.entries;
                    clearControlsGroup();
                    addControls(newGradients);
                });

                var ratioLabel:Label = new Label();
                ratioLabel.text = item.ratio.toString();
                BindingUtils.bindProperty(ratioLabel, "text", item, "ratio");
                var ratioSlider:HSlider = new HSlider();
                ratioSlider.minimum = 0;
                ratioSlider.maximum = 1;
                ratioSlider.stepSize = .01;
                ratioSlider.value = item.ratio;
                BindingUtils.bindProperty(item, "ratio", ratioSlider, "value");
                controlsGroup.addElement(ratioSlider);
                controlsGroup.addElement(ratioLabel);
                controlsGroup.addElement(removeButton);
            });
        }

        addGradientEntryButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
            var newGradients:Array = [new GradientEntry(0xFF0000, 1)].concat(gradientFill.entries);
            overviewRect.invalidateProperties();
            newGradients = newGradients.sort(function(a:GradientEntry, b:GradientEntry):int {
                return b.ratio - a.ratio;
            });
            gradientFill.entries = newGradients;
            element[property.name] = gradientFill.entries;
            clearControlsGroup();
            addControls(newGradients);
        });

        addElement(addGradientEntryButton);
    }
}
}