Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Wolfram' }
CTSlotDescriptorsVisitor >> visitWolframExpression: expr [

	^ {
		  (self newSlotDescriptorSelector: #head).
		  (self newSlotDescriptorSelector: #arguments).
		  (self newSlotDescriptorSelector: #fullPangoPrintString).
		  ((self newSlotDescriptorSelector: #asPdfShape)
			   inline;
			   quote) }
]
