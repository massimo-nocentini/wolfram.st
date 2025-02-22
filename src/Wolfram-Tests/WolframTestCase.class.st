"
A WolframExpressionTest is a test class for testing the behavior of WolframExpression
"
Class {
	#name : 'WolframTestCase',
	#superclass : 'TestCase',
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#instVars : [
		'environment',
		'link'
	],
	#category : 'Wolfram-Tests',
	#package : 'Wolfram-Tests'
}

{ #category : 'utilities' }
WolframTestCase >> executionOfSelector: selector [

	^ TestCaseExecution new
		  receiver: self;
		  compiledMethod: self class >> selector;
		  yourself
]

{ #category : 'running' }
WolframTestCase >> setUp [

	super setUp.

	environment := WolframEnvironment new.
	link := environment openLink
]

{ #category : 'running' }
WolframTestCase >> tearDown [

	link ifNotNil: [ :l | l releaseHandler ].
	environment ifNotNil: [ :l | l releaseHandler ].

	super tearDown
]
