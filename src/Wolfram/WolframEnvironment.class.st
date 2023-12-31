Class {
	#name : 'WolframEnvironment',
	#superclass : 'WolframHandleHolder',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'instance creation' }
WolframEnvironment >> newLinkOpenString [

	^ self newLinkOpenString:
		  'pharo -linkmode launch -linkname "wolfram -wstp -noprompt -noicon"'
]

{ #category : 'instance creation' }
WolframEnvironment >> newLinkOpenString: str [

	^ WolframLink basicNew
		  handler: (self wsOpenString: str);
		  initialize;
		  yourself
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> releaseHandler [

	^ self
		  ffiCall: #( void WSDeinitialize #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> wsOpenString: str [

	^ self
		  ffiCall:
		  #( void #* WSOpenString #( void #* handler #, const char #* str
		        #, NULL ) )
		  module: WolframLibrary
]
