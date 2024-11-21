Class {
	#name : 'WolframCoreTestCase',
	#superclass : 'WolframTestCase',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'tests' }
WolframCoreTestCase >> testBinomial [

	| y z x p dist |
	x := #x asWolframExpression: link.
	y := #y asWolframExpression: link.
	z := #z asWolframExpression: link.
	p := #p asWolframExpression: link.

	dist := {
		        x.
		        y.
		        z } binomial: p asWolframExpression: link.

	self assert: (dist at: x) equals: 3 * (p - 1 ** 2) * p.
	self assert: (dist at: y) equals: -3 * (p - 1) * (p ** 2).
	self assert: (dist at: z) equals: p ** 3.

	^ dist
]

{ #category : 'tests' }
WolframCoreTestCase >> testFactor [

	| x factored |
	x := #x asWolframExpression: link.

	factored := (x ** 6 - 1) factor.

	self
		assert: factored
		equals:
		(x - 1 * (x + 1) * (1 - x + (x ** 2)) * (1 + x + (x ** 2))) factor.

	^ factored
]

{ #category : 'tests' }
WolframCoreTestCase >> testSymbol [

	| expr x |
	x := #x.
	expr := x asWolframExpression: link.

	self
		assert: expr head equals: 'Symbol';
		assert: expr arguments size equals: 1;
		assert: expr arguments first equals: x;
		assert: expr value equals: expr
]
