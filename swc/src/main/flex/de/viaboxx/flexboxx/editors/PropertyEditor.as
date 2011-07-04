package de.viaboxx.flexboxx.editors {
import mx.binding.utils.BindingUtils;
import mx.binding.utils.ChangeWatcher;
import mx.graphics.SolidColorStroke;

import spark.components.Group;
import spark.primitives.Rect;

public class PropertyEditor extends Group {

    protected var content:Group = new Group();

    public function PropertyEditor() {
        percentWidth = 100;
        addElement(content);
        var rect:Rect = new Rect();
        rect.stroke = new SolidColorStroke(0x333333, 1, 0.3);
        rect.percentWidth = 100;
        rect.top = 0;
        addElement(rect);
    }

    protected function bindProperty(element, elementProperty, editor, editorProperty,
                                    changeHandler:Function = null):void {
        editor[editorProperty] = element[elementProperty];
        BindingUtils.bindProperty(element, elementProperty, editor, editorProperty);
        if (changeHandler)
            ChangeWatcher.watch(editor, editorProperty, changeHandler);
    }
}
}