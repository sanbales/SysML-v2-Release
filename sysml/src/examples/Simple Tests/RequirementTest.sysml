package RequirementTest {
	constraint def C;
	constraint c : C;
	requirement def R {
		assume constraint c1 : C;
		require c;
		doc /* */
    	requirement;
    	requirement def id '1' A {
    		doc /* Text */
    		subject s;
    	}
	}
	requirement def R1 {
		require constraint c1 :>> c;
	}
	part p;
	part q {
		requirement r : R;
		satisfy r by p;
	}
}