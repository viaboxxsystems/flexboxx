package de.viaboxx.filterboxx {
import flash.events.MouseEvent;

import mx.binding.utils.BindingUtils;
import mx.controls.ColorPicker;
import mx.graphics.GradientEntry;
import mx.graphics.LinearGradient;

import spark.components.Button;
import spark.components.CheckBox;
import spark.components.Group;
import spark.components.HGroup;
import spark.components.HSlider;
import spark.components.Label;
import spark.components.Spinner;
import spark.components.VGroup;
import spark.primitives.Rect;

public function createPropertyEditor(element:*, property:FilterProperty):Group {
    var group:HGroup = new HGroup(),
            label:Label = new Label();
    group.gap = 5;
    label.text = property.name;

    function createCheckBoxEditor():void {
        var checkbox:CheckBox = new CheckBox();
        checkbox.label = property.name;
        checkbox.selected = element[property.name];
        BindingUtils.bindProperty(element, property.name, checkbox, "selected");
        group.addElement(checkbox);
    }

    function createSliderEditor():void {
        var slider:HSlider = new HSlider();
        slider.minimum = property.minValue;
        slider.maximum = property.maxValue;
        slider.stepSize = 0.01;
        slider.value = element[property.name];
        BindingUtils.bindProperty(element, property.name, slider, "value");
        group.addElement(label);
        group.addElement(slider);
        if (property.maxValue - property.minValue > 100) {
            var spinner:Spinner = new Spinner();
            spinner.value = slider.value;
            BindingUtils.bindProperty(spinner, "value", slider, "value");
            BindingUtils.bindProperty(slider, "value", spinner, "value");
            group.addElement(spinner);
        }
    }

    function createSpinnerEditor():void {
        var spinner:Spinner = new Spinner();
        spinner.stepSize = 1;
        spinner.value = element[property.name];
        var valueLabel:Label = new Label();
        valueLabel.text = element[property.name];
        BindingUtils.bindProperty(element, property.name, spinner, "value");
        BindingUtils.bindProperty(valueLabel, "text", spinner, "value");
        group.addElement(label);
        group.addElement(valueLabel);
        group.addElement(spinner);
    }

    function createColorEditor():void {
        var colorPicker:ColorPicker = new ColorPicker();
        colorPicker.selectedColor = element[property.name];
        BindingUtils.bindProperty(element, property.name, colorPicker, "selectedColor");
        group.addElement(label);
        group.addElement(colorPicker);
    }

    function createGradientEditor():void {
        var overviewRect:Rect = new Rect();
        overviewRect.width = 100;
        overviewRect.height = 10;

        var gradientFill:LinearGradient = new LinearGradient();
        gradientFill.entries = [];
        overviewRect.fill = gradientFill;
        group.addElement(overviewRect);

        var addGradientEntryButton:Button = new Button();
        addGradientEntryButton.label = "+";
        var controlsGroup:VGroup = new VGroup();
        group.addElement(controlsGroup);

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

        group.addElement(addGradientEntryButton);
    }

    switch (property.dataType) {
        case Boolean:
            createCheckBoxEditor();
            break;
        case int:
        //fall-through
        case Number:
            if (property.maxValue) {
                createSliderEditor();
            } else {
                createSpinnerEditor();
            }
            break;
        case uint:
            createColorEditor();
            break;
        case Array:
            if (property.arrayType == GradientEntry) {
                createGradientEditor();
            }
            break;
        default:
            return null;
    }
    return group;
}
}