package test.unitTest{
    import asunit.framework.TestSuite;
    public class AllTests extends TestSuite{
        public function AllTests(){
            super();
            addTest(new ActionTest("testMoveBy"))
            addTest(new ActionTest("testMoveTo"))
            addTest(new ActionTest("testScaleBy"))
            addTest(new ActionTest("testRotateBy"))
            addTest(new ActionTest("testRotateTo"))
            addTest(new ActionTest("testJumpBy"))
            addTest(new ActionTest("testFadeTo"))
            
        }
    }
}