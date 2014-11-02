// Spectrum Analyzer
(
~openAnalyzer = {
var window, func;
window = Window("Analyzer", Rect(600, 30, 511, 300)); // width should be 511
func = FreqScopeView(window, window.view.bounds);
func.active_(true); // turn it on the first time;
func.freqMode_(1); //log scale
window.onClose_({ func.kill }); // you must have this
window.front;
}.value
)

(
SynthDef(\coupledResonatorTest,
	{arg displacement1 = 0.2,
		displacement2 = -0.2,
		velocity1 = 0.0,
		velocity2 = 0.0,
		acceleration1 = 0.0,
		acceleration2 = 0.0,
		forceSpring1 = 0.0,
		forceSpring2 = 0.0,
		forceSpring3 = 0.0,
		mass1Milligram = 1.0,
		mass2Milligram = 1.0,
		b1 = 1.0,
		b2 = 1.0,
		b3 = 1.0,
		outputChoice = 0, // 0=displacement1, 1=displacement2, 2=velocity1, 3=velocity2, 4=acceleration1, 5=acceleration2
		mul = 1.0,
		add = 0;
		var sound = CoupledResonator.ar(displacement1, displacement2, velocity1, velocity2, acceleration1, acceleration2, forceSpring1, forceSpring2, forceSpring3, mass1Milligram*0.000001, mass2Milligram*0.000001, b1, b2, b3, outputChoice, mul, add).scope;
		Out.ar(0, sound);
}).load
)

~test1=Synth(\coupledResonatorTest)
~test1.set(\mass1, 1)
~test1.set(\b1, 0.1)
~test1.set(\b2, 0.2)
~test1.set(\b3, 0.3)
~test1.set(\mul, 1)
~test1.set(\outputChoice, 0, \mul, 1.0) // displacement1
~test1.set(\outputChoice, 1, \mul, 1.0) // displacement2
~test1.set(\outputChoice, 2, \mul, 0.001) // velocity1
~test1.set(\outputChoice, 3, \mul, 0.001) // velocity2
~test1.set(\outputChoice, 4, \mul, 0.000001) // acceleration1
~test1.set(\outputChoice, 5, \mul, 0.000001) // acceleration2



(
var window, sound, sl1, sl2, sl3, sl4, sl5, sl6, sl7, sl8, sl9, sl10, sl11, sl12, sl13, sl14, sl15, sl16;
window = Window("Coupled Resonator", Rect(100,420,620,500));
window.view.decorator = FlowLayout(window.view.bounds);
StaticText(window,620 @ 40).string_("Coupled Resonator").align_(\center)
	.font_(Font("Helvetica", 16));
window.view.decorator.nextLine;
sl1 = EZSlider(window, 600 @ 20, "Init displacement1", ControlSpec(-1.0,1.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl2 = EZSlider(window, 600 @ 20, "Init displacement2", ControlSpec(-1.0,1.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl3 = EZSlider(window, 600 @ 20, "Init velocity1", ControlSpec(-1000.0,1000.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl4 = EZSlider(window, 600 @ 20, "Init velocity2", ControlSpec(-1000.0,1000.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl5 = EZSlider(window, 600 @ 20, "Init acceleration1", ControlSpec(-100000.0,100000.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl6 = EZSlider(window, 600 @ 20, "Init acceleration2", ControlSpec(-100000.0,100000.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl7 = EZSlider(window, 600 @ 20, "Init force1", ControlSpec(-1.0,1.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl8 = EZSlider(window, 600 @ 20, "Init force2", ControlSpec(-1.0,1.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl9 = EZSlider(window, 600 @ 20, "Init force3", ControlSpec(-1.0,1.0,default: 0.0),
	labelWidth: 140);
window.view.decorator.nextLine;
sl10 = EZSlider(window, 600 @ 20, "mass1 in milligram", ControlSpec(0.1,100,\exponential, default: 1.0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\mass1Milligram, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl11 = EZSlider(window, 600 @ 20, "mass2 in milligram", ControlSpec(0.1,100,\exponential, default: 1.0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\mass2Milligram, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl12 = EZSlider(window, 600 @ 20, "b1", ControlSpec(0.01,100.0,\exponential, default: 1.0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\b1, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl13 = EZSlider(window, 600 @ 20, "b2", ControlSpec(0.01,100.0,\exponential, default: 1.0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\b2, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl14 = EZSlider(window, 600 @ 20, "b3", ControlSpec(0.01,100.0,\exponential, default: 1.0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\b3, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl15 = EZSlider(window, 600 @ 20, "output choice", ControlSpec(0,1,step: 1,default: 0),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\outputChoice, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.nextLine;
sl16 = EZSlider(window, 600 @ 20, "Amp", ControlSpec(0,1.0,\amp,default: 0.5),
	 	{| view | if (sound.notNil)
	 			   { sound.set(\mul, view.value)}
	 	},
	labelWidth: 140);
window.view.decorator.left_(400).top_(450);
Button(window, 40@40)
	.states_([["Start"], ["Stop", Color.black, Color.red(alpha: 0.2)]])
	.action_({|view|  if (view.value ==1 && sound.isNil,
	{sound =
		Synth(\coupledResonatorTest,
			[\displacement1,sl1.value,
				\displacement2,sl2.value,
				\velocity1,sl3.value,
				\velocity2,sl4.value,
				\acceleration1,sl5.value,
				\acceleration2,sl6.value,
				\forceSpring1,sl7.value,
				\forceSpring2,sl8.value,
				\forceSpring3,sl9.value,
				\mass1,sl10.value,
				\mass2,sl11.value,
				\b1,sl12.value,
				\b2,sl13.value,
				\b3,sl14.value,
				\outputChoice,sl15.value,// 0=displacement1, 1=displacement2, 2=velocity1, 3=velocity2, 4=acceleration1, 5=acceleration2
				\mul,sl16.value])},
	{sound.free; sound = nil }
	)
});
window.front;
)



	(
SynthDef(\fmWithCoupledResonator,
	{arg displacement1 = 0.5,
		displacement2 = -0.5,
		velocity1 = 0.0,
		velocity2 = 0.0,
		acceleration1 = 0.0,
		acceleration2 = 0.0,
		forceSpring1 = 0.0,
		forceSpring2 = 0.0,
		forceSpring3 = 0.0,
		mass1 = 0.0001,
		mass2 = 0.0001,
		b1 = 1.0,
		b2 = 1.0,
		b3 = 1.0,
		mul = 100,
		add = 400;
		var sound = SinOsc.ar(CoupledResonator.ar(displacement1, displacement2, velocity1, velocity2, acceleration1, acceleration2, forceSpring1, forceSpring2, forceSpring3, mass1, mass2, b1, b2, b3, mul, add), mul:0.1).scope;
		Out.ar(0, sound);
}).load
)

a=Synth(\fmWithCoupledResonator)
a.set(\mass1, 0.00001)
a.set(\mass1, 0.01)
a.set(\mass1, 0.1)
a.set(\mass2, 0.03)
a.set(\mass2, 0.3)
a.set(\mass2, 30)
a.set(\b1, 0.01)
a.set(\b1, 20)
a.set(\b2, 0.03)
a.set(\b2, 30)
a.set(\b3, 0.07)
a.set(\b3, 70)
a.set(\mul, 20)
a.set(\add, 2000)