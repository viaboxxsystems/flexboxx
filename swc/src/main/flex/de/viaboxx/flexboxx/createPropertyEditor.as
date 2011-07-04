package de.viaboxx.flexboxx {
import de.viaboxx.flexboxx.editors.CheckBoxEditor;
import de.viaboxx.flexboxx.editors.ColorEditor;
import de.viaboxx.flexboxx.editors.GradientEditor;
import de.viaboxx.flexboxx.editors.PropertyEditor;
import de.viaboxx.flexboxx.editors.SliderEditor;
import de.viaboxx.flexboxx.editors.SpinnerEditor;

import flash.events.Event;

import mx.binding.utils.ChangeWatcher;
import mx.graphics.GradientEntry;

/**
 * Creates a new PropertyEditor for the given property.
 * @param element The object manipulated using the editor.
 * @param property The property description of the value inside <code>element</code> being edited.
 * @param changeHandler Optional function to be called when the property changes.
 * @param editorClass Optional editor type to instantiate. Default is null (=type/metadata-based default editor)
 * @return A PropertyEditor for the given property of <code>element</code> or <code>null</code> if no editor
 * could be instantiated.
 */
public function createPropertyEditor(element:*, property:Property, changeHandler:Function = null,
                                     editorClass:Class = null):PropertyEditor {

    function editorForProperty(property:Property):Class {
        switch (property.dataType) {
            case Boolean:
                return CheckBoxEditor;
            case int:
            //fall-through
            case Number:
                return (property.maxValue) ? SliderEditor : SpinnerEditor;
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

    editorClass = editorClass || editorForProperty(property);

    if (editorClass == null) {
        return null;
    }

    return new editorClass(element, property, changeHandler);
}
}
