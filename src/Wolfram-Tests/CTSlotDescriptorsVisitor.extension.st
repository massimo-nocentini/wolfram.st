Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Wolfram-Tests' }
CTSlotDescriptorsVisitor >> visitTestCaseExecution: exec [

	^ {
		  (self newSlotDescriptorSelector: #compiledMethod) inline.
		  (self newSlotDescriptorSelector: #evaluate) }
]
