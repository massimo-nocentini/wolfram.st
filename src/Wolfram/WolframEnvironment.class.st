Class {
	#name : #WolframEnvironment,
	#superclass : #WolframHandleHolder,
	#category : #Wolfram
}

{ #category : #'as yet unclassified' }
WolframEnvironment class >> fresh [

	^ self basicNew
		  handler: self wsenv;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframEnvironment class >> wsdeinitialize: handler [

	^ self
		  ffiCall: #( void WSDeinitialize #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframEnvironment class >> wsenv [

	^ self
		  ffiCall: #( void #* WSInitialize #( NULL ) )
		  module: WolframLibrary
]

{ #category : #'instance creation' }
WolframEnvironment >> newLinkOpenString [

	^ self newLinkOpenString:
		  '-linkmode launch -linkname ''/usr/local/Wolfram/WolframEngine/13.2/Executables/wolfram -wstp -noprompt -noicon'''
]

{ #category : #'instance creation' }
WolframEnvironment >> newLinkOpenString: str [

	^ WolframLink environment: self openString: str
]

{ #category : #'as yet unclassified' }
WolframEnvironment >> releaseHandler [

	self class wsdeinitialize: self handler
]
