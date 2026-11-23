"
I am a real number that `WolframLink` reads from the kernel. My first argument is put on a link with `putArbitraryPrecisionNumber:`.
"
Class {
	#name : 'WolframArbitraryPrecisionReal',
	#superclass : 'WolframArbitraryPrecisionNumber',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframArbitraryPrecisionReal >> asTeXifiedShape [

	link
		putFunction: 'ToString' arity: 1;
		putFunction: 'TeXForm' arity: 1;
		putFunction: 'ScientificForm' arity: 1;
		putExpression: self.

	^ super asTeXifiedShape
]

{ #category : 'evaluating' }
WolframArbitraryPrecisionReal >> putOnLink: alink [

	alink putArbitraryPrecisionNumber: self arguments first
]
