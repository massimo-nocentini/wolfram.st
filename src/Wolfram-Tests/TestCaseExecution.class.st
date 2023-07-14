Class {
	#name : #TestCaseExecution,
	#superclass : #Object,
	#instVars : [
		'compiledMethod',
		'receiver'
	],
	#category : #'Wolfram-Tests'
}

{ #category : #visiting }
TestCaseExecution >> acceptSlotDescriptorsVisitor: visitor [

	^ visitor visitTestCaseExecution: self
]

{ #category : #accessing }
TestCaseExecution >> compiledMethod [

	^ compiledMethod
]

{ #category : #accessing }
TestCaseExecution >> compiledMethod: anObject [

	compiledMethod := anObject
]

{ #category : #'public access' }
TestCaseExecution >> evaluate [

	^ self compiledMethod valueWithReceiver: self receiver
]

{ #category : #accessing }
TestCaseExecution >> receiver [

	^ receiver
]

{ #category : #accessing }
TestCaseExecution >> receiver: anObject [

	receiver := anObject
]
