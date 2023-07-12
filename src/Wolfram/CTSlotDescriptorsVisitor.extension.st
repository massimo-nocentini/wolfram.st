Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Wolfram' }
CTSlotDescriptorsVisitor >> visitWolframExpression: expr [

	^ (self visitObject: expr)
	  , { (self newSlotDescriptorSelector: #fullPangoPrintString) }
]
