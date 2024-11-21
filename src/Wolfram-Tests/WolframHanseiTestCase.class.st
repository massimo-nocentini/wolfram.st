Class {
	#name : 'WolframHanseiTestCase',
	#superclass : 'WolframTestCase',
	#traits : 'THanseiTestCase',
	#classTraits : 'THanseiTestCase classTrait',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'tests' }
WolframHanseiTestCase >> testBernoulli [

	| tree values pair p |
	p := #p asWolframExpression: link.
	tree := [ true bernoulli: p ] hansei.

	pair := tree inferenceExact asValuesDictionary.
	values := pair first.

	self
		assert: (values at: true) equals: p;
		assert: (values at: false) equals: 1 - p;
		assert: pair second size equals: 0
]

{ #category : 'tests' }
WolframHanseiTestCase >> testCatalanParens [

	| tree avg e p |
	e := #e asWolframExpression: link.
	p := #p asWolframExpression: link.

	tree := [ self catalanParens: e pickProb: p ] hansei.
	avg := (tree inferenceUpToDepth: 10) average.

	self assert: avg size equals: 8.
	self assert: (avg at: '') equals: e.
	self assert: (avg at: '()') equals: e * (1 - e).
	self assert: (avg at: '()(())') equals: e - 1 ** 3 * e * p * (p - 1).

	^ avg
]

{ #category : 'tests' }
WolframHanseiTestCase >> testDrunkCoinModel [

	| tree values pair dl dp |
	dl := #l asWolframExpression: link.
	dp := #d asWolframExpression: link.

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
	r := #r asWolframExpression: link.
	s := #s asWolframExpression: link.
	g := #g asWolframExpression: link.
	f := #f asWolframExpression: link.
	u := #u asWolframExpression: link.

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

{ #category : 'tests' }
WolframHanseiTestCase >> testGrassModelCloud [

	| tree mean r s c u |
	r := #r asWolframExpression: link.
	s := #s asWolframExpression: link.
	c := #c asWolframExpression: link.
	u := #u asWolframExpression: link.

	tree := [
	        self
		        grassModelWithCloud: c
		        rain: r
		        sprinkler: s
		        otherwise: u ] hansei.

	mean := tree inferenceExact mean.

	self
		assert: (mean at: true) simplify asMathematicaPrintString
		equals:
		'Times[Plus[-1, c, r, Times[-2, c, r]], Power[Plus[-1, Times[c, Plus[-1, r, s], Plus[-1, u]], Times[r, Plus[s, Times[-1, s, u]]]], -1]]'.

	self
		assert: (mean at: false) simplify asMathematicaPrintString
		equals:
		'Times[Power[Plus[1, Times[r, s, Plus[-1, u]], Times[-1, c, Plus[-1, r, s], Plus[-1, u]]], -1], Plus[Times[c, Plus[s, u, Times[-1, s, u]]], Times[-1, r, Plus[-1, c, s, Times[c, u], Times[-1, s, u]]]]]'.

	^ mean
]
