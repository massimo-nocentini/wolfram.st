Extension { #name : #Dictionary }

{ #category : #'*Wolfram' }
Dictionary >> putOnLink: aLink [

	(aLink head: 'Association' arguments: self associations) putOnLink:
		aLink
]

{ #category : #'*Wolfram' }
Dictionary >> reifyWolframExpressionOnLink: link [

	| args head |
	head := self at: #head.
	args := self at: #arguments.

	^ head = '__symbol'
		  ifTrue: [ link symbol: args first asSymbol ]
		  ifFalse: [
			  head = '__arbitrary_precision_number'
				  ifTrue: [
					  link
						  arbitraryPrecisionNumber: args first
						  head: args second asSymbol ]
				  ifFalse: [
					  link
						  head: head
						  arguments:
						  (args collect: [ :arg |
							   arg reifyWolframExpressionOnLink: link ]) ] ]
]
