Class {
	#name : #WolframLink,
	#superclass : #WolframHandleHolder,
	#category : #Wolfram
}

{ #category : #expressions }
WolframLink >> argument: arg [

	^ self head: 'Evaluate' arguments: { arg }
]

{ #category : #'as yet unclassified' }
WolframLink >> endPacket [

	^ self
		  ffiCall: #( int WSEndPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> flush [

	^ self
		  ffiCall: #( int WSFlush #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #expressions }
WolframLink >> head: head arguments: args [

	^ WolframExpression basicNew
		  link: self;
		  head: head;
		  arguments: args;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframLink >> nextPacket [

	^ self
		  ffiCall: #( int WSNextPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putExpression: exp [

	^ exp putOnLink: self
]

{ #category : #'as yet unclassified' }
WolframLink >> putFunction: f arity: argc [

	^ self
		  ffiCall:
		  #( int WSPutFunction #( void #* handler #, const char #* f #, int
		        argc ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putInteger: i [

	^ self
		  ffiCall: #( int WSPutInteger #( void #* handler #, int i ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> releaseHandler [

	^ self
		  ffiCall: #( void WSClose #( void #* handler ) )
		  module: WolframLibrary
]
