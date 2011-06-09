package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;

import spark.components.HSlider;
import spark.components.Label;
import spark.components.NumericStepper;
import spark.layouts.HorizontalLayout;

public class SliderEditor extends LabeledEditor {
    public function SliderEditor(element:*, property:Property) {
        super(property.displayName);
        //setupLayout();
        var slider:HSlider = addSlider(property, element);
        if (property.maxValue - property.minValue > 1) {
            addStepper(property, slider);
        } else {
            addValueLabel(slider);
        }
    }

    private function addValueLabel(slider:HSlider):void {
        var valueLabel:Label = new Label();
        valueLabel.text = slider.value.toString();
        valueLabel.right = 0;
        valueLabel.verticalCenter = 0;
        BindingUtils.bindProperty(valueLabel, "text", slider, "value");
        content.addElement(valueLabel);
    }

    private function addStepper(property:Property, slider:HSlider):void {
        var stepper:NumericStepper = new NumericStepper();
        stepper.maximum = property.maxValue;
        stepper.value = slider.value;
        stepper.right = 0;
        stepper.verticalCenter = 0;

        BindingUtils.bindProperty(stepper, "value", slider, "value");
        BindingUtils.bindProperty(slider, "value", stepper, "value");

        content.addElement(stepper);
    }

    private function addSlider(property:Property, element:*):HSlider {
        var slider:HSlider = new HSlider();
        slider.minimum = property.minValue;
        slider.maximum = property.maxValue;
        slider.stepSize = 0.01;
        slider.value = element[property.name];
        slider.left = 0;
        slider.verticalCenter = 0;

        BindingUtils.bindProperty(element, property.name, slider, "value");
        content.addElement(slider);
        return slider;
    }

    private function setupLayout():void {
        var layout:HorizontalLayout = new HorizontalLayout();
        layout.verticalAlign = "middle";

        content.layout = layout;
    }
}
}