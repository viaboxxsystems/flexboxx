package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;

import spark.components.Label;
import spark.components.NumericStepper;

public class SpinnerEditor extends PropertyEditor {
    public function SpinnerEditor(element:*, property:Property) {
        var label:Label = new Label(),
                spinner:NumericStepper = new NumericStepper();
        spinner.maximum = property.maxValue;
        label.text = property.name;
        spinner.stepSize = 1;
        spinner.value = element[property.name];
        BindingUtils.bindProperty(element, property.name, spinner, "value");
        addElement(label);
        addElement(spinner);
    }
}
}