Class {
	#name : 'WolframCoreTestCase',
	#superclass : 'WolframTestCase',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

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
