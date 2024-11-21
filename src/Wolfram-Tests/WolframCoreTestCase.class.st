Class {
	#name : 'WolframCoreTestCase',
	#superclass : 'WolframTestCase',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'tests' }
WolframCoreTestCase >> testBinomial [

	| y z x p bin |
	x := #x asWolframExpression: link.
	y := #y asWolframExpression: link.
	z := #z asWolframExpression: link.
	p := #p asWolframExpression: link.

	bin := {
		       x.
		       y.
		       z } binomial: p asWolframExpression: link.

	^ bin
]

{ #category : 'tests' }
WolframCoreTestCase >> testFactor [

	| x |
	x := #x asWolframExpression: link.

	self
		assert: (x ** 6 - 1) factor
		equals:
		(x - 1 * (x + 1) * (1 - x + (x ** 2)) * (1 + x + (x ** 2))) factor
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
