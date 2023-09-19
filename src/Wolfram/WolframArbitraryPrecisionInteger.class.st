Class {
	#name : 'WolframArbitraryPrecisionInteger',
	#superclass : 'WolframArbitraryPrecisionNumber',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframArbitraryPrecisionInteger >> asTeXifiedShape [

	link
		putFunction: 'ToString' arity: 1;
		putFunction: 'TeXForm' arity: 1;
		putFunction: 'ToExpression' arity: 1;
		putExpression: self arguments first.

	^ super asTeXifiedShape
]

{ #category : 'evaluating' }
WolframArbitraryPrecisionInteger >> putOnLink: alink [

	(alink head: 'FromDigits' arguments: self arguments) putOnLink: alink
]
