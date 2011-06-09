package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;

import spark.components.NumericStepper;

public class SpinnerEditor extends LabeledEditor {
    public function SpinnerEditor(element:*, property:Property) {
        super(property.displayName);
        rightAlignContent();

        var spinner:NumericStepper = new NumericStepper();
        spinner.maximum = property.maxValue;
        spinner.stepSize = 1;
        spinner.value = element[property.name];
        BindingUtils.bindProperty(element, property.name, spinner, "value");
        
        content.addElement(spinner);
    }
}
}