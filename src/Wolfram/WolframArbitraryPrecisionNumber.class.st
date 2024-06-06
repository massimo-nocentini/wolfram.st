Class {
	#name : 'WolframArbitraryPrecisionNumber',
	#superclass : 'WolframExpression',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframArbitraryPrecisionNumber >> asTeXifiedShape [

	| texContent texChunk shape |
	texChunk := link
		            endPacket;
		            flush;
		            evaluate.

	texContent := self withStandaloneLaTeXStreamDo: [ :aStream |
		              aStream << texChunk ].

	shape := (PopplerPdf compileTeX: texContent times: 1) pages
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : 'evaluating' }
WolframArbitraryPrecisionNumber >> putOnLink: alink [

	self subclassResponsibility
]
