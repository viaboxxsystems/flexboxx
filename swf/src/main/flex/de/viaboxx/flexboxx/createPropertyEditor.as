package de.viaboxx.flexboxx {
import de.viaboxx.flexboxx.editors.CheckBoxEditor;
import de.viaboxx.flexboxx.editors.ColorEditor;
import de.viaboxx.flexboxx.editors.GradientEditor;
import de.viaboxx.flexboxx.editors.PropertyEditor;
import de.viaboxx.flexboxx.editors.SliderEditor;
import de.viaboxx.flexboxx.editors.SpinnerEditor;

import mx.graphics.GradientEntry;

/**
 * Creates a new PropertyEditor for the given property.
 * @param element The object manipulated using the editor.
 * @param property The property description of the value inside <code>element</code> being edited.
 * @param editorClass Optional editor type to instantiate. Default is null (=type/metadata-based default editor) 
 * @return A PropertyEditor for the given property of <code>element</code>.
 */
public function createPropertyEditor(element:*, property:Property, editorClass:Class = null):PropertyEditor {

    function editorForProperty(property:Property):Class {
        switch (property.dataType) {
            case Boolean:
                return CheckBoxEditor;
            case int:
            //fall-through
            case Number:
                return (property.maxValue) ?  SliderEditor : SpinnerEditor;
            case uint:
                return ColorEditor;
            case Array:
                if (property.arrayType == GradientEntry) {
                    return GradientEditor;
                }
            default:
                return null;
        }
    }

    if (editorClass == null) {
        editorClass = editorForProperty(property);
    }

    return new editorClass(element, property);
}
}