Extension { #name : #Dictionary }

{ #category : #'*Wolfram' }
Dictionary >> reifyWolframExpressionOnLink: link [

	| args head |
	head := self at: #head.
	args := self at: #arguments.

	^ head = 'Symbol'
		  ifTrue: [ args first asSymbol ]
		  ifFalse: [
			  link
				  head: head
				  arguments:
				  (args collect: [ :arg | arg reifyWolframExpressionOnLink: link ]) ]
]
