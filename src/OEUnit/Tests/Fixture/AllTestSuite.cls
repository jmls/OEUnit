ROUTINE-LEVEL ON ERROR UNDO, THROW.

USING OEUnit.Runner.TestSuite.
USING OEUnit.Tests.Fixture.*.

CLASS OEUnit.Tests.Fixture.AllTestSuite INHERITS TestSuite:
  
  CONSTRUCTOR AllTestSuite():
    AddTest(NEW FixtureTest()).
  END CONSTRUCTOR.

END CLASS.