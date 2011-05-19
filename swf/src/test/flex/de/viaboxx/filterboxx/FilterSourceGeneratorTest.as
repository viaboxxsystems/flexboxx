package de.viaboxx.filterboxx {
import org.flexunit.assertThat;
import org.hamcrest.object.equalTo;

import spark.filters.DropShadowFilter;

public class FilterSourceGeneratorTest {

    public function FilterSourceGeneratorTest() {
        //empty constructor
    }

    [Test]
    public function generateRootTag():void {
        var result:String = rootXMLForFilterDescription(FilterDescription.forFilter(new DropShadowFilter()));
        var expected:String = "<s:DropShadowFilter/>";
        assertThat(result, equalTo(expected));
    }

    private function rootXMLForFilterDescription(filterDescription:FilterDescription):String {
        return "<s:"+filterDescription.className+"/>";
    }
}
}