Class {
	#name : 'WolframHanseiTestCase',
	#superclass : 'WolframTestCase',
	#traits : 'THanseiTestCase',
	#classTraits : 'THanseiTestCase classTrait',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'tests' }
WolframHanseiTestCase >> testDrunkCoinModel [

	| tree values pair dl dp |
	dl := link symbol: #l.
	dp := link symbol: #d.

	tree := [ self drunkCoin: 10 drunkProb: dp lostProb: dl ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) asMathematicaPrintString
		equals: 'Times[Power[d, 10], Power[Plus[-1, l], 10]]'.

	self
		assert: (values at: false) asMathematicaPrintString
		equals:
		'Times[Plus[-1, d], Plus[-1, l], Plus[1, Times[d, Plus[-1, l], Plus[-1, Times[d, Plus[-1, l], Plus[1, Times[d, Plus[-1, l], Plus[-1, Times[d, Plus[-1, l], Plus[1, Times[d, Plus[-1, l], Plus[-1, Times[d, Plus[-1, l], Plus[1, Times[d, Plus[-1, l], Plus[-1, Times[d, Plus[-1, l], Plus[1, d, Times[-1, d, l]]]]]]]]]]]]]]]]]]]'.

	self assert: pair second size equals: 0
]

{ #category : 'tests' }
WolframHanseiTestCase >> testGrassModel [

	| tree values pair r s g f u tot |
	r := link symbol: #r.
	s := link symbol: #s.
	g := link symbol: #g.
	f := link symbol: #f.
	u := link symbol: #u.

	tree := [
	        self
		        grassModelPriorRain: r
		        rain: g
		        priorSprinkler: s
		        sprinkler: f
		        otherwise: u ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) simplify asString
		equals: 'r (g (-1 + f s) (-1 + u) + u + f (s - s u))'.

	self
		assert: (values at: false) simplify asString
		equals: '(-1 + r) (f s (-1 + u) - u)'.

	self assert: pair second size equals: 0.

	tot := ((values at: true) + (values at: false)) simplify.

	self
		exportSlotsGraphOf: ((values at: true) / tot) factor
		pathSuffix: 'true'.

	self
		exportSlotsGraphOf: ((values at: false) / tot) factor
		pathSuffix: 'false'
]
