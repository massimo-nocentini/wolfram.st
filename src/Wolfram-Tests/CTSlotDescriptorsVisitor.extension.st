Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Wolfram-Tests' }
CTSlotDescriptorsVisitor >> visitTestCaseExecution: exec [

	^ {
		  (self newSlotDescriptorSelector: #compiledMethod).
		  (self newSlotDescriptorSelector: #evaluate) }
]
