CoupledResonator : PureUGen  {
	*ar { arg displacement1 = 0.5, displacement2 = -0.5, velocity1 = 0.0, velocity2 = 0.0, acceleration1 = 0.0, acceleration2 = 0.0, forceSpring1 = 0.0, forceSpring2 = 0.0, forceSpring3 = 0.0, mass1 = 1.0, mass2 = 1.0, b1 = 1.0, b2 = 1.0, b3 = 1.0, outputChoice = 0, mul = 1.0, add = 0.0;
		^this.multiNew('audio', displacement1, displacement2, velocity1, velocity2, acceleration1, acceleration2, forceSpring1, forceSpring2, forceSpring3, mass1, mass2, b1, b2, b3, outputChoice).madd(mul, add)
	}
	*kr { arg displacement1 = 0.5, displacement2 = -0.5, velocity1 = 0.0, velocity2 = 0.0, acceleration1 = 0.0, acceleration2 = 0.0, forceSpring1 = 0.0, forceSpring2 = 0.0, forceSpring3 = 0.0, mass1 = 1.0, mass2 = 1.0, b1 = 1.0, b2 = 1.0, b3 = 1.0, outputChoice = 0, mul = 1.0, add = 0.0;
		^this.multiNew('control', displacement1, displacement2, velocity1, velocity2, acceleration1, acceleration2, forceSpring1, forceSpring2, forceSpring3, mass1, mass2, b1, b2, b3, outputChoice).madd(mul, add)
	}
}

