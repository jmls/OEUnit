routine-level on error undo, throw.

using OEUnit.Assertion.*.
using OEUnit.Util.*.

class OEUnit.Tests.Fixture.FixtureTest:

  @Test.
  method public void load():
    def var lv_data as longchar no-undo.
    
    assign lv_data = Fixture:Load(this-object,"employee.json").
    
    AssertString:IsNotNullOrEmpty(lv_data).

    assign lv_data = Fixture:Load(this-object,"foobar.json") no-error.
    
    Assert:didError().
  end method.

end class.