Extension { #name : 'CTSlotDescriptorsVisitor' }

{ #category : '*Wolfram' }
CTSlotDescriptorsVisitor >> visitWolframExpression: expr [

	^ {"
		  (self newSlotDescriptorSelector: #head).
		  (self newSlotDescriptorSelector: #arguments).
		  (self newSlotDescriptorSelector: #asMathematicaPrintString).
		  ((self newSlotDescriptorSelector: #asTeXifiedShape)
			   inline;
			   quote)" }
]

{ #category : '*Wolfram' }
CTSlotDescriptorsVisitor >> visitWolframLink: link [

	^ {
		  (self newSlotDescriptorSelector: #name).
		  (self newSlotDescriptorSelector: #handler) }
]
