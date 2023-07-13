Extension { #name : #String }

{ #category : #'*Wolfram' }
String >> asWolframArbitraryPrecisionNumber [

	^ WolframArbitraryPrecisionFloat new
		  definition: self;
		  yourself
]

{ #category : #'*Wolfram' }
String >> putOnLink: link [

	link putString: self
]
