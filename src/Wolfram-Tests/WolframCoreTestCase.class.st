Class {
	#name : 'WolframCoreTestCase',
	#superclass : 'WolframTestCase',
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'tests' }
WolframCoreTestCase >> testSymbol [

	| expr |
	expr := #x asWolframExpression: link.

	self assert: expr head equals: 'Symbol'
]
