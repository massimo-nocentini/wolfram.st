Class {
	#name : 'WolframSimpleTest',
	#superclass : 'TestCase',
	#instVars : [
		'link'
	],
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'running' }
WolframSimpleTest >> setUp [

	super setUp.

	link := WolframEngine newLink
]

{ #category : 'running' }
WolframSimpleTest >> tearDown [

	link releaseHandler.
	super tearDown
]

{ #category : 'tests' }
WolframSimpleTest >> testBernoulli [

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
