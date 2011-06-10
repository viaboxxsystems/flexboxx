package de.viaboxx.flexboxx {
import org.flexunit.assertThat;
import org.hamcrest.object.equalTo;

[RunWith("org.flexunit.runners.Parameterized")]
public class FormatHexTest {
    public function FormatHexTest() {
        //empty constructor
    }

    public static function colors():Array {
        return [
            [0, "0x000000"],
            [0xFF0000, "0xFF0000"],
            [0xFF2300, "0xFF2300"],
            [0x000001, "0x000001"],
            [0x0000FF, "0x0000FF"]
        ];
    }

    [Test(dataProvider="colors")]
    public function colorString(color:uint, expected:String):void {
        assertThat(formatHex(color), equalTo(expected));
    }
}
}