package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;
import de.viaboxx.flexboxx.editors.PropertyEditor;

import mx.binding.utils.BindingUtils;

import spark.components.HSlider;
import spark.components.Label;
import spark.components.Spinner;

public class SliderEditor extends PropertyEditor {
    public function SliderEditor(element:*, property:Property) {
        var label:Label = new Label();
        label.text = property.name;
        var slider:HSlider = new HSlider();
        slider.minimum = property.minValue;
        slider.maximum = property.maxValue;
        slider.stepSize = 0.01;
        slider.value = element[property.name];
        BindingUtils.bindProperty(element, property.name, slider, "value");
        addElement(label);
        addElement(slider);
        if (property.maxValue - property.minValue > 100) {
            var spinner:Spinner = new Spinner();
            spinner.value = slider.value;
            BindingUtils.bindProperty(spinner, "value", slider, "value");
            BindingUtils.bindProperty(slider, "value", spinner, "value");
            addElement(spinner);
        }
    }
}
}