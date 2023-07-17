Extension { #name : #Dictionary }

{ #category : #'*Wolfram' }
Dictionary >> reifyWolframExpressionOnLink: link [

	| args head |
	head := self at: #head.
	args := self at: #arguments.

	^ head = '__symbol'
		  ifTrue: [ link symbol: args first ]
		  ifFalse: [
			  link
				  head: head
				  arguments:
				  (args collect: [ :arg | arg reifyWolframExpressionOnLink: link ]) ]
]
