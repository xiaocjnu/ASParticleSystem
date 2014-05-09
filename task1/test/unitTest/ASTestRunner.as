package test.unitTest{
	import asunit.textui.TestRunner;
	
	public class ASTestRunner extends TestRunner{
		public function ASTestRunner() {
			start(AllTests, null, TestRunner.SHOW_TRACE)
		}
	}
}