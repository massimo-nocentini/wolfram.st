Class {
	#name : #WolframLink,
	#superclass : #WolframHandleHolder,
	#category : #Wolfram
}

{ #category : #'as yet unclassified' }
WolframLink class >> environment: ep openString: str [

	^ self basicNew
		  handler: (self wsopen: ep handler string: str);
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframLink class >> wsclose: handler [

	^ self
		  ffiCall: #( void WSClose #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink class >> wsopen: ep string: str [

	^ self
		  ffiCall:
		  #( void #* WSOpenString #( void #* ep #, const char #* str #, NULL ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> head: head arguments: args [

	^ WolframExpression basicNew
		  handler: self handler;
		  head: head;
		  arguments:
			  (args collect: [ :arg | arg asWolframExpressionInLink: self ]);
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframLink >> releaseHandler [

	self class wsclose: self handler
]
