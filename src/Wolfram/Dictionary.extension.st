Extension { #name : #Dictionary }

{ #category : #'*Wolfram' }
Dictionary >> reifyWolframExpressionOnLink: link [

	| args head |
	head := self at: #head.
	args := self at: #arguments.

	^ head = 'Symbol'
		  ifTrue: [
			  | f |
			  f := args first.

			  f isDictionary
				  ifTrue: [ f reifyWolframExpressionOnLink: link ]
				  ifFalse: [ f asSymbol ] ]
		  ifFalse: [
			  link
				  head: head
				  arguments:
				  (args collect: [ :arg | arg reifyWolframExpressionOnLink: link ]) ]
]
